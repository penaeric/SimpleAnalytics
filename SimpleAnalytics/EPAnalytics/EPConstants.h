//
//  EPConstants.h
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EPConstants : NSObject

/** Message Status
 */
typedef enum EPMessageStatus : NSInteger {
    kEPWaiting = 1,
    kEPSending,
    kEPSent,
    kEPError
} EPMessageStatus;

/** Transform EPMessateStatus to a basic String representation
 */
extern NSString *const EPMessageStatus_String[];

/** Transform EPMessateStatus to String for Display purposes
 */
extern NSString *const EPMessageStatusForDisplay[];

@end
