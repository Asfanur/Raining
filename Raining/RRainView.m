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
    
     UIBezierPath *bezierPath = [self getBezierPathForView:self];
    
        [[UIColor colorWithRed:0.343f green:0.562f blue:1.0f alpha:1] setFill];
    [bezierPath fill];
    [[UIColor colorWithRed:0.343f green:0.562f blue:1.0f alpha:1] setStroke];
    
    bezierPath.lineWidth = 2;
    [bezierPath stroke];
    
    
}

-(UIBezierPath *)getBezierPathForView:(UIView *)view {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:[self convertPoint:CGPointMake(self.bounds.size.width/2, self.bounds.origin.y) toView:view]];
    [bezierPath addLineToPoint:[self convertPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height/4) toView:view]];
    
    [bezierPath addLineToPoint:[self convertPoint:CGPointMake(self.bounds.origin.x, self.bounds.size.height/4) toView:view]];
    [bezierPath addLineToPoint:[self convertPoint:CGPointMake(self.bounds.size.width/2, self.bounds.origin.y) toView:view]];
    [bezierPath closePath];
    return bezierPath;

    
}

@end
