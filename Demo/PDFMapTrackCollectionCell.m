//
//  PDFMapTrackCollectionCell.m
//  Demo
//
//  Created by qiyun on 16/4/22.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "PDFMapTrackCollectionCell.h"

@implementation PDFMapTrackCollectionCell

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kButton_tintColor_agree UIColorFromRGB(0xef6f22)    //不同意显示色值
#define kButton_tintColor_disagree UIColorFromRGB(0x767676) //同意显示色值

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _topImage  = [[PDFImageView alloc] initWithFrame:CGRectInset(self.bounds, 15, 15)];
        _topImage.userInteractionEnabled = YES;
        _topImage.highlighted = YES;
        _topImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_topImage];
        
        UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        verticalMotionEffect.minimumRelativeValue = @(-20);
        verticalMotionEffect.maximumRelativeValue = @(20);
        
        UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        horizontalMotionEffect.minimumRelativeValue = @(-20);
        horizontalMotionEffect.maximumRelativeValue = @(20);
        
        UIMotionEffectGroup *group = [UIMotionEffectGroup new];
        
        group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
        [_topImage addMotionEffect:group];
        
        /*
        _item = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _item.backgroundColor = [UIColor purpleColor];
        CGRect rect = CGRectInset(self.bounds, 10, 10);
        rect.size.width = rect.size.height;
        _item.frame = rect;
        _item.layer.cornerRadius = CGRectGetHeight(_item.bounds)/2;
        _item.clipsToBounds = YES;
        [self addSubview:_item];
        */
        
        /*
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = CGRectInset(_topImage.bounds, 10, 10);
        [_topImage addSubview:effectView];
        */
        
        /*
        let blurEffect: UIBlurEffect = UIBlurEffect(style: .Light)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRectMake(50.0, 50.0, self.view.frame.width - 100.0, 200.0)
        self.view.addSubview(blurView)
         */
        
        /*
        _botlabel = [[UILabel alloc] initWithFrame:CGRectInset(_topImage.frame, 20, 20)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.textColor = [UIColor blueColor];
        _botlabel.font = [UIFont systemFontOfSize:15];
        _botlabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_botlabel];
         */
    }

    return self;
}



- (void)layoutSubviews{

    [super layoutSubviews];

}

@end


@implementation PDFImageView


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.layer.opacity = 0.5;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.layer.opacity = 1;
}

- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    self.layer.opacity = 1;
}


- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0){
    
    self.layer.opacity = 0.5;
}

- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0){
   
    self.layer.opacity = 0.5;
}

- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0){
    
    self.layer.opacity = 1;
}

- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0){
    
    self.layer.opacity = 1;
}

@end

