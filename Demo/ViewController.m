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

@interface ViewController ()<PDFCollectionViewDelegate>

@property (nonatomic,strong) PDFMapTrackCollectionView *collectionView;

@end

@implementation ViewController

- (void)collectionView:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexPath = %@",indexPath);
}

- (void)collectionView:(UICollectionView *)collectionView collectionViewCell:(UICollectionViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    collectionView.backgroundColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor blackColor];
}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    self.collectionView.frame = CGRectMake((self.view.bounds.size.width * 0.9), (self.view.bounds.size.height * 0.20), (self.view.bounds.size.width * 0.1), (self.view.bounds.size.height * 0.6));;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.collectionView = [[PDFMapTrackCollectionView alloc] initWithFrame:CGRectZero viewLayou:nil itemsCount:3];
    self.collectionView.collectionDelegate = self;
    self.collectionView.showBorder = YES;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView setItemImages:@[[UIImage imageNamed:@"main_camera_shoot"],[UIImage imageNamed:@"main_camera_video_shooting"],[UIImage imageNamed:@"main_camera_setting"]]];
    
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
