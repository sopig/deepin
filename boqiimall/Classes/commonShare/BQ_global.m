//
//  global.m
//  ule_specSale
//
//  Created by ysw on 14-4-18.
//  Copyright (c) 2014年 boqii. All rights reserved.

#import "BQ_global.h"
#import "MemoryData.h"
//#import "Reachability.h"
#import "NSString+StringUtility.h"
#import "NSDictionary+JSON.h"
//#import "UIDevice+IdentifierAddition.h"

@implementation BQ_global

+ (UIDevice *)defaultDevice{
    return [UIDevice currentDevice];
}

+ (NSString *)questModelInfo{
    return [[UIDevice currentDevice] model];
}

+ (NSString *)questSystemName{
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)questSystemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

//+ (NSString *)questMacAddress{
//    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
//    
//    if(version<7.0)
//        return [[UIDevice currentDevice] macaddress];
//    else
//        return @"";
//}


+(UIImage*)imgNamed:(NSString*)imgName
{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"ule_image" ofType:@"bundle"]];
    NSString *imagePath = [bundle pathForResource:imgName ofType:@"png"];
    return  [UIImage imageWithContentsOfFile:imagePath];
}

#pragma mark - 网络
+ (BOOL)hasNetWork {
    return [[MemoryData commonParam:HEAD_KEY_WANTYPE] isEqualToString:@"NotReachable"] ? NO : YES;
}

+ (NSString *) netWorkType{
    switch ([BQ_global questNetWorkType]) {
        case 0:     return @"NONET";
            break;
        case 1:     return @"2G/3G";
            break;
        case 2:     return @"WIFI";
            break;
        default:    return @"UNKNOW";
            break;
    }
    return @"";
}

+ (AFNetworkReachabilityStatus)questNetWorkType {
    if([BQ_global hasNetWork]) {
        return [[MemoryData commonParam:HEAD_KEY_WANTYPE] isEqualToString:@"WiFi"] ? AFNetworkReachabilityStatusReachableViaWiFi : AFNetworkReachabilityStatusReachableViaWWAN;
    }
    else {
        return AFNetworkReachabilityStatusNotReachable;
    }
}

//  --  仅仅wifi下显示图片
+ (BOOL)  showImgOnlyWIFI{
    if ([[NSUserDefaults standardUserDefaults] objectForKey: SHOWIMG_WIFI]==nil) {
        return NO;
    }
    return  [[NSUserDefaults standardUserDefaults]  boolForKey: SHOWIMG_WIFI];
}

+ (NSString *)questDateToString:(NSString *)input DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateOneStr = input;
    NSDate *dateOne = [formatter dateFromString:dateOneStr];
    double timeInterval = [dateOne timeIntervalSince1970];
    
    NSDate *tmpDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    [formatter setDateFormat:dateFormat];
    NSString *str = [formatter stringFromDate:tmpDate];
#if ! __has_feature(objc_arc)
    [formatter release];
#endif
    
    return str;
}



#pragma mark - 读取系统日志

+ (void)redirectNSLogToDocumentFolder
{
    NSArray *   paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *  documentsDirectory = [paths objectAtIndex:0];
    NSString *  fileNmae = [NSString stringWithFormat:@"%@.log",[NSDate date]];
    NSString *  logFilePath = [documentsDirectory stringByAppendingPathComponent:fileNmae];
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], " a+", stderr);
}



+(NSString*) getUuid{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"]==nil) {
        
        return @"";
    }
    return    [[NSUserDefaults standardUserDefaults]  objectForKey:@"uuid"];//获取uuid
}


