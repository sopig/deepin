//
//  resMod_Mall_OrderComment.h
//  boqiimall
//
//  Created by YSW on 14-7-16.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/******************************************************
 ---------        品评商品信息
 ******************************************************
 */
@interface resMod_Mall_OrderCommentGoodsInfo : NSObject{
    int     GoodsId;
    float   GoodsPrice;         //--现价
    float   GoodsOriPrice;      //--原价
    float   GoodsScore;         //--评分
    NSString    *   GoodsSpecId;
    int     GoodsPackageId;
    NSString    *   GoodsTitle;
    NSString    *   GoodsImg;

    //  --  评论用到的扩展
    NSString    *   GoodsComment;
    int     DescriptionScore;
    int     SatisfactionScore;
    int     SpeedScore;
}

@property   (assign, nonatomic) int     GoodsId;
@property   (assign, nonatomic) float   GoodsPrice;         //--现价
@property   (assign, nonatomic) float   GoodsOriPrice;      //--原价
@property   (assign, nonatomic) float   GoodsScore;
@property   (retain, nonatomic) NSString    *        GoodsSpecId;
@property   (assign, nonatomic) int     GoodsPackageId;
@property   (retain, nonatomic) NSString    *   GoodsTitle;
@property   (retain, nonatomic) NSString    *   GoodsImg;

//  --  评论用到的扩展
@property   (retain, nonatomic) NSString    *   GoodsComment;
@property   (assign, nonatomic) int     DescriptionScore;
@property   (assign, nonatomic) int     SatisfactionScore;
@property   (assign, nonatomic) int     SpeedScore;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


/******************************************************
 ---------        品论订单 信息
 ******************************************************
 */
@interface resMod_Mall_OrderCommentInfo : NSObject{
    NSString    *   CommentTips;
    NSMutableArray    *   GoodsCommentList;
}

@property   (retain, nonatomic) NSString    *   CommentTips;
@property   (retain, nonatomic) NSMutableArray    *   GoodsCommentList;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end






/******************************************************
 ---------        return  : call back  订单商品点评信息
 ******************************************************
 */
@interface resMod_CallBackMall_GoodsForOrderComment: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    resMod_Mall_OrderCommentInfo * ResponseData;
}
@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) resMod_Mall_OrderCommentInfo * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end

