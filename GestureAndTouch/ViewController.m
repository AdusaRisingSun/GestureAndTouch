//
//  ViewController.m
//  GestureAndTouch
//
//  Created by Adusa on 15/8/24.
//  Copyright © 2015年 Adusa. All rights reserved.
//

#import "ViewController.h"
#import "DragView.h"
#import "DragView2.h"
#import "DragView3.h"
#import "BitmapCollisionDetection.h"
#import "TouchTrackerView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    DragView *drag=[[DragView alloc]initWithImage:[UIImage imageNamed:@"94cad1c8a786c9177582c830cb3d70cf3bc75731.jpg"]];
    drag.frame=CGRectMake(0, 100, 132, 204);
    [self.view addSubview:drag];
    
    DragView2 *drag2=[[DragView2 alloc]initWithImage:[UIImage imageNamed:@"501f448b145f788877acc7ca715aad52.jpg"]];
    drag2.frame=CGRectMake(132, 100, 132, 204);
    [self.view addSubview:drag2];
    
    DragView3 *drag3=[[DragView3 alloc]initWithImage:[UIImage imageNamed:@"92cdc35dc284fbdda66bef6757e03baf.jpg"]];
    drag3.frame=CGRectMake(264, 100, 132, 204);
    [self.view addSubview:drag3];
    
    BitmapCollisionDetection *bcd=[[BitmapCollisionDetection alloc]initWithImage:[UIImage imageNamed:@"icotrip-violence-33.png"]];
    bcd.frame=CGRectMake(10, 310, 120, 90);
    [self.view addSubview:bcd];
    
    TouchTrackerView *ttv=[[TouchTrackerView alloc]initWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, self.view.bounds.size.height-400)];
    [self.view addSubview:ttv];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
