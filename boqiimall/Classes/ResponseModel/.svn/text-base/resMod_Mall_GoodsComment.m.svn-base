//
//  resMod_Mall_GoodsComment.m
//  boqiimall
//
//  Created by YSW on 14-7-4.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_GoodsComment.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

@implementation resMod_Mall_GoodsCommentInfo
@synthesize CommentContent;
@synthesize CommentName;
@synthesize CommentScore;
@synthesize CommentTime;
@synthesize ReplyCommentContent;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CommentContent = [dic ConvertStringForKey:@"CommentContent"];
        self.CommentName  = [dic ConvertStringForKey:@"CommentName"];
        self.CommentScore = [[dic ConvertStringForKey:@"CommentScore"] intValue];
        self.CommentTime  = [dic ConvertStringForKey:@"CommentTime"];
        self.ReplyCommentContent = [dic ConvertStringForKey:@"ReplyCommentContent"];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [CommentContent release];
    [CommentName release];
    [CommentTime release];
    [ReplyCommentContent release];
    [super dealloc];
}
#endif
@end


@implementation resMod_CallBackMall_CommentList
@synthesize ResponseStatus;
@synthesize ResponseMsg;
@synthesize ResponseData;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] intValue];
        self.ResponseMsg = [dic ConvertStringForKey:@"ResponseMsg"];
        
        NSArray * arrResponseData = [dic ConvertArrayForKey:@"ResponseData"];
        self.ResponseData = [[NSMutableArray alloc] initWithCapacity:arrResponseData.count];
        for ( NSDictionary * item in arrResponseData ) {
            [ResponseData addObject:[[resMod_Mall_GoodsCommentInfo alloc] initWithDic:item]];
        }
    }
    return self;
}

//- (NSMutableArray *)ResponseData {
//    
//    if (ResponseData && [ResponseData isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < ResponseData.count; i++) {
//            if([[ResponseData objectAtIndex:i] class] != [resMod_Mall_GoodsCommentInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[ResponseData objectAtIndex:i];
//                [ResponseData replaceObjectAtIndex:i
//                                        withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_GoodsCommentInfo")]];
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