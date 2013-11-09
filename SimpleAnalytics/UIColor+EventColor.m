//
//  UIColor+EventColor.m
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import "UIColor+EventColor.h"

@implementation UIColor (EventColor)

+ (UIColor *)greenEventColor
{
    static UIColor *greenColor = nil;
    
    if (!greenColor) {
        greenColor = [UIColor colorWithRed:32/255.0 green:209/255.0 blue:39/255.0 alpha:1];
    }
    
    return greenColor;
}


+ (UIColor *)yellowEventColor
{
    static UIColor *yellowColor = nil;
    
    if (!yellowColor) {
        yellowColor = [UIColor colorWithRed:246/255.0 green:215/255.0 blue:48/255.0 alpha:1];
    }
    
    return yellowColor;
}


+ (UIColor *)redEventColor
{
    static UIColor *redColor = nil;
    
    if (!redColor) {
        redColor = [UIColor colorWithRed:226/255.0 green:36/255.0 blue:24/255.0 alpha:1];
    }
    
    return redColor;
}

@end
