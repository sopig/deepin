//
//  BQAlertView.h
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-1.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AlertAnimation) {
    AlertAnimationDefault = 0,
	AlertAnimationFade,
	AlertAnimationFlipHorizontal,
	AlertAnimationFlipVertical,
	AlertAnimationTumble,
	AlertAnimationSlideLeft,
	AlertAnimationSlideRight
};   //动画处理类型，可以继续添加，


@interface BQAlertView : UIView

typedef void (^AlertViewBlock)(NSInteger buttonIndex, BQAlertView *alertView);

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) BOOL darkenBackground;
@property (nonatomic, assign) BOOL blurBackground;

+ (BQAlertView *)dialogWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle;

- (NSInteger)addButtonWithTitle:(NSString *)title;
- (void)setHandlerBlock:(AlertViewBlock)block;

- (void)show;
- (void)showWithCompletionBlock:(void(^)())completion;
- (void)showWithAnimation:(AlertAnimation)animation;
- (void)showWithAnimation:(AlertAnimation)animation completionBlock:(void(^)())completion;

- (void)hide;
- (void)hideWithCompletionBlock:(void(^)())completion;
- (void)hideWithAnimation:(AlertAnimation)animation;
- (void)hideWithAnimation:(AlertAnimation)animation completionBlock:(void(^)())completion;

@end
