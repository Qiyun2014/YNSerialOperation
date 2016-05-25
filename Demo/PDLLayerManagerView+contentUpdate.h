//
//  PDLLayerManagerView+contentUpdate.h
//  Demo
//
//  Created by qiyun on 16/4/29.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "PDLLayerManagerView.h"

@interface PDLLayerManagerView (PDLLayerManagerView_contentUpdate)

- (PDLBackAction)backAction;
- (PDLSettingAction)settingAction;


- (void)setWifi:(NSInteger)wifi;                        /*  wifi强度   */
- (void)setSatellite:(NSInteger)satellite;              /*  卫星强度   */
- (void)setHandleBatteries:(NSInteger)handleBatteries;  /*  遥控电量   */
- (void)setFlyBatteries:(NSInteger)flyBatteries;        /*  飞机电量   */

- (void)setAltitude:(CGFloat)altitude;                  /*  飞行高度   */
- (void)setDistance:(CGFloat)distance;                  /*  飞行距离   */



- (void)getWifi:(void (^) (NSInteger wifi))wifi;
- (void)getSatellite:(void (^) (NSInteger satellite))satellite;
- (void)getHandleBatteries:(void (^) (NSInteger handleBatteries))handleBatteries;
- (void)getFlyBatteries:(void (^) (NSInteger flyBatteries))FlyBatteries;

- (void)getFlyAltitude:(void (^) (CGFloat alt))altitude;
- (void)getFlyDistance:(void (^) (CGFloat dis))distance;

@end


