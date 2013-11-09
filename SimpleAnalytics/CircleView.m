//
//  CircleView.m
//  SimpleAnalytics
//
//  Created by Eric Pena on 11/9/13.
//  Copyright (c) 2013 Eric Pena. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (void)drawRect:(CGRect)rect{
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
}

@end
