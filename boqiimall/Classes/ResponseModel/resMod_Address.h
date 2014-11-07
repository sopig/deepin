//
//  resMod_Address.h
//  boqiimall
//
//  Created by YSW on 14-7-7.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_AddressInfo : NSObject{
    NSString * UserName;	//--    String	用户姓名
    int AddressId;          //--    Int	地址id
    int AddressProvinceId;	//--    Int	省份id
    int AddressCityId;      //--    Int	市id
    int AddressAreaId;      //--    Int	区id
    NSString * AddressProvince;	//--    String	省份
    NSString * AddressCity;     //--    String	市
    NSString * AddressArea;     //--    String	区
    NSString * AddressDetail;	//--    String	具体地址
    NSString * Mobile;	//--    Sting	手机号码
    NSString * Phone;	//--    String	电话号码
    NSString * ZipCode;	//--    String	邮编
    int IsDefault;      //--    Int	是否是默认地址

}

@property (retain,nonatomic) NSString * UserName;	//--    String	用户姓名
@property (assign,nonatomic) int AddressId;         //--    Int	地址id
@property (assign,nonatomic) int AddressProvinceId;	//--    Int	省份id
@property (assign,nonatomic) int AddressCityId;     //--    Int	市id
@property (assign,nonatomic) int AddressAreaId;     //--    Int	区id
@property (retain,nonatomic) NSString * AddressProvince;	//--    String	省份
@property (retain,nonatomic) NSString * AddressCity;	//--    String	市
@property (retain,nonatomic) NSString * AddressArea;	//--    String	区
@property (retain,nonatomic) NSString * AddressDetail;	//--    String	具体地址
@property (retain,nonatomic) NSString * Mobile;         //--    Sting	手机号码
@property (retain,nonatomic) NSString * Phone;          //--    String	电话号码
@property (retain,nonatomic) NSString * ZipCode;        //--    String	邮编
@property (assign,nonatomic) int IsDefault;             //--    Int	是否是默认地址

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




/******************************************************
 ---------        地址列表
 ******************************************************
 */
@interface resMod_CallBack_AddressList : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end



/******************************************************
 ---------        添加地址
 ******************************************************
 */
@interface resMod_CallBack_AddUserAddress : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_AddressInfo * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_AddressInfo * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end
