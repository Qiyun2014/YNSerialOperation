//
//  ViewController.m
//  Demo
//
//  Created by qiyun on 16/3/22.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "ViewController.h"
#import "YNSerialOperation.h"
#import "PDFMapTrackCollectionView.h"

@interface ViewController ()

@property (nonatomic,strong) PDFMapTrackCollectionView *collectionView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.collectionView = [[PDFMapTrackCollectionView alloc] initWithFrame:CGRectInset(self.view.frame, 150, 100) viewLayou:nil];
    [self.view addSubview:self.collectionView];
    
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
