//
//  DragView.m
//  GestureAndTouch
//
//  Created by Adusa on 15/8/24.
//  Copyright © 2015年 Adusa. All rights reserved.
//

#import "DragView.h"

@implementation DragView
{
    CGPoint startPoint;
}

-(instancetype)initWithImage:(UIImage *)anImage
{
    self=[super initWithImage:anImage];
    if (self) {
        self.userInteractionEnabled=YES;
    }
    return self;
}

-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    startPoint=[[touches anyObject]locationInView:self];
    [self.superview bringSubviewToFront:self];
}

-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    CGPoint touchPoint=[[touches anyObject]locationInView:self];
    CGPoint newPoint=CGPointMake(self.center.x+touchPoint.x-startPoint.x, self.center.y+touchPoint.y-startPoint.y);
    self.center=newPoint;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
