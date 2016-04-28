//
//  PDFMapTrackCollectionView.m
//  Demo
//
//  Created by qiyun on 16/4/22.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "PDFMapTrackCollectionView.h"


@interface PDFMapTrackCollectionView ()<PDLCollectionCellDelegate>

@property (nonatomic, copy) NSMutableArray *datas;
@property (nonatomic, strong) PDLMapTrackAccessoryView  *accessoryView;

@end

@implementation PDFMapTrackCollectionView


- (id)initWithFrame:(CGRect)frame viewLayou:(UICollectionViewLayout *)viewLayout itemsCount:(NSInteger)count{
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //flowLayout.headerReferenceSize = CGSizeMake(self.frame.size.width, 30);

    if (self = [super initWithFrame:frame collectionViewLayout:viewLayout?viewLayout:flowLayout]) {
            
        self = [[PDFMapTrackCollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        [self registerClass:[PDFMapTrackCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        
        _datas = [[NSMutableArray alloc] initWithCapacity:9];
        for (int i = 0; i < count; i++) {
            
            NSString *imageName = [NSString stringWithFormat:@"%d",i];
            [_datas addObject:imageName];
        }
        self.showScrollRoll = NO;
        self.delegate = self;
        self.dataSource = self;
        //此处给其增加长按手势，用此手势触发cell移动效果
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        [self addGestureRecognizer:longGesture];
        
        self.alpha = 0;
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionFlipFromLeft
                         animations:^{ self.alpha = 1.0; } completion:nil];
    }
    return self;
}


- (void)accessoryItems:(BOOL)show withFrame:(CGRect)frame superView:(UIView *)superView{
    
    if (show) {
        
        if (!CGRectIsEmpty(frame) && !CGRectIsNull(frame)) {
            
            self.accessoryView.frame = CGRectInset(frame, frame.size.width/2 - 1, frame.size.height/2 - 1);
            
            [UIView animateWithDuration:0.2
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 
                                 self.accessoryView.frame = frame;
                                 
                             } completion:^(BOOL finished) {
                                 
                                 [self.accessoryView imageSelectedIndex:0];
                                 self.accessoryView.frame = frame;
                             }];
        }
        [superView addSubview:self.accessoryView];
    }else{
        
        [UIView animateWithDuration:0.2
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             
                             self.accessoryView.frame = CGRectInset(frame, frame.size.width/2 - 1, frame.size.height/2 - 1);
                             
                         } completion:^(BOOL finished) {
                             
                             [self.accessoryView removeAllSubViews];
                         }];
    }
}

- (void)removeFromSuperview{
        
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{ self.alpha = 0.0; } completion:^(BOOL finished){
                         
                         //[self removeFromSuperview];
                     }];
}

- (NSInteger)itemCount{
    
    return _datas.count;
}

- (PDLMapTrackAccessoryView *)accessoryView{
    
    if (!_accessoryView && CGRectIsEmpty(_accessoryView.frame)) {
        
        _accessoryView = [[PDLMapTrackAccessoryView alloc] initWithFrame:CGRectZero backgroundImage:[UIImage imageNamed:@"map_layer choose_bg"]];
    }
    
    return _accessoryView;
}


- (void)setItemImages:(NSArray *)itemImages{
    
    _itemImages = itemImages;
    
    if (itemImages.count >= 1) {
        
        [self reloadData];
    }
}

- (void)setShowBorder:(BOOL)showBorder{
    
    _showBorder = showBorder;
    
    if (_showBorder) {
        
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}

- (void)setShowScrollRoll:(BOOL)showScrollRoll{
    
    _showScrollRoll = showScrollRoll;
    
    self.showsVerticalScrollIndicator = showScrollRoll;
    self.showsHorizontalScrollIndicator = showScrollRoll;
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datas.count;
}

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PDFMapTrackCollectionCell * cell = (PDFMapTrackCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor colorWithRed:((60 * indexPath.row) / 255.0) green:((70 * indexPath.row)/255.0) blue:((80 * indexPath.row)/255.0) alpha:1.0f];
    //cell.botlabel.text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];
    cell.delegate = self;
    
    /* 设置图片背景 */
    if (self.itemImages.count > indexPath.row) {
        
        cell.topImage.defaultImage = self.itemImages[indexPath.row];
        cell.topImage.indexPath = indexPath;
    }
    
    if ([self.collectionDelegate respondsToSelector:@selector(collectionView:collectionViewCell:cellForRowAtIndexPath:)]) {
        [self.collectionDelegate collectionView:collectionView collectionViewCell:cell cellForRowAtIndexPath:indexPath];
    }

    //NSLog(@"frame = %@",NSStringFromCGRect(cell.frame));
    return cell;
}

/*
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PDFMapTrackCollectionCell *cell = (PDFMapTrackCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = false;
    cell.highlighted = true;
}
 */

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.width);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat spaceZone = (CGRectGetHeight(self.bounds) - (CGRectGetWidth(self.bounds) * [collectionView numberOfItemsInSection:0]))/[collectionView numberOfItemsInSection:0];
    return UIEdgeInsetsMake(spaceZone/2, 5, 5, 5);
}

