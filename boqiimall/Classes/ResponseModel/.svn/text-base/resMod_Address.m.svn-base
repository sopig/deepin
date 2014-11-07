//
//  resMod_Address.m
//  boqiimall
//
//  Created by YSW on 14-7-7.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Address.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

@implementation resMod_AddressInfo
@synthesize UserName;           //--    String	用户姓名
@synthesize AddressId;          //--    Int	地址id
@synthesize AddressProvinceId;	//--    Int	省份id
@synthesize AddressCityId;      //--    Int	市id
@synthesize AddressAreaId;      //--    Int	区id
@synthesize AddressProvince;	//--    String	省份
@synthesize AddressCity;	//--    String	市
@synthesize AddressArea;	//--    String	区
@synthesize AddressDetail;	//--    String	具体地址
@synthesize Mobile;         //--    Sting	手机号码
@synthesize Phone;          //--    String	电话号码
@synthesize ZipCode;        //--    String	邮编
@synthesize IsDefault;      //--    Int	是否是默认地址

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.UserName = [dic ConvertStringForKey:@"UserName"];
        self.AddressId = [[dic ConvertStringForKey:@"AddressId"] intValue];
        self.AddressProvinceId = [[dic ConvertStringForKey:@"AddressProvinceId"] intValue];
        self.AddressCityId = [[dic ConvertStringForKey:@"AddressCityId"] intValue];
        self.AddressAreaId = [[dic ConvertStringForKey:@"AddressAreaId"] intValue];
        self.AddressProvince = [dic ConvertStringForKey:@"AddressProvince"];
        self.AddressCity = [dic ConvertStringForKey:@"AddressCity"];
        self.AddressArea = [dic ConvertStringForKey:@"AddressArea"];
        self.AddressDetail = [dic ConvertStringForKey:@"AddressDetail"];
        self.Mobile = [dic ConvertStringForKey:@"Mobile"];
        self.Phone = [dic ConvertStringForKey:@"Phone"];
        self.ZipCode = [dic ConvertStringForKey:@"ZipCode"];
        self.IsDefault = [[dic ConvertStringForKey:@"IsDefault"] intValue];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    [UserName release];
    [AddressProvince release];
    [AddressCity release];
    [AddressArea release];
    [AddressDetail release];
    [Mobile release];
    [Phone release];
    [ZipCode release];
    [super dealloc];
}
#endif
@end

//  --................
@implementation resMod_CallBack_AddressList
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:tmpResponseData.count];
        for (NSDictionary * item in tmpResponseData) {
            [ResponseData addObject:[[resMod_AddressInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_AddressInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_AddressInfo")]];
//            }
//        }
//        return ResponseData;
//    }
//    return nil;
//}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end


//  --................
@implementation resMod_CallBack_AddUserAddress
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_AddressInfo alloc] initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end