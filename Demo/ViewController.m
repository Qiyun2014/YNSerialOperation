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
#import "PDFMapTrackCollectionCell.h"

@interface ViewController ()<PDFCollectionViewDelegate>

@property (nonatomic, strong) PDFMapTrackCollectionView *collectionView;
@property (nonatomic, strong) PDFMapTrackCollectionView *flyCollectionView;


@end

@implementation ViewController

- (void)collectionView:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:self.collectionView]) {
        
        if (indexPath.row == 1) {
            NSLog(@"点击录像的cell。。。");
        }
    }
    
    NSLog(@"indexPath = %@",indexPath);
}

- (void)collectionView:(UICollectionView *)collectionView collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didSelectdRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:self.collectionView]) {
        
        if (indexPath.row == 1) {
            
            NSLog(@"点击图像 indexPath = %@",indexPath);
            
            imageView.seletedImage = [UIImage imageNamed:@"main_camera_video_stop"];
            
            if (imageView.seleted) {
               
                CGFloat origin_x = CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.collectionView.bounds) - CGRectGetWidth(self.view.bounds) * 0.3 - 10;
                
                /*   计算弹框所在的位置，(indexPath.row + 0.2)用于向下偏移一段距离，达到所需效果   */
                [self.collectionView accessoryItems:YES withFrame:CGRectMake(origin_x,
                                                                             self.collectionView.frame.origin.y + (self.collectionView.frame.size.height/3 * (indexPath.row + 0.2)),
                                                                             CGRectGetWidth(self.view.bounds) * 0.3,
                                                                             self.collectionView.frame.size.height/2.7)
                                          superView:self.view];
            }
        }
    } 
}

- (void)collectionView:(UICollectionView *)collectionView collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didUnSelectdRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"取消选中图像 indexPath = %@",indexPath);
    imageView.seleted = NO;
    
    if ([collectionView isEqual:self.collectionView]) {
        
        [self.collectionView accessoryItems:NO withFrame:CGRectNull superView:nil];
    }
}

- (void)collectionView:(UICollectionView *)collectionView collectionViewCell:(UICollectionViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:self.collectionView]) {
        
        collectionView.backgroundColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor blackColor];
    }else{
        
        collectionView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.collectionView = [[PDFMapTrackCollectionView alloc] initWithFrame:CGRectZero viewLayou:nil itemsCount:3];
    self.collectionView.collectionDelegate = self;
    self.collectionView.showBorder = YES;
    [self.view addSubview:self.collectionView];
    
    self.flyCollectionView = [[PDFMapTrackCollectionView alloc] initWithFrame:CGRectZero viewLayou:nil itemsCount:3];
    self.flyCollectionView.collectionDelegate = self;
    self.flyCollectionView.showBorder = NO;
    [self.view addSubview:self.flyCollectionView];
    
    self.collectionView.frame = CGRectMake((self.view.bounds.size.width * 0.92), (self.view.bounds.size.height * 0.25), (self.view.bounds.size.width * 0.08), (self.view.bounds.size.height * 0.5));;
    [self.collectionView setItemImages:@[[UIImage imageNamed:@"main_camera_shoot"],[UIImage imageNamed:@"main_camera_video_shooting"],[UIImage imageNamed:@"main_camera_setting"]]];
    
    self.flyCollectionView.frame = CGRectMake(0, (self.view.bounds.size.height * 0.22), (self.view.bounds.size.width * 0.1), (self.view.bounds.size.height * 0.46));;
    [self.flyCollectionView setItemImages:@[[UIImage imageNamed:@"main_icon_fly"],[UIImage imageNamed:@"main_icon_return"],[UIImage imageNamed:@"main_icon_follow"]]];
    

    
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
