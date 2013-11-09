//
//  EPAnalytics.h
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EPAnalytics;

@protocol EPAnalyticsDelegate <NSObject>

@optional
- (void)messagesWereUpdated;

@end

@interface EPAnalytics : NSObject

/** The only instance of EPAnalytics
 *
 * Allows to send messages to the specified URL
 */
+ (EPAnalytics *)sharedInstance;


/** Add a message to be sent
 *
 * @param eventName Name of the event
 */
- (void)sendEvent:(NSString *)eventName;


/** Add a message to be sent
 *
 * @param eventName Name of the event
 * @param payload Key/Value pairs
 */
- (void)sendEvent:(NSString *)eventName withPayload:(NSDictionary *)payload;


/** Returns all the messages sent to the instance */
- (NSArray *)messages;


@property (weak, nonatomic) id<EPAnalyticsDelegate> delegate;

@end
