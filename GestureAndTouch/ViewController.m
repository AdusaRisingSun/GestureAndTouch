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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DragView *drag=[[DragView alloc]initWithImage:[UIImage imageNamed:@"94cad1c8a786c9177582c830cb3d70cf3bc75731.jpg"]];
    drag.frame=CGRectMake(0, 100, 132, 204);
    [self.view addSubview:drag];
    
    DragView2 *drag2=[[DragView2 alloc]initWithImage:[UIImage imageNamed:@"501f448b145f788877acc7ca715aad52.jpg"]];
    drag2.frame=CGRectMake(132, 100, 132, 204);
    [self.view addSubview:drag2];
    
    DragView3 *drag3=[[DragView3 alloc]initWithImage:[UIImage imageNamed:@"92cdc35dc284fbdda66bef6757e03baf.jpg"]];
    drag3.frame=CGRectMake(264, 100, 132, 204);
    [self.view addSubview:drag3];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
