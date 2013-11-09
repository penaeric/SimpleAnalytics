//
//  EPMessage.h
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EPConstants.h"

@interface EPMessage : NSObject

@property (strong, nonatomic) NSString *eventName;
@property (strong, nonatomic) NSDictionary *payload;
@property (assign, nonatomic) EPMessageStatus status;

/** A Dictionary representation of the Message. Helpful to transform the message to json
 */
@property (strong, nonatomic, readonly) NSDictionary *dictionaryForJson;

- (id)initWithName:(NSString *)name;
- (NSDate *)eventDate;

@end
