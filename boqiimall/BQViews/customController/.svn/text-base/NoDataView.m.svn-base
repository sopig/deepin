//
//  NoDataView.m
//  BoqiiLife
//
//  Created by YSW on 14-5-29.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView
@synthesize noDataImg;
@synthesize noDataMsg;

@synthesize isHidden,warnMsg;

- (id)initWithFrame:(CGRect)frame msgForNoData:(NSString *) _msg isHidden:(BOOL) hidden{
    self = [super initWithFrame:frame];
    if (self) {
        self.warnMsg = _msg;
        self.isHidden = hidden;
        [self initView:frame];
    }
    return self;
}

- (void) initView:(CGRect) frame{
    
    [self setHidden:self.isHidden];
    
    //  -- 空数据 ：图标
    self.noDataImg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-115/4-6, 110, 115/2, 167/2)];
    [self.noDataImg setBackgroundColor:[UIColor clearColor]];
    [self.noDataImg setImage:[UIImage imageNamed:@"img_nodata.png"]];
    [self addSubview:self.noDataImg];
    
    //  -- 空数据 ：提示
    self.noDataMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, self.noDataImg.frame.size.height+self.noDataImg.frame.origin.y+15, frame.size.width, 40)];
    [self.noDataMsg setText: self.warnMsg.length==0 ? @"抱歉，我们未找到相关数据" : self.warnMsg];
    [self.noDataMsg setTextAlignment:NSTextAlignmentCenter];
    [self.noDataMsg setBackgroundColor:[UIColor clearColor]];
    [self.noDataMsg setFont:defFont13];
    [self.noDataMsg setTextColor:color_717171];
    [self addSubview:self.noDataMsg];
}

- (void) noDataViewIsHidden:(BOOL) hidden warnImg:(NSString*) img warnMsg:(NSString *) _msg{
    [self setHidden:hidden];
    
    if (!hidden) {
        [self.superview bringSubviewToFront:self];
    }
    
    if (img.length>0)
        [self.noDataImg setImage:[UIImage imageNamed:img]];
    if (_msg.length>0)
        [self.noDataMsg setText:_msg];
}

@end
