//
//  BitmapCollisionDetection.m
//  GestureAndTouch
//
//  Created by Adusa on 15/8/25.
//  Copyright © 2015年 Adusa. All rights reserved.
//

#import "BitmapCollisionDetection.h"

@implementation BitmapCollisionDetection
{
    NSData *data;
}
//return the offset for the alpha pixel at (x,y)for RGBA
//4-bytes-per-pixel bitmap data
static NSUInteger alphaOffset(NSUInteger x,NSUInteger y,NSUInteger w)
{
    return y*w*4+x*4;
}
//Return the bitmap from a provide image
-(NSData *)getBitmapFromImage:(UIImage *)image
{
    if(!image)
    return nil;
    //Establish color space
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    if (colorSpace==NULL) {
        NSLog(@"Error creating RGB color space");
        return  nil;
    }
    //Establish context
    int width=image.size.width;
    int height=image.size.height;
    CGContextRef context=CGBitmapContextCreate(NULL, width, height, 8, width*4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(colorSpace);
    if (context==NULL) {
        NSLog(@"Error creating context");
        return nil;
    }
    //Draw source into context bytes
    CGRect rect=(CGRect){.size=image.size};
    CGContextDrawImage(context, rect, image.CGImage);
    //Create NSdata from bytes
    data=[NSData dataWithBytes:CGBitmapContextGetData(context) length:width*height*4];
    CGContextRelease(context);
    return data;
}

-(instancetype)initWithImage:(nullable UIImage *)animage
{
    self=[super initWithImage:animage];
    if (self) {
        self.userInteractionEnabled=YES;
        self.backgroundColor=[UIColor lightGrayColor];
        data=[self getBitmapFromImage:animage];
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

-(BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
{
    if (!CGRectContainsPoint(self.bounds, point)) {
        return NO;
    }
    NSLog(@"w=%f,h=%f",self.bounds.size.width,self.bounds.size.height);
    Byte*bytes=(Byte*)data.bytes;
    uint offset=alphaOffset(point.x, point.y, self.bounds.size.width);
    NSLog(@"x=%f,y=%f",point.x,point.y);
    return (bytes[offset]>85);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
