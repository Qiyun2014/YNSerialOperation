//
//  ViewController.m
//  Demo
//
//  Created by qiyun on 16/3/22.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "ViewController.h"
#import "YNSerialOperation.h"
#import "PDLLayerManagerView.h"

@interface ViewController ()

@property (nonatomic, strong) PDLLayerManagerView *managerView;

@end

@implementation ViewController


- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.managerView = [[PDLLayerManagerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.managerView];
    
    self.managerView.backAction = ^(UIButton *button, BOOL finished){
        
        NSLog(@"返回...");
    };

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.managerView setWifi:66];
        [self.managerView setSatellite:66];
        [self.managerView setHandleBatteries:66];
        [self.managerView setFlyBatteries:66];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[YNSerialOperation shareInstanceWithOperation] addBlockOperationWithBlock:^{
            
            NSLog(@"1");
            
        } withName:@"1"];
        
        [[YNSerialOperation shareInstanceWithOperation] addBlockOperationWithBlock:^{
            
            NSLog(@"2");
            
        } withName:@"2"];
        
        [[YNSerialOperation shareInstanceWithOperation] addBlockOperationWithBlock:^{
            
            NSLog(@"3");
            
        } withName:@"3"];
        
        [[YNSerialOperation shareInstanceWithOperation] addBlockOperationWithBlock:^{
            
            NSLog(@"4");
            
        } withName:@"4"];
        
        
    });
}



@end
