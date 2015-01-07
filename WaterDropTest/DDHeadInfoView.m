//
//  DDHeadInfoView.m
//  DDTimeLineDemo
//
//  Created by tolly on 15/1/6.
//  Copyright (c) 2015年 tolly. All rights reserved.
//

#import "DDHeadInfoView.h"
@interface DDHeadInfoView()

@property BOOL requested;
@property BOOL requesting;
@end

@implementation DDHeadInfoView
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if(newSuperview)
    {
        [self initWaterView];
    }
}
//-(void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    NSLog(@"");
//}
-(void)refresh
{
    if(_waterView.isRefreshing)
    {
        [_waterView startRefreshAnimation];
    }
}
-(void)setIsRefreshed:(BOOL)b
{
    isrefreshed = b;
}
-(void)initWaterView
{
    __weak DDHeadInfoView* wself =self;
    //采用默认参数
    [_waterView loadWaterView];
    [_waterView setHandleRefreshEvent:^{
        [wself setIsRefreshed:YES];
        if(wself.handleRefreshEvent)
        {
            wself.handleRefreshEvent();
        }
    }];
}
-(void)setTouching:(BOOL)touching
{
    if(touching)
    {
        if(hasStop)
        {
            [self resetTouch];
        }
        
        if(touch1)
        {
            touch2 = YES;
        }
        else if(touch2 == NO && _waterView.isRefreshing == NO)
        {
            touch1 = YES;
        }
    }
    else if(_waterView.isRefreshing == NO)
    {
        [self resetTouch];
    }
    _touching = touching;
}
-(void)resetTouch
{
    touch1 = NO;
    touch2 = NO;
    hasStop = NO;
    isrefreshed = NO;
}
-(void)stopRefresh
{
    [_waterView stopRefresh];
    if(_touching == NO)
    {
        [self resetTouch];
    }
    else
    {
        hasStop = YES;
    }
}
-(void)setOffsetY:(float)y
{
    _offsetY = y;
    CGRect frame = _showView.frame;
    if(y<0)
    {
        //头像位置调整
        if((_waterView.isRefreshing) || hasStop)
        {
            if(touch1 && touch2 == NO)
            {
                frame.origin.y = 20+y;
                _showView.frame = frame;
            }
            else
            {
                if(frame.origin.y != 20)
                {
                    frame.origin.y = 20;
                    _showView.frame = frame;
                }
            }
        }
        else
        {
            frame.origin.y = 20+y;
            _showView.frame = frame;
        }
    }
    else{
        if(touch1 && _touching && isrefreshed)
        {
            touch2 = YES;
        }
        if(frame.origin.y != 20)
        {
            frame.origin.y = 20;
            _showView.frame = frame;
        }
    }
    if (hasStop == NO) {
        //水滴拉伸效果
        _waterView.currentOffset = y;
    }
    
    // 视差滚动
    UIView* bannerSuper = _img_banner.superview;
    CGRect bframe = bannerSuper.frame;
    if(y<0)
    {
        bframe.origin.y = y;
        bframe.size.height = -y + bannerSuper.superview.frame.size.height;
        bannerSuper.frame = bframe;
        
        CGPoint center =  _img_banner.center;
        center.y = bannerSuper.frame.size.height/2;
        _img_banner.center = center;
    }
    else{
        if(bframe.origin.y != 0)
        {
            bframe.origin.y = 0;
            bframe.size.height = bannerSuper.superview.frame.size.height;
            bannerSuper.frame = bframe;
        }
        if(y<bframe.size.height)
        {
            CGPoint center =  _img_banner.center;
            center.y = bannerSuper.frame.size.height/2 + 0.5*y;
            _img_banner.center = center;
        }
    }
}
@end
