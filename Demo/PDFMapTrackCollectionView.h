//
//  PDFMapTrackCollectionView.h
//  Demo
//
//  Created by qiyun on 16/4/22.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFMapTrackCollectionCell.h"

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


/**
 *  点击当前cell上的图片元素
 *
 *  @param cell      UICollectionViewCell
 *  @param imageView PDFImageView
 *  @param indexPath indexPath
 */
- (void)collectionView:(UICollectionView *)collectionView collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didSelectdRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didUnSelectdRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@class PDLMapTrackAccessoryView;
@interface PDFMapTrackCollectionView : UICollectionView
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

- (id)initWithFrame:(CGRect)frame viewLayou:(UICollectionViewLayout *)viewLayout itemsCount:(NSInteger)count;


@property (nonatomic, weak)     id<PDFCollectionViewDelegate> collectionDelegate;

@property (nonatomic, readonly) NSInteger itemCount;    /* 当前cell的个数 */
@property (nonatomic, copy)     NSArray *itemImages;    /* 设置当前cell的图片 */
@property (nonatomic)           BOOL showBorder;        /* 显示边缘线 默认不显示*/
@property (nonatomic)           BOOL showScrollRoll;    /* 显示滚动轴 默认不显示*/
@property (nonatomic)           BOOL canBounds;         /* 弹性效果 */

/**
 *  显示附件视图的信息
 *
 *  @param show      是否显示
 *  @param frame     位置
 *  @param superView 父视图
 */
- (void)accessoryItems:(BOOL)show withFrame:(CGRect)frame superView:(UIView *)superView ;

@end



@interface PDLMapTrackAccessoryView : UIImageView<PDFCollectionViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)bgImage;

@property (nonatomic, readonly) NSInteger selectedIndex;    /* 获取默认选中的图片 */
@property (nonatomic, copy) NSArray *footTitles;            /* 脚标题文本 */


- (void)imageSelectedIndex:(NSInteger)index;                /* 设置默认选中的图片 */
- (void)removeAllSubViews;                                  /* 移除当前视图的所有子视图，包括本身 */

@end
