//
//  resMod_IndexData.h
//  BoqiiLife
//
//  Created by YSW on 14-5-5.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

/******************************************************
 ---------       banner model
 ******************************************************
 */
@interface resMod_IndexBannerInfo : NSObject{
    int BannerType;
    NSString * ImageUrl;
    NSString * Url;
    NSString * Title;
}
@property (assign,nonatomic) int BannerType;
@property (strong,nonatomic) NSString * ImageUrl;
@property (strong,nonatomic) NSString * Url;
@property (strong,nonatomic) NSString * Title;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



/******************************************************
 ---------        hot  lowprice  model
 ******************************************************
*/
@interface resMod_IndexHotInfo : NSObject{
    
    int TicketId;
    NSString * TicketTitle;
    NSString * TicketImg;
    float TicketPrice;
    float TicketOriPrice;
    int TicketBuyed;
}
@property (assign,nonatomic) int TicketId;
@property (strong,nonatomic) NSString * TicketTitle;
@property (strong,nonatomic) NSString * TicketImg;
@property (assign,nonatomic) float TicketPrice;
@property (assign,nonatomic) float TicketOriPrice;
@property (assign,nonatomic) int TicketBuyed;


-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        服务 info
 ******************************************************
 */
@interface resMod_IndexServiceInfo : NSObject{
    int TypeId;
    NSString * TypeName;
    NSString * TypeImg;
}
@property (assign,nonatomic) int TypeId;
@property (strong,nonatomic) NSString * TypeName;
@property (strong,nonatomic) NSString * TypeImg;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        服务种类 列表
 ******************************************************
 */
@interface resMod_IndexServiceList : NSObject{
    int        ServiceId;
    NSString * ServiceName;
    NSMutableArray * ServiceTypeList;
}
@property (assign,nonatomic) int    ServiceId;
@property (strong,nonatomic) NSString * ServiceName;
@property (strong,nonatomic) NSMutableArray * ServiceTypeList;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





/******************************************************
 ---------        back ResponseData
 ******************************************************
 */
@interface resMod_IndexResponseData : NSObject{
    NSMutableArray    * BannerList;
    NSMutableArray    * HotList;
    NSMutableArray    * LowPriceList;
    NSMutableArray    * ServiceList;
}
@property (strong,nonatomic) NSMutableArray * BannerList;
@property (strong,nonatomic) NSMutableArray * HotList;
@property (strong,nonatomic) NSMutableArray * LowPriceList;
@property (strong,nonatomic) NSMutableArray * ServiceList;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        return: response  data
 ******************************************************
 */
@interface resMod_CallBack_IndexData: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_IndexResponseData * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (strong,nonatomic) NSString * ResponseMsg;
@property (strong,nonatomic) resMod_IndexResponseData * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end





