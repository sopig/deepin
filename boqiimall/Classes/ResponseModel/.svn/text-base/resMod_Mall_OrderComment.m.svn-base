//
//  resMod_Mall_OrderComment.m
//  boqiimall
//
//  Created by YSW on 14-7-16.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "resMod_Mall_OrderComment.h"
#import "NSDictionary+JudgeObj.h"
#import "NSDictionary+JSON.h"

//  --。。。。。。。。。。。。。。。。。。。。。。。。。
@implementation resMod_Mall_OrderCommentGoodsInfo
@synthesize GoodsId;
@synthesize GoodsTitle;
@synthesize GoodsImg;
@synthesize GoodsOriPrice;
@synthesize GoodsPrice;
@synthesize GoodsScore;
@synthesize GoodsSpecId;
@synthesize GoodsPackageId;

//  --  评论用到的扩展
@synthesize GoodsComment;
@synthesize DescriptionScore;
@synthesize SatisfactionScore;
@synthesize SpeedScore;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.GoodsId = [[dic ConvertStringForKey:@"GoodsId"] intValue];
        self.GoodsTitle = [dic ConvertStringForKey:@"GoodsTitle"];
        self.GoodsImg   = [dic ConvertStringForKey:@"GoodsImg"];
        self.GoodsOriPrice  = [[dic ConvertStringForKey:@"GoodsOriPrice"] floatValue];
        self.GoodsPrice  = [[dic ConvertStringForKey:@"GoodsPrice"] floatValue];
        self.GoodsScore  = [[dic ConvertStringForKey:@"GoodsScore"] floatValue];
        self.GoodsSpecId  = [dic ConvertStringForKey:@"GoodsSpecId"];
        self.GoodsPackageId  = [[dic ConvertStringForKey:@"GoodsPackageId"] intValue];
        
        self.GoodsComment  = [dic ConvertStringForKey:@"GoodsComment"];
        self.DescriptionScore  = [[dic ConvertStringForKey:@"DescriptionScore"] intValue];
        self.SatisfactionScore = [[dic ConvertStringForKey:@"SatisfactionScore"] intValue];
        self.SpeedScore  = [[dic ConvertStringForKey:@"SpeedScore"] intValue];
    }
    return self;
}


#if ! __has_feature(objc_arc)
- (void) dealloc{
    [GoodsTitle release];
    [GoodsImg release];
    
    [GoodsSpecId release];
    [GoodsComment release];
    [super dealloc];
}
#endif
@end


//  --。。。。。。。。。。。。。。。。。。。。。。。。。
@implementation resMod_Mall_OrderCommentInfo
@synthesize CommentTips;
@synthesize GoodsCommentList;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.CommentTips = [dic ConvertStringForKey:@"CommentTips"];
        
        NSArray * arrGoodsCommentList = [dic ConvertArrayForKey:@"GoodsCommentList"];
        self.GoodsCommentList = [[NSMutableArray alloc] initWithCapacity:arrGoodsCommentList.count];
        for (NSDictionary * item in arrGoodsCommentList) {
            [GoodsCommentList addObject:[[resMod_Mall_OrderCommentGoodsInfo alloc] initWithDic:item]];
        }
    }
    return self;
}
//- (NSMutableArray *)GoodsCommentList {
//    if (GoodsCommentList && [GoodsCommentList isKindOfClass:[NSArray class]]) {
//        for (int i = 0; i < GoodsCommentList.count; i++) {
//            if([[GoodsCommentList objectAtIndex:i] class] != [resMod_Mall_OrderCommentGoodsInfo class]){
//                NSDictionary * _dic = (NSDictionary *)[GoodsCommentList objectAtIndex:i];
//                [GoodsCommentList replaceObjectAtIndex:i
//                                        withObject:[_dic dictionaryTo:NSClassFromString(@"resMod_Mall_OrderCommentGoodsInfo")]];
//            }
//        }
//        return GoodsCommentList;
//    }
//    else{
//        return nil;
//    }
//}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [CommentTips release];
    [GoodsCommentList release];
    [super dealloc];
}
#endif
@end







//  --。。。。。。。。。。。。。。。。。。。。。。。。。
@implementation resMod_CallBackMall_GoodsForOrderComment
@synthesize ResponseData;
@synthesize ResponseMsg;
@synthesize ResponseStatus;

-(instancetype)initWithDic:(NSDictionary*)dic{
    if (self=[super init]) {
        self.ResponseStatus = [[dic ConvertStringForKey:@"ResponseStatus"] floatValue];
        self.ResponseMsg  = [dic ConvertStringForKey:@"ResponseMsg"];
        self.ResponseData = [[resMod_Mall_OrderCommentInfo alloc]initWithDic:[dic ConvertDictForKey:@"ResponseData"]];
    }
    return self;
}

#if ! __has_feature(objc_arc)
- (void) dealloc{
    [ResponseData release];
    [ResponseMsg release];
    [super dealloc];
}
#endif
@end



