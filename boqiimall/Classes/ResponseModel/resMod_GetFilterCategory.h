//
//  resMod_GetFilterCategory.h
//  BoqiiLife
//
//  Created by YSW on 14-5-9.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

/******************************************************
 ---------        Category  Sort info    :服务筛选分类信息
 ******************************************************
 */
@interface resMod_CategoryInfo : NSObject{
    NSString * SubTypeName;
    int SubTypeId;
    NSString * Type;
    BOOL isChecked;
}
@property (retain,nonatomic) NSString * SubTypeName;
@property (assign,nonatomic) int SubTypeId;
@property (retain,nonatomic) NSString * Type;
@property (assign,nonatomic) BOOL isChecked;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

/******************************************************
 ---------       responseData : 服务分类
 ******************************************************
 */
@interface resMod_CategoryList : NSObject{
    NSString * CategoryId;
    int TypeId;
    NSString * TypeName;
    NSMutableArray * TypeList;
    BOOL isSelect_parent;
}
@property (assign,nonatomic) int TypeId;
@property (assign,nonatomic) BOOL isSelect_parent;
@property (retain,nonatomic) NSString * CategoryId;
@property (retain,nonatomic) NSString * TypeName;
@property (retain,nonatomic) NSMutableArray * TypeList;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


//  --  保存选中的 ： 筛选条件
@interface resMod_filterWhere : NSObject{
    
    NSString * parentTableId;
    NSString * parentTableValue;
    
    NSString * subTableId;
    NSString * subTableVlaue;
    NSString * subTableProperty1;
    NSString * subTableProperty2;
}

@property (retain,nonatomic) NSString * parentTableId;
@property (retain,nonatomic) NSString * parentTableValue;
@property (retain,nonatomic) NSString * subTableId;
@property (retain,nonatomic) NSString * subTableVlaue;
@property (retain,nonatomic) NSString * subTableProperty1;
@property (retain,nonatomic) NSString * subTableProperty2;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

/******************************************************
 ---------        Area  Sort info       :区域筛选分类信息
 ******************************************************
 */
//@interface resMod_AreaTypeInfo : NSObject{
//    NSString * SubAreaName ;
//    int SubAreaId;
//}
//@property (retain,nonatomic) NSString * SubAreaName;
//@property (assign,nonatomic) int SubAreaId;
//@end



/******************************************************
 ---------       responseData : 区域分类
 ******************************************************
 */
//@interface resMod_AreaTypeList : NSObject{
//    NSString * AreaName;
//    NSMutableArray * AreaList;
//}
//@property (retain,nonatomic) NSString * AreaName;
//@property (retain,nonatomic) NSMutableArray * AreaList;
//@end


/******************************************************
 ---------        Merchant Sort  info    :商户筛选分类信息
 ******************************************************
 */
//@interface resMod_MerchantSortTypeInfo: NSObject{
//    NSString * TypeName ;
//    int TypeId;
//}
//@property (retain,nonatomic) NSString * TypeName;
//@property (assign,nonatomic) int TypeId;
//@end





/******************************************************
 ---------       return: response  data   服务筛选分类
 ******************************************************
 */
@interface resMod_CallBack_FilterCategory: NSObject{
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
 ---------       return: response  data   区域筛选分类
 ******************************************************
 */
//@interface resMod_CallBack_AreaType: NSObject{
//    int ResponseStatus;
//    NSString * ResponseMsg;
//    NSMutableArray * ResponseData;
//}
//@property (assign,nonatomic) int ResponseStatus;
//@property (retain,nonatomic) NSString * ResponseMsg;
//@property (retain,nonatomic) NSMutableArray * ResponseData;
//@end



/******************************************************
 ---------       return: response  data   商户筛选分类
 ******************************************************
 */
//@interface resMod_CallBack_MerchantSort: NSObject{
//    int ResponseStatus;
//    NSString * ResponseMsg;
//    NSMutableArray * ResponseData;
//}
//@property (assign,nonatomic) int ResponseStatus;
//@property (retain,nonatomic) NSString * ResponseMsg;
//@property (retain,nonatomic) NSMutableArray * ResponseData;
//@end



