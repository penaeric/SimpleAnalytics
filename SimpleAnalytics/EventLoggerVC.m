//
//  EventLoggerVC.m
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import "EventLoggerVC.h"
#import "EPAnalytics.h"

@interface EventLoggerVC ()

@property (nonatomic, strong) EPAnalytics *analytics;

@end

@implementation EventLoggerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.analytics = [EPAnalytics sharedInstance];
}


- (IBAction)addSampleEventButtonPressed:(id)sender
{
    int rndValue = 0 + arc4random() % (5);
    
    switch (rndValue) {
        case 0:
            [self.analytics sendEvent:@"Some Event"];
            break;
        case 1:
            [self.analytics sendEvent:@"Event with Payload" withPayload:@{@"key":@"value"}];
            break;
        case 2:
            [self.analytics sendEvent:@"Simple Logging"];
            break;
        case 3:
            [self.analytics sendEvent:@"Payload" withPayload:@{@"key":@"value", @"key02": @"val02"}];
            break;
        default:
            [self.analytics sendEvent:@"Some other Event"];
            break;
    }
}

@end
