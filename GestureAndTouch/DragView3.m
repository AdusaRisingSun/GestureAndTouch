//
//  DragView3.m
//  GestureAndTouch
//
//  Created by Adusa on 15/8/24.
//  Copyright © 2015年 Adusa. All rights reserved.
//

#import "DragView3.h"

@implementation DragView3
{
    CGFloat tx;
    CGFloat ty;
    CGFloat scale;
    CGFloat theta;
}

-(instancetype)initWithImage:(nullable UIImage *)animage
{
    self=[super initWithImage:animage];
    if (self) {
        self.userInteractionEnabled=YES;
        tx=0.0f;
        ty=0.0f;
        scale=1.0f;
        theta=0.0f;
        UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
        UIRotationGestureRecognizer *rotation=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotation:)];
        self.gestureRecognizers=@[pan,pinch,rotation];
        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
            recognizer.delegate=self;
        }
    }
    return self;
}

//协议方法，使多个手势识别器同时运行
-(BOOL)gestureRecognizer:(nonnull UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint translation=[pan translationInView:[self superview]];
    [self updateTransformWithOffset:translation];
}

-(void)handlePinch:(UIPinchGestureRecognizer*)pinch
{
    scale=pinch.scale;
    [self updateTransformWithOffset:CGPointZero];
}

-(void)handleRotation:(UIRotationGestureRecognizer *)rotation
{
    theta=rotation.rotation;
    [self updateTransformWithOffset:CGPointZero];
}

-(void)updateTransformWithOffset:(CGPoint)translation
{
    self.transform=CGAffineTransformMakeTranslation(translation.x+tx, translation.y+ty);
    self.transform=CGAffineTransformRotate(self.transform, theta);
    self.transform=CGAffineTransformScale(self.transform, scale, scale);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];
    tx=self.transform.tx;
    ty=self.transform.ty;
    //初始化不成功 UIImageView并没有scale和rotation属性
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    //三连击复原
    if (touch.tapCount==3) {
        self.transform=CGAffineTransformIdentity;
        tx=0.0f;
        ty=0.0f;
        scale=1.0f;
        theta=0.0f;
    }
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
