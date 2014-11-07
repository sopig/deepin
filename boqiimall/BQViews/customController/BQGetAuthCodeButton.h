//
//  BQGetAuthCodeButton.h
//  boqiimall
//
//  用于获取验证码的按钮
//
//
//  Created by 张正超 on 14-8-7.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 SendAuthCode（原接口修改）
 
 参数：
 Account	String	账号
 Type	Int	类别
 
 1:绑定手机验证码
 2:修改绑定手机验证码
 3:修改支付密码验证码
 
 */

typedef enum SendAuthCodeType{
    bindTelePhoneAuthCode =1,
    modifyTelePhoneAuthCode,
    modifyPayPasswordAuthCode
}SendAuthCodeType ;


//typedef void(^repeat)();
//typedef void(^reback)();

@interface BQGetAuthCodeButton : UIButton<InterfaceAPIDelegate>

//属性参数
@property(nonatomic,readwrite,assign)SendAuthCodeType type;
@property(nonatomic,readwrite,copy)NSString *account;

@property(nonatomic,readwrite,strong)id delegate;
@property(nonatomic,readwrite,assign)SEL refreshUISelector;



//需要验证的输入框是否输入了手机号
@property(nonatomic,readwrite,strong)UITextField *inputTextFiled;


//注册按钮事件时是否需要传的参数
@property                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           id object;

//@property(nonatomic,readwrite,assign)repeat repeatBlock;
//@property(nonatomic,readwrite,assign)reback rebackBlock;


//需要将提示框加到delegate的View上（假设delegate为ViewController）
@property(nonatomic,readwrite,strong)UIView *HUDTargetView;


@property(nonatomic,readwrite,assign)int timerSencond;

//开启定时器
//- (void)startTimer;
- (void) onGetCodeClick:(id) sender;


@end
