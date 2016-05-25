//
//  PDLLayerManagerView.m
//  Demo
//
//  Created by qiyun on 16/4/29.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "PDLLayerManagerView.h"
#import "PDFMapTrackCollectionView.h"
#import "PDFMapTrackCollectionCell.h"

#define KManagerView_label_text_default @"N/A"
#define KManagerView_label_font_default 12

@interface PDLLayerManagerView ()<PDFCollectionViewDelegate>

@property (nonatomic, strong) PDFMapTrackCollectionView *videoCollectionView;
@property (nonatomic, strong) PDFMapTrackCollectionView *flyCollectionView;
@property (nonatomic, strong) PDFMapTrackCollectionView *mapCollectionView;


@end

@implementation PDLLayerManagerView{
    
    CGPoint     touch_start;
    CGPoint     touch_end;
    
    BOOL        zoomStatus;
}

#define KMoveExtent     0.3

static PDLLayerManagerView *managerView = nil;

+ (PDLLayerManagerView *)shareInstanceManagerView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerView = [PDLLayerManagerView new];
    });
    return managerView;
}

- (NSArray *)images{
    
    NSArray *images = @[KGetImage(@"main_notification_satellite"),KGetImage(@"main_notification_wifi"),
                        KGetImage(@"main_notification_controller"),KGetImage(@"main_notification_drone")];
    return images;
}

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        
        self.videoCollectionView = [[PDFMapTrackCollectionView alloc] initWithFrame:CGRectZero viewLayou:nil itemsCount:3];
        self.videoCollectionView.collectionDelegate = self;
        self.videoCollectionView.showBorder = YES;
        [self addSubview:self.videoCollectionView];
        
        self.flyCollectionView = [[PDFMapTrackCollectionView alloc] initWithFrame:CGRectZero viewLayou:nil itemsCount:5];
        self.flyCollectionView.collectionDelegate = self;
        self.flyCollectionView.showBorder = NO;
        [self addSubview:self.flyCollectionView];
        
        self.videoCollectionView.frame = CGRectMake((self.bounds.size.width * 0.92), (self.bounds.size.height * 0.25), (self.bounds.size.width * 0.08), (self.bounds.size.height * 0.5));
        [self.videoCollectionView setItemImages:@[KGetImage(@"main_camera_shoot"),
                                                  KGetImage(@"main_camera_video_shooting"),
                                                  KGetImage(@"main_camera_setting")]];
        
        self.flyCollectionView.frame = CGRectMake(0, (self.bounds.size.height * 0.22), (self.bounds.size.width * 0.1), (self.bounds.size.height * 0.76));;
        [self.flyCollectionView setItemImages:@[KGetImage(@"main_icon_fly"),
                                                KGetImage(@"main_icon_return"),
                                                KGetImage(@"main_icon_follow"),
                                                @"nothing",
                                                KGetImage(@"main_icon_map")]];
        
        [self addSubview:self.navigationBar];
        [self addSubview:self.coverBar];
        
        /* 让页面由外而内出现 */
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        
        [UIView animateWithDuration:1 animations:^{
            
            self.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }
    return self;
}


- (UIImageView *)navigationBar{
    
    if (!_navigationBar) {
        
        _navigationBar = [[PDLNavigationBar alloc] initWithImage:KGetImage(@"main_status bar_bg_red")];
        _navigationBar.userInteractionEnabled = YES;
        _navigationBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), (Iphone?44:66));
        
        __unsafe_unretained PDLLayerManagerView *weakSelf = self;
        
        _navigationBar.backAction = ^(UIButton *btn, BOOL fin)  {
            if (weakSelf.backAction) weakSelf.backAction(btn, fin);
        };
        
        _navigationBar.settingAction = ^(UIButton *btn, BOOL fin)   {
            if (weakSelf.settingAction) weakSelf.settingAction(btn, fin);
        };
    }
    return _navigationBar;
}

- (UIImageView *)coverBar{
    
    if (!_coverBar) {
        
        UIImage *coverImage = KGetImage(@"main_button_bg");
        CGRect frame = CGRectMake((CGRectGetWidth(self.bounds) - coverImage.size.width)/2,
                                     CGRectGetHeight(self.bounds) - coverImage.size.height - (Iphone?22:33),
                                     coverImage.size.width,
                                     coverImage.size.height);
        
        _coverBar = [[PDLCoverImageView alloc] initWithFrame:frame];
        _coverBar.image = coverImage;
    }
    return _coverBar;
}


#pragma mark    -   set method

- (void)setFullScrren:(BOOL)fullScrren{
    
    _fullScrren = fullScrren;
    
    if (_fullScrren && !zoomStatus) {
        
        self.transform = CGAffineTransformMakeScale(1, 1);
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.transform = CGAffineTransformMakeScale(1.5, 1.5);
            zoomStatus = YES;
        }];
    }
    
    if (!_fullScrren && zoomStatus) {
        
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.transform = CGAffineTransformMakeScale(1, 1);
            zoomStatus = NO;
        }];
    }
}



