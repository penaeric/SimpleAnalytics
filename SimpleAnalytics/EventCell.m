//
//  EventCell.m
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import "EventCell.h"
#import "CircleView.h"
#import "EPConstants.h"
#import "UIColor+EventColor.h"

@implementation EventCell


- (void)updateStatusColor
{
    CGRect frame = CGRectMake(290, 12, 18, 18);
    CircleView *circleView = [[CircleView alloc] initWithFrame:frame];
    circleView.backgroundColor = [UIColor clearColor];
    circleView.color = [self circleViewColor];
    [self.contentView addSubview:circleView];
}


- (UIColor *)circleViewColor
{
    UIColor *color;
    
    if ([self.eventStatusLabel.text isEqualToString:EPMessageStatusForDisplay[kEPWaiting]]
        || [self.eventStatusLabel.text isEqualToString:EPMessageStatusForDisplay[kEPSending]]) {
        color = [UIColor yellowEventColor];
    } else if ([self.eventStatusLabel.text isEqualToString:EPMessageStatusForDisplay[kEPSent]]) {
        color = [UIColor greenEventColor];
    } else if ([self.eventStatusLabel.text isEqualToString:EPMessageStatusForDisplay[kEPError]]) {
        color = [UIColor redEventColor];
    } else {
        color = [UIColor blackColor];
    }
    
    return color;
}

@end
