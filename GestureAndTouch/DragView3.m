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
    CGFloat identifer;
}

-(instancetype)initWithImage:(nullable UIImage *)animage
{
    self=[super initWithImage:animage];
    NSLog(@"wocao");
    tx=0.0f;
    ty=0.0f;
    scale=1.0f;
    theta=0.0f;
    identifer=0.0f;
    if (self) {
        self.userInteractionEnabled=YES;
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
    float a=scale-1.0f;
    scale=MAX(0.5f , pinch.scale+a);
    scale=MIN(4.0f, scale);
    //NSLog(@"handlePinch'pinch.scale=%f",pinch.scale);
    //NSLog(@"handlePinch'scale=%f",scale);
    [self updateTransformWithOffset:CGPointZero];
}

-(void)handleRotation:(UIRotationGestureRecognizer *)rotation
{
//    NSLog(@"bandleRotation'rotation=%f",rotation.rotation);
//    theta=theta+rotation.rotation;
//    NSLog(@"bandleRotation'thrta=%f",theta);
    if (rotation.rotation>0) {
        if (rotation.rotation>identifer) {
            theta=theta+0.05;
        }else if (rotation.rotation<identifer) {
            theta=theta-0.05;
        }
    }
    if (rotation.rotation<0) {
        if (rotation.rotation<identifer) {
            theta=theta-0.05;
        }else if (rotation.rotation>identifer) {
            theta=theta+0.05;
        }
    }
    identifer=rotation.rotation;
    [self updateTransformWithOffset:CGPointZero];
}

-(void)updateTransformWithOffset:(CGPoint)translation
{
    self.transform=CGAffineTransformMakeTranslation(translation.x+tx, translation.y+ty);
    self.transform=CGAffineTransformRotate(self.transform, theta);
    if (scale<0.5)
    {
        self.transform=CGAffineTransformScale(self.transform, 0.5, 0.5);
    }else{
    self.transform=CGAffineTransformScale(self.transform, scale, scale);
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];
    tx=self.transform.tx;
    ty=self.transform.ty;
}

-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    
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