- (void)collectionView:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:self.videoCollectionView]) {
        
        if (indexPath.row == 1) {
            
            NSLog(@"点击录像的cell。。。");
        }
    }
    
    NSLog(@"indexPath = %@",indexPath);
}

#pragma mark    -   PDLCollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didSelectdRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:self.videoCollectionView]) {
        
        if (indexPath.row == 1) {
            
            NSLog(@"点击图像 indexPath = %@",indexPath);
            
            imageView.seletedImage = KGetImage(@"main_camera_video_stop");
            
            if (imageView.seleted) {
                
                CGFloat origin_x = CGRectGetWidth(self.bounds) - CGRectGetWidth(self.videoCollectionView.bounds) - CGRectGetWidth(self.bounds) * 0.3 - 10;
                
                /*   计算弹框所在的位置，(indexPath.row + 0.2)用于向下偏移一段距离，达到所需效果   */
                [self.videoCollectionView accessoryItems:YES withFrame:CGRectMake(origin_x,
                                                                             self.videoCollectionView.frame.origin.y + (self.videoCollectionView.frame.size.height/3 * (indexPath.row + 0.2)),
                                                                             CGRectGetWidth(self.bounds) * 0.3,
                                                                             self.videoCollectionView.frame.size.height/2.7)
                                          superView:self];
            }
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView collectionCell:(UICollectionViewCell *)cell imageView:(PDFImageView *)imageView didUnSelectdRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"取消选中图像 indexPath = %@",indexPath);
    imageView.seleted = NO;
    
    if ([collectionView isEqual:self.videoCollectionView]) {
        
        [self.videoCollectionView accessoryItems:NO withFrame:CGRectNull superView:nil];
    }
}

- (void)collectionView:(UICollectionView *)collectionView collectionViewCell:(UICollectionViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([collectionView isEqual:self.videoCollectionView]) {
        
        collectionView.backgroundColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor blackColor];
    }else{
        
        collectionView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];
    }
}

/*
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //点击空白区域事件穿透
    UIView *hitView = [super hitTest:point withEvent:event];

    if(hitView == self) return nil;
    return hitView;
}
 */

#pragma mark    -   touches delegate
#pragma mark    -   --------------------------------------------------

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    touch_start = [[touches allObjects].lastObject locationInView:self];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    touch_end = [[touches allObjects].lastObject locationInView:self];
    
    if (!CGPointEqualToPoint(touch_start, touch_end)) {
        
        if ((touch_end.y - touch_start.y) >= (CGRectGetHeight(self.bounds) * KMoveExtent)) {
            
            self.fullScrren = YES;

        }else if ((touch_start.y - touch_end.y) >= (CGRectGetHeight(self.bounds) * KMoveExtent)) {
            
            self.fullScrren = NO;
        }
    }
}



@end



@implementation PDLNavigationBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSuviews];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image{
    
    if (self = [super initWithImage:image]) {
        
        self.image = image;
        [self addSuviews];
    }
    return self;
}

- (void)addSuviews{
    
    [self addSubview:self.back];
    [self addSubview:self.set];
    
    [self addSubview:self.satelliteLabel];
    [self addSubview:self.wifiLabel];
    [self addSubview:self.handleLabel];
    [self addSubview:self.flyLabel];
}

- (NSArray *)images{
    
    NSArray *images = @[KGetImage(@"main_notification_satellite"),KGetImage(@"main_notification_wifi"),
                        KGetImage(@"main_notification_controller"),KGetImage(@"main_notification_drone")];
    return images;
}

- (UILabel *)satelliteLabel{
    
    if (!_satelliteLabel) {
        
        _satelliteLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) * 0.12, 0, CGRectGetWidth(self.bounds) * 0.08, CGRectGetHeight(self.bounds))];
        _satelliteLabel.attributedText = [self attributeText:KManagerView_label_text_default addImage:[self images][0] direction:NO];
        _satelliteLabel.adjustsFontSizeToFitWidth = YES;
        _satelliteLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return _satelliteLabel;
}

- (UILabel *)wifiLabel{
    
    if (!_wifiLabel) {
        
        _wifiLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) * 0.25, 0, CGRectGetWidth(self.bounds) * 0.08, CGRectGetHeight(self.bounds))];
        _wifiLabel.attributedText = [self attributeText:KManagerView_label_text_default addImage:[self images][1] direction:NO];
        _wifiLabel.adjustsFontSizeToFitWidth = YES;
        _wifiLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;

    }
    return _wifiLabel;
}

- (UILabel *)handleLabel{
    
    if (!_handleLabel) {
        
        _handleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) * 0.67, 0, CGRectGetWidth(self.bounds) * 0.08, CGRectGetHeight(self.bounds))];
        _handleLabel.attributedText = [self attributeText:KManagerView_label_text_default addImage:[self images][2] direction:NO];
        _handleLabel.adjustsFontSizeToFitWidth = YES;
        _handleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return _handleLabel;
}

