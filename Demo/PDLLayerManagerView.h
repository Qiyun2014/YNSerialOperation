//
//  PDLLayerManagerView.h
//  Demo
//
//  Created by qiyun on 16/4/29.
//  Copyright © 2016年 ProDrone. All rights reserved.
//
/******** 此类用于所有的视图布局，不做其他任何操作 ********/

#import <UIKit/UIKit.h>

#define KGetImage(name) [UIImage imageNamed:name]

#define Iphone  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

/*  录制视频状态  */
typedef NS_ENUM(NSInteger, PDLRecordStatus) {
    
    PDLVideoRecord_default = 0,
    PDLVideoRecord_begin,
    PDLVideoRecord_stop
};


/*  飞机连接状态  */
typedef NS_ENUM(NSInteger, PDLConnectionStatus) {
    
    PDLConnection_unknow = 0,   /* 未连接 */
    PDLConnection_well,         /* 好 */
    PDLConnection_bad           /* 差 */
};

static NSString* const kFlightModeAttitude  = @"ATTITUDE";
static NSString* const kFlightModeAUTO      = @"WAYPOINT";
static NSString* const kFlightModeGUIDE     = @"Take Off";
static NSString* const kFlightModeRTL       = @"RTH";
static NSString* const kFlightModeGPS       = @"P-GPS";
static NSString* const kFlightModeNone      = @"NONE";


typedef void (^PDLBackAction) (UIButton *button, BOOL finished);     /*  返回  */
typedef void (^PDLSettingAction) (UIButton *button, BOOL finished);  /*  设置  */



@class PDLNavigationBar,PDLCoverImageView;
@interface PDLLayerManagerView : UIView

+ (PDLLayerManagerView *)shareInstanceManagerView;

- (NSArray *)images;

@property (nonatomic, strong) PDLNavigationBar   *navigationBar;
@property (nonatomic, strong) PDLCoverImageView   *coverBar;

@property (nonatomic) PDLRecordStatus recordStatus;     /*  视频录制状态  */
@property (nonatomic) BOOL  cameraSet;                  /*  相机设置状态  */
@property (nonatomic) BOOL  mapShow;                    /*  是否显示地图  */

@property (nonatomic) BOOL  fullScrren;                 /*  是否显示全屏  */


/*      ---------------------  导航条信息    ---------------------------     */
@property (nonatomic) PDLConnectionStatus connection;   /*  飞机连接状态  */
@property (nonatomic) NSInteger     satellite;          /*  卫星数  */
@property (nonatomic) NSInteger     wifi;               /*  wifi信号  */
@property (nonatomic) NSInteger     handleBatteries;    /*  遥控器电量  */
@property (nonatomic) NSInteger     flyBatteries;       /*  飞机电量  */


@property (nonatomic, copy) PDLBackAction       backAction;     /*   返回   */
@property (nonatomic, copy) PDLSettingAction    settingAction;  /*   设置   */


/*      ---------------------  浮层<飞机距离>    ---------------------------     */
@property (nonatomic, copy) NSString      *status;              /*  状态文本  */
@property (nonatomic) CGFloat             altitude;             /*  海拔高度  */
@property (nonatomic) CGFloat             distance;             /*  距离     */


@end




@interface PDLNavigationBar : UIImageView

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithImage:(UIImage *)image;

@property (nonatomic, strong) UIButton  *back;          /*  返回按钮  */
@property (nonatomic, strong) UIButton  *set;           /*  设置按钮  */

@property (nonatomic, strong) UILabel *satelliteLabel;       /*  卫星强度  */
@property (nonatomic, strong) UILabel *wifiLabel;            /*  wifi强度  */
@property (nonatomic, strong) UILabel *handleLabel;          /*  遥控器电量  */
@property (nonatomic, strong) UILabel *flyLabel;             /*  飞机电量  */

@property (nonatomic, copy) PDLBackAction       backAction;     /*   返回   */
@property (nonatomic, copy) PDLSettingAction    settingAction;  /*   设置   */

- (NSMutableAttributedString *)attributeText:(NSString *)text addImage:(UIImage *)image direction:(BOOL)dir;

@end


@interface PDLCoverImageView : UIImageView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UILabel *altLabel;            /*  高度  */
@property (nonatomic, strong) UILabel *disLabel;            /*  距离  */
@property (nonatomic, strong) UILabel *stuLabel;            /*  飞行状况  */

- (NSMutableAttributedString *)aString:(NSString *)string;

@end