//
//  PDFMapTrackCollectionView.h
//  Demo
//
//  Created by qiyun on 16/4/22.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PDFCollectionViewDelegate <NSObject>


@optional

/**
 *  选中某一行的代理
 *
 *  @param collectionView 当前的collectionView
 *  @param indexPath      位置
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  cell布局显示的代码
 *
 *  @param collectionView 当前的collectionView
 *  @param cell           当前cell
 *  @param indexPath      位置
 */
- (void)collectionView:(UICollectionView *)collectionView collectionViewCell:(UICollectionViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PDFMapTrackCollectionView : UICollectionView
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

- (id)initWithFrame:(CGRect)frame viewLayou:(UICollectionViewLayout *)viewLayout itemsCount:(NSInteger)count;


@property (nonatomic, weak)     id<PDFCollectionViewDelegate> collectionDelegate;

@property (nonatomic, readonly) NSInteger itemCount;    /* 当前cell的个数 */
@property (nonatomic, copy)     NSArray *itemImages;    /* 设置当前cell的图片 */
@property (nonatomic)           BOOL showBorder;        /* 显示边缘线 */

@end