- (UILabel *)flyLabel{
    
    if (!_flyLabel) {
        
        _flyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) * 0.8, 0, CGRectGetWidth(self.bounds) * 0.08, CGRectGetHeight(self.bounds))];
        _flyLabel.attributedText = [self attributeText:KManagerView_label_text_default addImage:[self images][3] direction:NO];
        _flyLabel.adjustsFontSizeToFitWidth = YES;
        _flyLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return _flyLabel;
}


- (UIButton *)back{
    
    if (!_back) {
        
        _back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_back setImage:KGetImage(@"main_notification_back") forState:UIControlStateNormal];
        [_back setFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.08, CGRectGetHeight(self.bounds))];
        [_back addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [_back setTintColor:[UIColor whiteColor]];
        //[_back setImageEdgeInsets:UIEdgeInsetsMake(width * 0.2, width * 0.3, width * 0.2, width * 0.3)];
        
        [self addSubview:[self separateLineWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - CGRectGetWidth(_back.bounds) - 2,
                                                                CGRectGetHeight(self.bounds) * 0.2,
                                                                1,
                                                                CGRectGetHeight(self.bounds) * 0.6)]];
    }
    return _back;
}


- (UIButton *)set{
    
    if (!_set) {
        
        _set = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_set setImage:KGetImage(@"main_notification_setting") forState:UIControlStateNormal];
        [_set setFrame:CGRectMake(CGRectGetWidth(self.bounds) * 0.92, 0, CGRectGetWidth(self.bounds) * 0.08, CGRectGetHeight(self.bounds))];
        [_set addTarget:self action:@selector(setAction:) forControlEvents:UIControlEventTouchUpInside];
        [_set setTintColor:[UIColor whiteColor]];
        
        [self addSubview:[self separateLineWithFrame:CGRectMake(CGRectGetWidth(_set.bounds) + 2,
                                                                CGRectGetHeight(self.bounds) * 0.2,
                                                                1,
                                                                CGRectGetHeight(self.bounds) * 0.6)]];
    }
    return _set;
}

- (UILabel *)separateLineWithFrame:(CGRect)rect{
    
    UILabel *sLabel = [[UILabel alloc] initWithFrame:rect];
    sLabel.backgroundColor = [UIColor lightGrayColor];
    return sLabel;
}

- (void)backAction:(UIButton *)sender{
    
    if (self.backAction)
        self.backAction(sender,YES);
}

- (void)setAction:(UIButton *)sender{
 
    if (self.settingAction)
        self.settingAction(sender,YES);
}

- (NSMutableAttributedString *)attributeText:(NSString *)text addImage:(UIImage *)image direction:(BOOL)dir{
    
    if (text) text = [@"  " stringByAppendingString:text];
    
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:text];
    [attributed setAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:KManagerView_label_font_default],
                                NSForegroundColorAttributeName : [UIColor whiteColor]}
                        range:NSMakeRange(0, text.length)];
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = image;
    attch.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    if (dir) [attributed appendAttributedString:string];
    else{
        
        NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithAttributedString:string];
        [atr appendAttributedString:attributed];
        return atr;
    }
    
    return attributed;
}

@end


@implementation PDLCoverImageView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        self.frame = frame;
        
        [self addSuviews];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat wid = CGRectGetWidth(self.bounds)/3;
    CGFloat hei = CGRectGetHeight(self.bounds) * 0.7;
    
    self.altLabel.frame = CGRectMake(0, CGRectGetHeight(self.bounds) * 0.15, wid, hei);
    self.stuLabel.frame = CGRectMake(wid * 1, CGRectGetHeight(self.bounds) * 0.15, wid, hei);
    self.disLabel.frame = CGRectMake(wid * 2, CGRectGetHeight(self.bounds) * 0.15, wid, hei);
}

- (NSMutableAttributedString *)aString:(NSString *)string{
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[@"ALT: " stringByAppendingString:string]];
    [aString addAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:KManagerView_label_font_default]} range:NSMakeRange(0, 5)];
    [aString addAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:KManagerView_label_font_default + 3]} range:NSMakeRange(5, [aString length] - 5)];
    return aString;
}

- (UILabel *)altLabel{
    
    if (!_altLabel) {
        
        _altLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _altLabel.textColor = [UIColor whiteColor];
        _altLabel.attributedText = [self aString:KManagerView_label_text_default];
        _altLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _altLabel;
}

- (UILabel *)disLabel{
    
    if (!_disLabel) {
        
        _disLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _disLabel.textColor = [UIColor whiteColor];
        _disLabel.attributedText = [self aString:KManagerView_label_text_default];
        _disLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _disLabel;
}

- (UILabel *)stuLabel{
    
    if (!_stuLabel) {
        
        _stuLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _stuLabel.textColor = [UIColor whiteColor];
        _stuLabel.text = kFlightModeNone;
        _stuLabel.font = [UIFont boldSystemFontOfSize:KManagerView_label_font_default + 4];
        _stuLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _stuLabel;
}

- (void)addSuviews{
    
    [self addSubview:self.altLabel];
    [self addSubview:self.disLabel];
    [self addSubview:self.stuLabel];
}

@end

