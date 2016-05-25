//
//  PDLLayerManagerView+contentUpdate.m
//  Demo
//
//  Created by qiyun on 16/4/29.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "PDLLayerManagerView+contentUpdate.h"

@implementation PDLLayerManagerView (PDLLayerManagerView_contentUpdate)

static NSString * KPDLLayer_wifi                = @"com.prodorne.wifi";
static NSString * KPDLLayer_satellite           = @"com.prodorne.satellite";
static NSString * KPDLLayer_handle_batteries    = @"com.prodorne.handleBatteries";
static NSString * KPDLLayer_fly_batteries       = @"com.prodorne.flyBatteries";

static NSString * KPDLLayer_fly_altitude        = @"com.prodorne.altitude";
static NSString * KPDLLayer_fly_distance        = @"com.prodorne.distance";

- (PDLBackAction)backAction{
    
    return ^(UIButton *button, BOOL finished){
        
        NSLog(@"返回...");
    };
}

- (PDLSettingAction)settingAction{
    
    return ^(UIButton *button, BOOL finished){
        
        NSLog(@"设置、、、");
    };
}

#pragma mark    -   set method
#pragma mark    -   ------------------------

- (void)setSatellite:(NSInteger)satellite{
    
    self.navigationBar.satelliteLabel.attributedText = [self.navigationBar attributeText:
                                                   [NSString stringWithFormat:@"%ld",(long)satellite]
                                                                           addImage:[self images][0]
                                                                          direction:NO];
    [self notificationWithPostKey:KPDLLayer_satellite userInfo:@{KPDLLayer_satellite:@(satellite)}];
}


- (void)setWifi:(NSInteger)wifi{
    
    self.navigationBar.wifiLabel.attributedText = [self.navigationBar attributeText:
                                              [[NSString stringWithFormat:@"%ld",(long)wifi] stringByAppendingString:@"%"]
                                                                      addImage:[self images][1]
                                                                     direction:NO];
    
    [self notificationWithPostKey:KPDLLayer_wifi userInfo:@{KPDLLayer_wifi:@(wifi)}];
}



- (void)setHandleBatteries:(NSInteger)handleBatteries{
    
    self.navigationBar.handleLabel.attributedText = [self.navigationBar attributeText:
                                              [[NSString stringWithFormat:@"%ld",(long)handleBatteries] stringByAppendingString:@"%"]
                                                                      addImage:[self images][2]
                                                                     direction:NO];
    [self notificationWithPostKey:KPDLLayer_handle_batteries userInfo:@{KPDLLayer_handle_batteries:@(handleBatteries)}];
    
}

- (void)setFlyBatteries:(NSInteger)flyBatteries{
    
    self.navigationBar.flyLabel.attributedText = [self.navigationBar attributeText:
                                                [[NSString stringWithFormat:@"%ld",(long)flyBatteries] stringByAppendingString:@"%"]
                                                                        addImage:[self images][3]
                                                                       direction:NO];
    [self notificationWithPostKey:KPDLLayer_fly_batteries userInfo:@{KPDLLayer_fly_batteries:@(flyBatteries)}];
}



- (void)setAltitude:(CGFloat)altitude{
    
    self.coverBar.altLabel.attributedText = [self.coverBar aString:[NSString stringWithFormat:@"%.0f",altitude]];
    [self notificationWithPostKey:KPDLLayer_fly_altitude userInfo:@{KPDLLayer_fly_altitude:@(altitude)}];
}

- (void)setDistance:(CGFloat)distance{
    
    self.coverBar.disLabel.attributedText = [self.coverBar aString:[NSString stringWithFormat:@"%.0f",distance]];
    [self notificationWithPostKey:KPDLLayer_fly_distance userInfo:@{KPDLLayer_fly_distance:@(distance)}];
}

- (void)setStatus:(NSString *)status{
    
    self.coverBar.stuLabel.text = status;
}




#pragma mark    -   get method
#pragma mark    -   ------------------------


- (void)getSatellite:(void (^) (NSInteger satellite))satellite{
    
    [self notificationResponseWithKey:KPDLLayer_satellite finished:^(NSInteger value) {
        
        satellite(value);
    }];
}

- (void)getWifi:(void (^) (NSInteger wifi))wifi{
    
    [self notificationResponseWithKey:KPDLLayer_wifi finished:^(NSInteger value) {
    
        wifi(value);
    }];
}

- (void)getHandleBatteries:(void (^) (NSInteger handleBatteries))handleBatteries{
    
    [self notificationResponseWithKey:KPDLLayer_handle_batteries finished:^(NSInteger value) {
        
        handleBatteries(value);
    }];
}

- (void)getFlyBatteries:(void (^) (NSInteger flyBatteries))FlyBatteries{
    
    [self notificationResponseWithKey:KPDLLayer_fly_batteries finished:^(NSInteger value) {
        
        FlyBatteries(value);
    }];
}


- (void)getFlyAltitude:(void (^) (CGFloat alt))altitude{
    
    [self notificationResponseWithKey:KPDLLayer_fly_altitude finished:^(NSInteger value) {
        
        altitude(value);
    }];
}

- (void)getFlyDistance:(void (^) (CGFloat dis))distance{
    
    [self notificationResponseWithKey:KPDLLayer_fly_distance finished:^(NSInteger value) {
        
        distance(value);
    }];
}

#pragma mark    -   notification post method
#pragma mark    -   ------------------------

/**
 *  Creates a notification with a given name, sender, and information and posts it to the receiver.
 *
 *  @param notificationName  The name of the notification
 *  @param notificationSender The object posting the notification.
 *  @param userInfo Information about the the notification. May be nil.
 */
- (void)notificationWithPostKey:(NSString *)key userInfo:(NSDictionary *)info{
    
    //post
    [[NSNotificationCenter defaultCenter] postNotificationName:key
                                                        object:self
                                                      userInfo:info];
}

/**
 *  @discussion Adds an entry to the receiver’s dispatch table with a notification queue and a block to add to the queue, and optional criteria: notification name and sender.
 *
 *  @brief queue    ->>   The operation queue to which block should be added.
 *                        If you pass nil, the block is run synchronously on the posting thread.
 *
 *  @brief block    ->>   The block to be executed when the notification is received.
 *                        The block is copied by the notification center and (the copy) held until the observer registration is removed.
 *                        The block takes one argument:
 */
- (void)notificationResponseWithKey:(NSString *)key finished:(void (^) (NSInteger value))finished{
    
    //receive
    [[NSNotificationCenter defaultCenter] addObserverForName:key
                                                      object:self
                                                       queue:nil
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      
                                                      NSString *str = [note userInfo][key];
                                                      finished([str integerValue]);
                                                  }];
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
