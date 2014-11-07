//
//  TicketCommentModel.m
//  boqiimall
//
//  Created by polly on 14-7-16.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "TicketCommentModel.h"


static TicketCommentModel* g_model = nil;
@implementation TicketCommentModel

- (void)dealloc
{
    
}


+ (id)shareTicketCommentModel
{
    if (g_model == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            g_model = [[[self class]alloc]init];
        });
    }
    return g_model;
}
@end