//+(NSString*) getUserToken{
//
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"usertoken"]==nil) {
// 
//        return @"417cbf5ec1784317b905a6340a27c71c";//ceshidata
//    }
//    return    [[NSUserDefaults standardUserDefaults]  objectForKey:@"usertoken"];//获取usertoken
//}

/**
 alpha 从0到1
 */
+(void) AlphaToOne:(UIView*)targetView
{
	targetView.hidden = NO;
	CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeInAnimation.duration = 0.5f;
	fadeInAnimation.removedOnCompletion = NO;
	fadeInAnimation.fillMode = kCAFillModeForwards;
	fadeInAnimation.fromValue = [NSNumber numberWithFloat:0.1f];
	fadeInAnimation.toValue = [NSNumber numberWithFloat:0.9f];
	fadeInAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[targetView.layer addAnimation:fadeInAnimation forKey:@"animateOpacity"];
	
}

/**
 alpha 从1到0
 */
+(void) AlphaToZero:(UIView*)targetView
{
	 
	CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeOutAnimation.delegate = self;
	fadeOutAnimation.duration = 0.5f;
	fadeOutAnimation.removedOnCompletion = NO;
	fadeOutAnimation.fillMode = kCAFillModeForwards;
	fadeOutAnimation.fromValue = [NSNumber numberWithFloat:0.9f];
	fadeOutAnimation.toValue = [NSNumber numberWithFloat:0.0f];
	fadeOutAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[targetView.layer addAnimation:fadeOutAnimation forKey:@"animateOpacity"];
}

+(NSString*) getUDID{
    return [OpenUDID value];
}

+ (NSString *)getOpenUUID {
   NSString *_uuid = [OpenUDID value];
    if ([_uuid length]  > 0) {
        return _uuid;
    }
    return [self getUuid];
}

// 获取系统毫秒时间
+ (NSString*)GetCurrentDate:(NSDate*)date {
	//得到毫秒
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	//[dateFormatter setDateFormat:@"hh:mm:ss"]
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	//NSLog(@"Date%@", [dateFormatter stringFromDate:[NSDate date]]);
	NSString *currentdt = [dateFormatter stringFromDate:date];
#if ! __has_feature(objc_arc)
    [dateFormatter release];
#endif
	return currentdt;
}
 

+ (UIDeviceResolution) currentResolution {
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            if (result.height <= 480.0f)
                return UIDevice_iPhoneStandardRes;
            return (result.height > 960 ? UIDevice_iPhoneTallerHiRes : UIDevice_iPhoneHiRes);
        } else
            return UIDevice_iPhoneStandardRes;
    }
    else{
        return (([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) ? UIDevice_iPadHiRes:UIDevice_iPadStandardRes);
    }
}


#pragma mark    --  转 换.
+(NSString*)   convetString:(int) value{
    return   [NSString stringWithFormat:@"%d", value] ;
}
//  -- 转 图片 :  替换不同格式的图片    type : 
+ (NSString*) convertImageUrlString:(NSString*)type withurl:(NSString*)imgurl {
    
    @try {
        NSString *urlimg = [imgurl substringFromIndex:([imgurl length]-4)];
        urlimg = [NSString stringWithFormat:@"%@_%@%@",[imgurl substringToIndex:([imgurl length]-4)] ,type,urlimg];
        
        NSString *vMD5 = [NSString YKMD5:[NSString stringWithFormat:@"%@%@",urlimg,APP_IMGMD5]];
        return [NSString stringWithFormat:@"%@?v=%@",urlimg,vMD5];
    }
    @catch (NSException *exception) {
        return imgurl;
    }
}


/*
 JSON 解析函数
 param: clsName为解析后，所要得到的class类型名
 */
+(id) decodeJsonToDictionary:(NSString*)jsonStr
{
    NSDictionary* dic = nil;
    //NSLog(@"json--->%@",jsonStr);
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves  error:&error];
    
//    Class retClass = NSClassFromString(clsName);
//    retClass = [dic dictionaryTo:retClass];
    return dic;
}


/**
 获取网络图片的Size, 先通过文件头来获取图片大小
 如果失败 会下载完整的图片Data 来计算大小 所以最好别放在主线程
 如果你有使用SDWebImage就会先看下 SDWebImage有缓存过改图片没有
 支持文件头大小的格式 png、gif、jpg   http://www.cocoachina.com/bbs/read.php?tid=165823
 */
+(CGSize)downloadImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    
    NSString* absoluteString = URL.absoluteString;
    
#ifdef dispatch_main_sync_safe
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image) {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(image) {
            return image.size;
        }
    }
#endif
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self downloadPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"]) {
        size =  [self downloadGIFImageSizeWithRequest:request];
    }
    else{
        size = [self downloadJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image) {
#ifdef dispatch_main_sync_safe
            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    return size;
}

-(id)diskImageDataBySearchingAllPathsForKey:(id)key{return nil;}

+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request {
    
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}
@end
