//
//  HK_UICustomAlertView.h
//  Ule
//
//  Created by yakun cheng on 12-12-28.
//  Copyright (c) 2012年 Ule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+ColorUtility.h"

@class EC_UICustomAlertView;
@protocol EC_UICustomAlertViewDelegate <NSObject>

@optional

-(void)alertView:(EC_UICustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface EC_UICustomAlertView : UIView<UIScrollViewDelegate>
{
    UIView *_maskView;//遮罩
    
    UIView *_headView;
    UILabel *_titleLabel;
    
    UIImageView *_centerView;
    UILabel *_messageLabel;
    
    UIImageView *_footView;
    UIButton *_okButton;
    UIButton *_cancelButton;
    
    NSString *_title;//标题
    NSString *_message;//内容
    NSString *_okButtonMsg;
    NSString *_cancelButtonMsg;
    
    BOOL _autoHide;
}

@property(nonatomic,assign) id<EC_UICustomAlertViewDelegate> delegate1;

@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *message;
@property (nonatomic,retain) NSString *okButtonMsg;
@property (nonatomic,retain) NSString *cancelButtonMsg;

@property (nonatomic,assign) BOOL autoHide;//是否自动关闭

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonMsg okButtonTitle:(NSString *)okButtonMsg;
- (id)initWithTitle:(NSString *)title message:(NSString *)message;

- (void)show;

- (void)showInView:(UIView *)containerView;

- (void)hide;

@end
