//
//  PDFMapTrackCollectionView.m
//  Demo
//
//  Created by qiyun on 16/4/22.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "PDFMapTrackCollectionView.h"
#import "PDFMapTrackCollectionCell.h"

@implementation PDFMapTrackCollectionView{
    
    NSMutableArray *_dataSource;
}

- (id)initWithFrame:(CGRect)frame viewLayou:(UICollectionViewLayout *)viewLayout{
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //flowLayout.headerReferenceSize = CGSizeMake(self.frame.size.width, 30);

    if (self = [super initWithFrame:frame collectionViewLayout:viewLayout?viewLayout:flowLayout]) {
        
        _dataSource = [NSMutableArray array];
        
        for (int i = 1; i <= 5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%d",i];
            [_dataSource addObject:imageName];
        }
    
        self = [[PDFMapTrackCollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[PDFMapTrackCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        

        //此处给其增加长按手势，用此手势触发cell移动效果
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        [self addGestureRecognizer:longGesture];
    }
    return self;
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
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

    cell.botlabel.text = [NSString stringWithFormat:@"{%ld,%ld}",(long)indexPath.section,(long)indexPath.row];

    NSLog(@"frame = %@",NSStringFromCGRect(cell.frame));
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width - 20, collectionView.bounds.size.width - 20);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
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
    id objc = [_dataSource objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [_dataSource removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [_dataSource insertObject:objc atIndex:destinationIndexPath.item];
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
    //判断手势状态
    switch (longGesture.state) {
            
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self indexPathForItemAtPoint:[longGesture locationInView:self]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self updateInteractiveMovementTargetPosition:[longGesture locationInView:self]];
            break;
            
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self endInteractiveMovement];
            break;
            
        default:
            [self cancelInteractiveMovement];
            break;
    }
}

@end
