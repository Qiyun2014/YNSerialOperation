//
//  PDFMapTrackCollectionCell.m
//  Demo
//
//  Created by qiyun on 16/4/22.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "PDFMapTrackCollectionCell.h"

@implementation PDFMapTrackCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _topImage  = [[PDFImageView alloc] initWithFrame:CGRectInset(self.bounds, 15, 15)];
        _topImage.userInteractionEnabled = YES;
        _topImage.highlighted = YES;
        _topImage.contentMode = UIViewContentModeScaleAspectFit;
        _topImage.delegate = self;
        [self.contentView addSubview:_topImage];
        
        /*  添加motion effect */
        {
            UIInterpolatingMotionEffect *verticalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                                                                type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
            verticalMotionEffect.minimumRelativeValue = @(-20);
            verticalMotionEffect.maximumRelativeValue = @(20);
            
            UIInterpolatingMotionEffect *horizontalMotionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                                                                  type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
            horizontalMotionEffect.minimumRelativeValue = @(-20);
            horizontalMotionEffect.maximumRelativeValue = @(20);
            
            UIMotionEffectGroup *group = [UIMotionEffectGroup new];
            
            group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
            [_topImage addMotionEffect:group];
        }
        
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

- (void)imageView:(PDFImageView *)imageView didSelectdRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(collectionCell:imageView:didSelectdRowAtIndexPath:)]) {
        [self.delegate collectionCell:self imageView:imageView didSelectdRowAtIndexPath:indexPath];
    }
}

- (void)imageView:(PDFImageView *)imageView didUnSelectdRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(collectionCell:imageView:didUnSelectdRowAtIndexPath:)]) {
        [self.delegate collectionCell:self imageView:imageView didUnSelectdRowAtIndexPath:indexPath];
    }
}

- (void)layoutSubviews{

    [super layoutSubviews];
}

@end


@implementation PDFImageView


#pragma mark    -   get method

- (void)setSeleted:(BOOL)seleted{
    
    _seleted = seleted;
    
    if (!_seleted)           self.image = _defaultImage;
    else { if (_seletedImage)    self.image = _seletedImage;}
}

#pragma mark    -   set method

- (void)setDefaultImage:(UIImage *)defaultImage{
    
    _defaultImage = defaultImage;
    self.seleted = NO;
}

- (void)setSeletedImage:(UIImage *)seletedImage{
    
    _seletedImage = seletedImage;
    self.seleted = YES;
}



#pragma mark    -   responder method

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.layer.opacity = 0.5;
    
    if (!self.seleted) {
        
        if ([self.delegate respondsToSelector:@selector(imageView:didSelectdRowAtIndexPath:)]) {
            [self.delegate imageView:self didSelectdRowAtIndexPath:self.indexPath];
        }
    }else{
        
        if ([self.delegate respondsToSelector:@selector(imageView:didUnSelectdRowAtIndexPath:)]) {
            [self.delegate imageView:self didUnSelectdRowAtIndexPath:self.indexPath];
        }
    }
}


- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    self.layer.opacity = 1;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    self.layer.opacity = 1;
    
}

@end

