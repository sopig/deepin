//
//  resMod_Mall_GoodsComment.h
//  boqiimall
//
//  Created by YSW on 14-7-4.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//  --  传给服务器的 商品列表信息
@interface resMod_Mall_GoodsCommentInfo : NSObject{
    NSString * CommentContent;
    NSString * CommentName;
    NSString * CommentTime;
    int CommentScore;
    NSString * ReplyCommentContent;
}
@property (retain,nonatomic) NSString * CommentContent;
@property (retain,nonatomic) NSString * CommentName;
@property (retain,nonatomic) NSString * CommentTime;
@property (retain,nonatomic) NSString * ReplyCommentContent;
@property (assign,nonatomic) int CommentScore;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end






/******************************************************
 ---------        return  : call back
 ******************************************************
 */
@interface resMod_CallBackMall_CommentList: NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end


