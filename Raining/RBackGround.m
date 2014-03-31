//
//  RBackGround.m
//  Raining
//
//  Created by Asfanur Arafin on 31/03/2014.
//  Copyright (c) 2014 asfanur arafin. All rights reserved.
//

#import "RBackGround.h"

@implementation RBackGround

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *color = [UIColor colorWithRed:.333 green:.333 blue:.333 alpha:1];
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)color.CGColor,(id)[UIColor colorWithRed:.667 green:.667 blue:.667 alpha:1].CGColor,(id)[UIColor whiteColor].CGColor, nil];
    CGFloat gradientLocations[] = {0,.5,1};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    CGContextDrawLinearGradient(context, gradient, self.frame.origin, CGPointMake(self.frame.size.width, self.frame.size.height), 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
}


@end