//定义每个UICollectionView之前的距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    CGFloat spaceZone = (CGRectGetHeight(self.bounds) - (CGRectGetWidth(self.bounds) * [collectionView numberOfItemsInSection:0]))/[collectionView numberOfItemsInSection:0];
    return spaceZone;
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //cell.backgroundColor = [UIColor whiteColor];
    
    if ([self.collectionDelegate respondsToSelector:@selector(collectionView:didSelectRowAtIndexPath:)]) {
        
        [self.collectionDelegate collectionView:collectionView didSelectRowAtIndexPath:indexPath];
    }
}


- (void)collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didSelectdRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.collectionDelegate respondsToSelector:@selector(collectionView:collectionCell:imageView:didSelectdRowAtIndexPath:)]) {
        [self.collectionDelegate collectionView:self collectionCell:cell imageView:imageView didSelectdRowAtIndexPath:indexPath];
    }
}

- (void)collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didUnSelectdRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.collectionDelegate respondsToSelector:@selector(collectionView:collectionCell:imageView:didUnSelectdRowAtIndexPath:)]) {
        [self.collectionDelegate collectionView:self collectionCell:cell imageView:imageView didUnSelectdRowAtIndexPath:indexPath];
    }
}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据
    id objc = [_datas objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [_datas removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [_datas insertObject:objc atIndex:destinationIndexPath.item];
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor grayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
    label.text = @"这是collectionView的头部";
    label.font = [UIFont systemFontOfSize:20];
    [headerView addSubview:label];
    return headerView;
}


- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    //判断手势状态
    switch (longGesture.state) {
            
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self indexPathForItemAtPoint:[longGesture locationInView:self]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            if (version >= 9.0) [self beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            if (version >= 9.0) [self updateInteractiveMovementTargetPosition:[longGesture locationInView:self]];
            break;
            
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            if (version >= 9.0) [self endInteractiveMovement];
            break;
            
        default:
            if (version >= 9.0) [self cancelInteractiveMovement];
            break;
    }
}

@end


#pragma mark    -   PDLMapTrackAccessoryView

@interface PDLMapTrackAccessoryView () 

@property (nonatomic, strong) PDFMapTrackCollectionView   *itemCollectionView;

@end

@implementation PDLMapTrackAccessoryView{
    
    CGFloat wid ;
    CGFloat hei ;
}


- (instancetype)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)bgImage{
    
    if (self = [super initWithFrame:frame]) {
        
        self.image = bgImage;
        self.contentMode = UIViewContentModeScaleToFill;
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
}

- (PDFMapTrackCollectionView *)itemCollectionView{
    
    if (!_itemCollectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        wid = CGRectGetWidth(self.bounds);
        hei = CGRectGetHeight(self.bounds);
        
        CGRect rect = CGRectMake(wid * 0.08, hei * 0.1, wid * 0.77, hei * 0.65);
        
        _itemCollectionView = [[PDFMapTrackCollectionView alloc] initWithFrame:rect viewLayou:flowLayout itemsCount:3];
        _itemCollectionView.backgroundColor = [UIColor redColor];
        _itemCollectionView.showBorder = YES;
        _itemCollectionView.collectionDelegate = self;
        [_itemCollectionView setItemImages:@[[UIImage imageNamed:@"main_camera_shoot"],[UIImage imageNamed:@"main_camera_video_shooting"],[UIImage imageNamed:@"main_camera_setting"]]];
    }
    
    return _itemCollectionView;
}

- (void)imageSelectedIndex:(NSInteger)index{
    
    [self addSubview:self.itemCollectionView];
    if (_footTitles.count <= 0 || _footTitles) [self setFootTitles:@[@"2D地图",@"卫星地图",@"混合地图"]];
}

- (void)setFootTitles:(NSArray *)footTitles{
    
    _footTitles = footTitles;
    
    if (_footTitles.count >= 1) {
        
        [self.footTitles enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(wid * 0.08 + (idx * wid * 0.77/3), hei * 0.77, wid * 0.77/3, hei * 0.2)];
            label.text = obj;
            label.font = [UIFont systemFontOfSize:10];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            [self addSubview:label];
        }];
    }
}

- (void)removeAllSubViews{
    
    [_itemCollectionView removeFromSuperview];
    _itemCollectionView = nil;
    for (UIView *view in self.subviews) { [view removeFromSuperview]; }
    [self removeFromSuperview];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:_itemCollectionView]) {
        
        if (indexPath.row == 1) {
            NSLog(@"点击录像的cell。。。");
        }
    }
    
    NSLog(@"indexPath = %@",indexPath);
}

- (void)collectionView:(UICollectionView *)collectionView collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didSelectdRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:_itemCollectionView]) {
        
        if (indexPath.row == 1) {
            
            NSLog(@"点击图像 indexPath = %@",indexPath);
            imageView.seletedImage = [UIImage imageNamed:@"main_camera_video_stop"];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didUnSelectdRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"取消选中图像 indexPath = %@",indexPath);
    imageView.seleted = NO;
}

- (void)collectionView:(UICollectionView *)collectionView collectionViewCell:(UICollectionViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:_itemCollectionView]) {
        
        collectionView.backgroundColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor blackColor];
    }else{
        
        collectionView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
}

- (void)dealloc{
    
    [self removeAllSubViews];
}

@end




