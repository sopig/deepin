//  ule_global.h
//  ule_specSale
//
//  Created by ysw on 14-4-18.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenUDID.h"
#import "BQIAppDelegate.h"


#define APP_NEED_SHOW_WELCOMEPAGE @"1.3"   //如需此版本显示欢迎页，请在发布时写入当前版本号，不需要此版显示，不用动
#define APP_VERSION     @"1.3"    //   app版本
#define APP_VERSIONNUM  @"5"      //   app对应版本号，每次更新版本+1 (与后台对应,发布版本时千万不要忘记)
#define APP_CHANNEL_ID  @"015"    //   app store
#define APP_FORMAT      @"json"
#define APP_ACTIONNAME  @"Act"
#define APP_SECRETKEY   @"761a336a3eed49dabdd3fd4d488ab19a"
#define APP_SIGNKEY     @"comboqiiwwwvetapp"
#define APP_IMGMD5      @"comboqiiwwwvetappimg"
#define APP_APPSTOREURL (APPVERSIONTYPE ? @"http://itunes.apple.com/app/id883476363":@"http://itunes.apple.com/app/id908872668")
#define APP_DOWNLOADURL @"http://m.boqii.com/appdown.html"

enum {
    // iPhone 1,3,3GS 标准分辨率(320x480px)
    UIDevice_iPhoneStandardRes = 1,
    // iPhone 4,4S 高清分辨率(640x960px)
    UIDevice_iPhoneHiRes = 2,
    // iPhone 5 高清分辨率(640x1136px)
    UIDevice_iPhoneTallerHiRes = 3,
    // iPad 1,2 标准分辨率(1024x768px)
    UIDevice_iPadStandardRes = 3,
    // iPad 3 High Resolution(2048x1536px)
    UIDevice_iPadHiRes = 3
}; typedef NSUInteger UIDeviceResolution;


//--    服务和商户
typedef enum {
    SMOperation_Service,
    SMOperation_Merchant
} ServiceOrMerchant;


//--    页面上边的筛选类型
typedef enum {
    SimpleFilter,   //  -- 只有一栏
    ComplexFilter   //  -- 有子栏
} DDFilterType;


double  _lon;   //纬度
double  _lat;   //经度

int g_PushFlag; //推送


@interface BQ_global : NSObject

+ (UIDevice *)defaultDevice;

+ (NSString *)questModelInfo;

+ (NSString *)questSystemName;

+ (NSString *)questSystemVersion;

//+ (NSString *)questMacAddress;

//  --  网络
+ (BOOL)    hasNetWork;
+ (NSString *) netWorkType;


//  --  仅仅wifi下显示图片
+ (BOOL)  showImgOnlyWIFI;

//  --  取对应图片名在bundle中的图片
+(UIImage*)imgNamed:(NSString*)imgName;

+(NSString*) getUuid;

//+(NSString*) getUserToken;
 
/** alpha 从0到1 */
+(void) AlphaToOne:(UIView*)targetView;
/** alpha 从1到0 */
+(void) AlphaToZero:(UIView*)targetView;


+(NSString*) getUDID;
+(NSString*) getOpenUUID;

+ (NSString*)GetCurrentDate:(NSDate*)date;


//根据当前设备分辨率来判断机型
+ (UIDeviceResolution) currentResolution;

#pragma mark    --  转 换.
//  -- 转字符
+(NSString*)   convetString:(int) value;
//  -- 转 图片 :  替换不同格式的图片
+ (NSString*) convertImageUrlString:(NSString*)type withurl:(NSString*)imgurl;

//  --JSON 解析函数
+(id) decodeJsonToDictionary:(NSString*)jsonStr;


/**
 获取网络图片的Size, 先通过文件头来获取图片大小
 如果失败 会下载完整的图片Data 来计算大小 所以最好别放在主线程
 如果你有使用SDWebImage就会先看下 SDWebImage有缓存过改图片没有
 支持文件头大小的格式 png、gif、jpg   http://www.cocoachina.com/bbs/read.php?tid=165823
 */
+(CGSize)downloadImageSizeWithURL:(id)imageURL;
+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request;
+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request;
+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request;
@end
