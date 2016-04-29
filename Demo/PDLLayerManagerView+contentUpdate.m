//
//  PDLLayerManagerView+contentUpdate.m
//  Demo
//
//  Created by qiyun on 16/4/29.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "PDLLayerManagerView+contentUpdate.h"

@implementation PDLLayerManagerView (PDLLayerManagerView_contentUpdate)



- (void)setSatellite:(NSInteger)satellite{
    
    self.navigationBar.satellite.attributedText = [self.navigationBar attributeText:
                                                   [NSString stringWithFormat:@"%ld",(long)satellite]
                                                                           addImage:[self images][0]
                                                                          direction:NO];
}


- (void)setWifi:(NSInteger)wifi{
    
    self.navigationBar.wifi.attributedText = [self.navigationBar attributeText:
                                              [[NSString stringWithFormat:@"%ld",(long)wifi] stringByAppendingString:@"%"]
                                                                      addImage:[self images][1]
                                                                     direction:NO];
}



- (void)setHandleBatteries:(NSInteger)handleBatteries{
    
    self.navigationBar.handle.attributedText = [self.navigationBar attributeText:
                                              [[NSString stringWithFormat:@"%ld",(long)handleBatteries] stringByAppendingString:@"%"]
                                                                      addImage:[self images][2]
                                                                     direction:NO];
}

- (void)setFlyBatteries:(NSInteger)flyBatteries{
    
    self.navigationBar.fly.attributedText = [self.navigationBar attributeText:
                                                [[NSString stringWithFormat:@"%ld",(long)flyBatteries] stringByAppendingString:@"%"]
                                                                        addImage:[self images][3]
                                                                       direction:NO];
}


@end
