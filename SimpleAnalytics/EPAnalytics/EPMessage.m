//
//  EPMessage.m
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import "EPMessage.h"

@interface EPMessage()

@property (strong, nonatomic) NSDate *date;

@end


@implementation EPMessage


- (id)initWithName:(NSString *)name
{
    if ((self = [super init])) {
        self.eventName = name;
        self.date = [NSDate date];
        self.status = kEPWaiting;
    }
    
    return self;
}


- (NSDate *)eventDate
{
    return self.date;
}


- (NSDictionary *)dictionaryForJson
{
    NSDictionary *dictionary;
    
    if (!self.eventName) {
        dictionary = @{};
    } else if ([self.payload count] > 0) {
        dictionary = @{@"date": self.date.description,
                       @"name": self.eventName,
                       @"papyload": self.payload};
    } else {
        dictionary = @{@"date": self.date.description,
                       @"name": self.eventName};
    }
    
    return dictionary;
}


@end
