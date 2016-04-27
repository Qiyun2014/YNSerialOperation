//
//  PDFMapTrackCollectionCell.h
//  Demo
//
//  Created by qiyun on 16/4/22.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFImageView;
@protocol PDLImageViewDelegate <NSObject>

/**
 *  选中imageView，及其所在的索引位置
 *
 *  @param imageView PDFImageView
 *  @param indexPath 索引位置
 */
- (void)imageView:(PDFImageView *)imageView didSelectdRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)imageView:(PDFImageView *)imageView didUnSelectdRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@protocol PDLCollectionCellDelegate <NSObject>

/**
 *  点击当前cell内容的代理
 *
 *  @param cell      UICollectionViewCell
 *  @param imageView PDFImageView
 *  @param indexPath indexPath
 */
- (void)collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didSelectdRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didUnSelectdRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@class PDFImageView;
@interface PDFMapTrackCollectionCell : UICollectionViewCell<PDLImageViewDelegate>

@property (nonatomic, strong) UILabel           *botlabel;
@property (nonatomic, strong) PDFImageView      *topImage;
@property (nonatomic, strong) UIButton          *item;

@property (nonatomic, weak) id<PDLCollectionCellDelegate> delegate;

@end


@interface PDFImageView : UIImageView

@property (nonatomic, copy) UIImage *seletedImage;    /*  选中图片  */
@property (nonatomic, copy) UIImage *defaultImage;    /*  默认图片  */
@property (nonatomic, assign) BOOL seleted;         /*  是否选中，默认为NO */
@property (nonatomic, copy) NSIndexPath *indexPath;   /*  当前所在的位置   */

@property (nonatomic, weak) id<PDLImageViewDelegate> delegate;

@end
