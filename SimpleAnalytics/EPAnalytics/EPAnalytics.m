//
//  EPAnalytics.m
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import "EPAnalytics.h"
#import "EPMessage.h"

@interface EPAnalytics()

@property (strong, nonatomic) NSMutableArray *epMessages;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *repeatingTimer;
@property (assign, nonatomic) CGFloat timeInterval;
@property (strong, atomic) NSMutableDictionary *inTransit;
@property (strong, nonatomic) NSString *url;

@end

@implementation EPAnalytics

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}


+ (EPAnalytics *)sharedInstance
{
    static EPAnalytics *sharedInstance = nil;
    
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

// How often should we send the Messages
- (CGFloat)timeInterval
{
    return 3.0;
}


- (NSArray *)messages
{
    return [self.epMessages copy];
}


- (void)sendEvent:(NSString *)eventName
{
    [self sendEvent:eventName withPayload:@{}];
}


- (void)sendEvent:(NSString *)eventName withPayload:(NSDictionary *)payload
{
    EPMessage *message = [[EPMessage alloc] initWithName:eventName];
    message.payload = payload;
    
    [self.epMessages addObject:message];
    
    [self.delegate messagesWereUpdated];
    
    [self queueEvents];
}


#pragma mark - Lazy-instantiated properties

- (NSMutableArray *)epMessages
{
    if (!_epMessages) {
        _epMessages = [[NSMutableArray alloc] init];
    }
    
    return _epMessages;
}


- (NSString *)url
{
    if (!_url) {
        _url = @"http://nsdev.io/api/";
    }
    
    return _url;
}


#pragma mark - Timer Functions

- (void)queueEvents
{
    if ([self.timer isValid]) {
#ifdef DEBUG
        NSLog(@"\tTimer is Valid: Will have to wait!!!");
#endif
    } else {
#ifdef DEBUG
        NSLog(@"\tTimer is Invalid: Sending events");
#endif
        [self scheduleSendEvents];
    }
}


- (void)scheduleSendEvents
{
    [self sendEvents];
    
    // Ensures that there's always a timer running so that no messages are left behind
    if (![self.repeatingTimer isValid]) {
        self.repeatingTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                               target:self
                                                             selector:@selector(extraCheck)
                                                             userInfo:nil
                                                              repeats:YES];
    }
    
    // Helps to make sure that messages are sent only every TimeInterval
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                  target:self
                                                selector:@selector(queueEvents)
                                                userInfo:nil
                                                 repeats:NO];
}


- (void)sendEvents
{
#ifdef DEBUG
    NSLog(@"Event Fired: %@", [NSDate date]);
#endif
    if (!self.inTransit) {
        self.inTransit = [[NSMutableDictionary alloc] init];
    }
    NSMutableArray *messagesToSend = [[NSMutableArray alloc] init];
    NSMutableArray *messagesToSendInJsonFormat = [[NSMutableArray alloc] init];
    NSNumber *requestId = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSinceReferenceDate]];
    
    for (EPMessage *message in self.epMessages) {
        if (message.status == kEPWaiting || message.status == kEPError) {
            message.status = kEPSending;
            [messagesToSendInJsonFormat addObject:message.dictionaryForJson];
            [messagesToSend addObject:message];
        }
    }
    
    if ([messagesToSend count] > 0) {
        [self.inTransit setObject:messagesToSend forKey:requestId];
        
        [self postRequestWithMessages:[messagesToSendInJsonFormat copy] andRequestId:requestId];
        
        [self.delegate messagesWereUpdated];
    }
    
    [self.repeatingTimer invalidate];
}


// Ensures that no messages are left in the queue
- (void)extraCheck
{
    if (![self.timer isValid]) {
#ifdef DEBUG
        NSLog(@"Extra check");
#endif
        [self sendEvents];
    }
}


#pragma mark - POST messages

- (void)postRequestWithMessages:(NSArray *)messages andRequestId:(NSNumber *)requestId
{
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:(id)messages
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&err];
#ifdef DEBUG
    NSLog(@"JSON = %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
#endif
    
    NSURL *serverUrl = [NSURL URLWithString:self.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverUrl
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:120];
    [request setURL:serverUrl];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
                               
#ifdef DEBUG
                               NSLog(@"POST::RequestId: %@ to {%@}", requestId, self.url);
                               NSLog(@"ResponseCode: %d", responseCode);
#endif
                               
                               if (!connectionError && responseCode == 200) {
                                   [self updateMessagesWithRequestId:requestId toStatus:kEPSent];
                               } else {
                                   [self updateMessagesWithRequestId:requestId toStatus:kEPError];
                               }
                           }];
}


- (void)updateMessagesWithRequestId:(NSNumber *)requestId toStatus:(EPMessageStatus)status
{
    NSArray * messages = self.inTransit[requestId];
    
    for (EPMessage *message in messages) {
        message.status = status;
    }
    
    [self.inTransit removeObjectForKey:requestId];
    
    [self.delegate messagesWereUpdated];
    
    // Trigger the timer so that events are re-sent
    if (status == kEPError && ![self.repeatingTimer isValid]) {
        self.repeatingTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                               target:self
                                                             selector:@selector(queueEvents)
                                                             userInfo:nil
                                                              repeats:NO];
    }
}


@end