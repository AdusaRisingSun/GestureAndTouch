//
//  DragView2.m
//  GestureAndTouch
//
//  Created by Adusa on 15/8/24.
//  Copyright © 2015年 Adusa. All rights reserved.
//

#import "DragView2.h"

@implementation DragView2
-(instancetype)initWithImage:(nullable UIImage *)animage
{
    self=[super initWithImage:animage];
    if (self) {
        self.userInteractionEnabled=YES;
        //实例化手势识别器
        UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        self.gestureRecognizers=@[panGesture];
    }
    return self;
}

-(void)handlePan:(UIPanGestureRecognizer *)uigr
{
    CGPoint translation=[uigr translationInView:self.superview];
    //仿射变换
    CGAffineTransform transform=self.transform;
    transform.tx=translation.x;
    transform.ty=translation.y;
    self.transform=transform;
    if (uigr.state==UIGestureRecognizerStateEnded) {
        
        CGPoint newPoint=CGPointMake(self.center.x+self.transform.tx, self.center.y+self.transform.ty);
        float halfx=CGRectGetMidX(self.bounds);
        newPoint.x=MAX(halfx, newPoint.x);
        newPoint.x=MIN(self.superview.bounds.size.width-halfx, newPoint.x);
        
        float halfy=CGRectGetMidY(self.bounds);
        newPoint.y=MAX(halfy, newPoint.y);
        newPoint.y=MIN(self.superview.bounds.size.height-halfy, newPoint.y);
        self.center=newPoint;
        
        CGAffineTransform transform=self.transform;
        transform.tx=0.0f;
        transform.ty=0.0f;
        self.transform=transform;
        return;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
