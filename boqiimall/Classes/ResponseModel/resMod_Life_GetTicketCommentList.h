//
//  resMod_Life_GetTicketCommentList.h
//  boqiimall
//
//  Created by 张正超 on 14-7-18.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resMod_Life_GetTicketCommentList : NSObject
@property(nonatomic,readwrite,strong)NSString* CommentContent;
@property(nonatomic,readwrite,strong)NSString* CommentName;
@property(nonatomic,readwrite,strong)NSString* CommentTime;
@property(nonatomic,readwrite,assign)float CommentScore;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end




/******************************************************
 ---------       call back list
 ******************************************************
 */
@interface resMod_CallBack_GetTicketCommentList : NSObject{
    int ResponseStatus;
    NSString * ResponseMsg;
    NSMutableArray * ResponseData;
}

@property (assign,nonatomic) int ResponseStatus;
@property (retain,nonatomic) NSString * ResponseMsg;
@property (retain,nonatomic) NSMutableArray * ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic;
@end










