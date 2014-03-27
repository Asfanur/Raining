//
//  RRainView.m
//  Raining
//
//  Created by Asfanur Arafin on 27/03/2014.
//  Copyright (c) 2014 asfanur arafin. All rights reserved.
//

#import "RRainView.h"

@implementation RRainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;  
}



- (void)drawRect:(CGRect)rect
{
    
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0.0, 0.0)];
    [bezierPath addLineToPoint:CGPointMake(0.0, 30.0)];
    [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width, 0.0)];
    [bezierPath addLineToPoint:CGPointMake(0.0, 0.0)];
    
    
    [bezierPath closePath];
    [[UIColor colorWithRed:0.343f green:0.562f blue:1.0f alpha:1] setFill];
    [bezierPath fill];
    [[UIColor colorWithRed:0.343f green:0.562f blue:1.0f alpha:1] setStroke];
    
    //[[UIColor blackColor] setStroke];
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
    
    
    
}

@end
