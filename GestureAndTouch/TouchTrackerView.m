//
//  TouchTrackerView.m
//  GestureAndTouch
//
//  Created by Adusa on 15/8/25.
//  Copyright (c) 2015年 Adusa. All rights reserved.
//

#import "TouchTrackerView.h"

@implementation TouchTrackerView
{
    UIBezierPath *path;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled=NO;
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    path=[UIBezierPath bezierPath];
    path.lineWidth=4.0f;
    UITouch *touch=[touches anyObject];
    [path moveToPoint:[touch locationInView:self]];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    [path addLineToPoint:[touch locationInView:self]];
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    [path addLineToPoint:[touch locationInView:self]];
    [self setNeedsDisplay];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
-(void)drawRect:(CGRect)rect
{
    [path stroke];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
