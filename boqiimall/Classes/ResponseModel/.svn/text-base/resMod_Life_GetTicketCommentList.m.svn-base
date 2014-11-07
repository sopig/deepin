//
//  resMod_Life_GetTicketCommentList.m
//  boqiimall
//
//  Created by 张正超 on 14-7-18.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Life_GetTicketCommentList.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

@implementation resMod_Life_GetTicketCommentList
@synthesize CommentContent,CommentName,CommentScore,CommentTime;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CommentContent = [dic ConvertStringForKey:@"CommentContent"];
        self.CommentName  = [dic ConvertStringForKey:@"CommentName"];
        self.CommentScore = [[dic ConvertStringForKey:@"CommentScore"] floatValue];
        self.CommentTime  = [dic ConvertStringForKey:@"CommentTime"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
-(void)dealloc{
    [CommentContent release];
    [CommentName release];
    [CommentTime release];
    [super dealloc];
}
#endif
@end





//*****CallBack  list
@implementation resMod_CallBack_GetTicketCommentList
@synthesize ResponseData,ResponseMsg,ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] floatValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray *tmpResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc]initWithCapacity:tmpResponseData.count];
        for (NSDictionary *item in tmpResponseData) {
            [ResponseData addObject:[[resMod_Life_GetTicketCommentList alloc]initWithDic:item]];
        }
    }
    return self;
}


//- (NSMutableArray *)ResponseData{
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_Life_GetTicketCommentList class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Life_GetTicketCommentList")]];
//            }
//        }
//        return ResponseData;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
- (void)dealloc{
    [ResponseMsg release];
    [ResponseData release];
    [super dealloc];
}
#endif
@end






