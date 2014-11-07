//
//  BQBindTelephoneNumberView.h
//  boqiimall
//
//  Created by 张正超 on 14-8-5.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum stateNO{
    authCodeState = 1,
    setPayPwdState,
    ModifyBindTelephone
} stateNO;

@interface BQBindTelephoneNumberView : UIView

@property(nonatomic,readwrite,strong)UILabel* titleLabel;

@property(nonatomic,readwrite,strong)id delegate;

@property(nonatomic,readwrite,assign)SEL showTipsSelector;
@property(nonatomic,readwrite,assign)SEL apiRequestSelector;
@property(nonatomic,readwrite,assign)SEL cancelButtonSelector;
@property(nonatomic,readwrite,assign)SEL enterButtonSelector;

@property(nonatomic,readwrite,strong)id object;

- (id)initWithFrame:(CGRect)frame titleString:(NSString*)titleString forState:(stateNO)state;
-(void)HUDShow:(NSString*)text delay:(float)second;

- (void)postNotificationToUpdateUserInfo;

@end
