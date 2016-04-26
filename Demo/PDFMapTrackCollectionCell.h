//
//  PDFMapTrackCollectionCell.h
//  Demo
//
//  Created by qiyun on 16/4/22.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFImageView;
@interface PDFMapTrackCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel       *botlabel;
@property (nonatomic, strong) PDFImageView   *topImage;
@property (nonatomic, strong) UIButton      *item;

@end


@interface PDFImageView : UIImageView

@end
