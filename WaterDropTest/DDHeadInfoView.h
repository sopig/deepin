//
//  DDHeadInfoView.h
//  DDTimeLineDemo
//
//  Created by tolly on 15/1/6.
//  Copyright (c) 2015年 tolly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDWaterDropView.h"

@interface DDHeadInfoView : UIView
{
    BOOL touch1,touch2,hasStop;
    BOOL isrefreshed;
}
@property (weak, nonatomic) IBOutlet UIImageView *img_banner;
@property (weak, nonatomic) IBOutlet UIButton *bt_avatar;
@property (weak, nonatomic) IBOutlet DDWaterDropView *waterView;
@property (weak, nonatomic) IBOutlet UIView *showView;

//注意看 scrollView 的回调
@property(nonatomic) BOOL touching;
@property(nonatomic) float offsetY;

@property(copy,nonatomic)void(^handleRefreshEvent)(void) ;
-(void)stopRefresh;
@end
