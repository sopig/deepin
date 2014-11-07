//
//  BaseViewLoadingAnimationDelegate.h
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-2.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseViewLoadingAnimationDelegate <NSObject>

@optional

- (void)showLoadingAnimation:(BOOL)isShow Content:(NSString*)content;   //

@end
