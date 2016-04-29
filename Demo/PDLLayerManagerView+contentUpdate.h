//
//  PDLLayerManagerView+contentUpdate.h
//  Demo
//
//  Created by qiyun on 16/4/29.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "PDLLayerManagerView.h"

@interface PDLLayerManagerView (PDLLayerManagerView_contentUpdate)


- (void)setWifi:(NSInteger)wifi;
- (void)setSatellite:(NSInteger)satellite;
- (void)setHandleBatteries:(NSInteger)handleBatteries;
- (void)setFlyBatteries:(NSInteger)flyBatteries;

@end


