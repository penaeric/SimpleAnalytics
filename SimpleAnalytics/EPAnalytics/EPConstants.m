//
//  EPConstants.m
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import "EPConstants.h"

@implementation EPConstants

NSString *const EPMessageStatus_String[] = {
    [kEPWaiting] = @"Waiting",
    [kEPSending] = @"Sending",
    [kEPSent] = @"Sent",
    [kEPError] = @"Error"
};


NSString *const EPMessageStatusForDisplay[] = {
    [kEPWaiting] = @"Waiting...",
    [kEPSending] = @"Sending...",
    [kEPSent] = @"Sent",
    [kEPError] = @"Error. Retrying..."
};

@end
