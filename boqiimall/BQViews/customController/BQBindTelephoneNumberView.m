//
//  BQBindTelephoneNumberView.m
//  boqiimall
//
//  Created by 张正超 on 14-8-5.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQBindTelephoneNumberView.h"
#import "MBProgressHUD.h"

//#import "BQUpdateUserInfo.h"

@interface BQBindTelephoneNumberView ()<UITextFieldDelegate,MBProgressHUDDelegate>
{
    int timerSencond;
    UITextField *textFiled1;
    UITextField *textFiled2;
    UIButton *getCodeButton;
    MBProgressHUD* HUD;
    BOOL isShowTxtPwd;
    stateNO _gstate;
    UIView *bgView;
    
}
@end

@implementation BQBindTelephoneNumberView


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"


- (id)initWithFrame:(CGRect)frame titleString:(NSString*)titleString forState:(stateNO)state
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        BQNavBarView *navBarView = [[BQNavBarView alloc] initWithFrame:CGRectMake(0, 0,__MainScreen_Width, kNavBarViewHeight)];
//        [navBarView setBackgroundColor:[UIColor whiteColor]];
//        [self addSubview:navBarView];
//        UIView *subNavBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//        [navBarView addSubview:subNavBarView];
//        
//        UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(4, 7, 30, 30)];
//        [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//        [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//       // [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//        [subNavBarView addSubview:backBtn];
//        
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        [_titleLabel setTextColor:color_333333];
//        [_titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:18]];
//        [subNavBarView addSubview:_titleLabel];
        
        _gstate = state;
        
        bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 120, 300, 250)];
        bgView.layer.cornerRadius = 5.0f;
        bgView.backgroundColor = [UIColor convertHexToRGB:@"f1f1f1"];

        [self addSubview:bgView];
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        
        CGSize defaultSize = CGSizeMake(self.frame.size.width, 80);
        CGSize size = [titleString sizeWithFont:defFont14 constrainedToSize:defaultSize];
        
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(300/2 - size.width/2 , 3, size.width, 40)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.text = titleString;
        _titleLabel.font = defFont(YES, 14);
        _titleLabel.textColor = [UIColor convertHexToRGB:@"383838"];
        [bgView addSubview:_titleLabel];
        
        
        [UICommon Common_line:CGRectMake(0, 40.5, 300, 0.5) targetView:bgView backColor:color_dedede];
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 41, 300, 250 - 41)];
        contentView.layer.cornerRadius = 5.0f;
        contentView.backgroundColor = [UIColor whiteColor];
        [bgView addSubview:contentView];
        
        UIView *textBgView1 = [[UIView alloc]initWithFrame:CGRectMake(20, 12, 260, 50)];
        textBgView1.layer.cornerRadius = 5.0f;
        textBgView1.layer.borderColor = color_dedede.CGColor;
        textBgView1.layer.borderWidth = 0.5;
        [contentView addSubview:textBgView1];
        
        
        
        NSString *iconImageString = @"";
        NSString *placeHolder = @"";
        CGRect rect = CGRectZero;
        NSString *buttonTitle = @"";
        if (state == authCodeState) {
            iconImageString = @"phone_icon.png";
            placeHolder = @"  输入手机号";
            buttonTitle = @"完 成";
            rect = CGRectMake(51, 5, 200, 40);
        }
        else if (state == setPayPwdState){
            isShowTxtPwd = NO;
            iconImageString = @"password_icon.png";
            placeHolder = @"  设置支付密码";
            buttonTitle = @"确 认";
            rect = CGRectMake(51, 5, 170, 40);
        }
       
        
//        phone_icon.png
        UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40, 40)];
        iconImageView.image = [UIImage imageNamed:iconImageString];
        [textBgView1 addSubview:iconImageView];
        
        
        textFiled1 = [[UITextField alloc]initWithFrame:rect];
//        textFiled1.layer.borderWidth = 1;
//        textFiled1.layer.borderColor = [UIColor redColor].CGColor;
        
        textFiled1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textFiled1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        textFiled1.layer.cornerRadius = 3.0f;
        textFiled1.placeholder = placeHolder;
        textFiled1.font = defFont14;
        textFiled1.textColor = [UIColor convertHexToRGB:@"dbdbdb"];
        [textBgView1 addSubview:textFiled1];
        textFiled1.delegate = self;
        if (state == setPayPwdState) {
            textFiled1.secureTextEntry = YES;
            
            UIButton * showPwdButton = [[UIButton alloc] initWithFrame:CGRectMake(225, 5, 40, 40)];
            [showPwdButton setBackgroundColor:[UIColor clearColor]];
            [showPwdButton setImage:[UIImage imageNamed:@"visible_icon.png"] forState:UIControlStateNormal];
            [showPwdButton addTarget:self action:@selector(onShowPwdClick:) forControlEvents:UIControlEventTouchUpInside];
            [textBgView1 addSubview:showPwdButton];
//            showPwdButton.layer.borderColor = [UIColor redColor].CGColor;
//            showPwdButton.layer.borderWidth = 1;

            
        }
        
        
        if (state == authCodeState) {
            UIView *textBgView2 = [[UIView alloc]initWithFrame:CGRectMake(20, 74, 260, 50)];
            textBgView2.layer.cornerRadius = 5.0f;
            textBgView2.layer.borderColor = color_dedede.CGColor;
            textBgView2.layer.borderWidth = 0.5;
            [contentView addSubview:textBgView2];
            
            textFiled2 = [[UITextField alloc]initWithFrame:CGRectMake(5, 5, 260 - 120, 40)];
            //        textFiled2.layer.borderWidth = 1;
            //        textFiled2.layer.borderColor = [UIColor redColor].CGColor;
            textFiled2.layer.cornerRadius = 3.0f;
            textFiled2.placeholder = @" 输入验证码";
            textFiled2.font = defFont14;
            textFiled2.textColor = [UIColor convertHexToRGB:@"dbdbdb"];
              textFiled2.delegate = self;
            
            textFiled2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textFiled2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            
            [textBgView2 addSubview:textFiled2];
            
            
            //  -- 获取验证码.
            getCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(260 - 120, 0, 120 , 50)];
            
            [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            
            getCodeButton.layer.cornerRadius = 5.0f;
            [getCodeButton.titleLabel setFont: defFont15];
            
            [getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [getCodeButton setBackgroundImage: def_ImgStretchable(@"test_get_code_bg.png", 5, 5) forState:UIControlStateNormal];
            
            [getCodeButton addTarget:self action:@selector(onGetCodeClick:) forControlEvents:UIControlEventTouchUpInside];
            [textBgView2 addSubview:getCodeButton];
            
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(handleTimer:) userInfo:nil repeats: YES];
            timerSencond = -100;


        }
        else if (state == setPayPwdState){
            UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 74, 260, 40)];
            tipsLabel.font = defFont12;
            tipsLabel.textColor = color_989898;
            tipsLabel.text = @"由字母和数字或者符号至少两种组合的8-20位字符，区分大小写";
            tipsLabel.numberOfLines = 0;
            [contentView addSubview:tipsLabel];
        }
        
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(20, 136, (260 - 15)/2, 50);
        cancelButton.titleLabel.font = defFont18;
        [cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.backgroundColor = color_989898;
        cancelButton.layer.cornerRadius = 3.0f;
        [contentView addSubview:cancelButton];
        
        [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
       
        
        
        UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        enterButton.frame = CGRectMake(20 + (260 - 15)/2 + 15, 136, (260 - 15)/2, 50);
        enterButton.titleLabel.font = defFont18;
        [enterButton setTitle:buttonTitle forState:UIControlStateNormal];
        [enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        enterButton.backgroundColor = color_fc4a00;
        enterButton.layer.cornerRadius = 5.0f;
        [contentView addSubview:enterButton];
        
        [enterButton addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
        
    
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resignkeyBoard) name:@"resignkeyBoard" object:nil];
        
   }
    return self;
}


- (void)resignkeyBoard{
    [textFiled1 resignFirstResponder];
     [textFiled2 resignFirstResponder];
}

- (void) onShowPwdClick:(id) sender{
    isShowTxtPwd = !isShowTxtPwd;
    if (isShowTxtPwd) {
        [textFiled1 setSecureTextEntry:NO];
        [sender setImage:[UIImage imageNamed:@"visible_icon_sel.png"] forState:UIControlStateNormal];
    }else{
        [textFiled1 setSecureTextEntry:YES];
        [sender setImage:[UIImage imageNamed:@"visible_icon.png"] forState:UIControlStateNormal];
    }
}

//  -- 获取验证码
- (void) onGetCodeClick:(id) sender{
         [self resignkeyBoard];
    
    if ( timerSencond != -100 ) {   //  -- 说明这个时候还没到60秒
        return;
    }
    
    if (![NSString isPhoneNum:textFiled1.text]) {
        [self HUDShow:@"请输入正确的手机号" delay:1];
        return;
    }
    
    timerSencond = 120;
    
    [getCodeButton setBackgroundImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:textFiled1.text forKey:@"Account"];
    [dicParams setValue:[NSString stringWithFormat:@"1"] forKey:@"Type"];
    
    
    if ([self.delegate respondsToSelector:self.apiRequestSelector]) {
        [self.delegate performSelector:self.apiRequestSelector withObject:dicParams];
    }
    
}


//  -- 60秒后重新发送
- (void) handleTimer: (NSTimer *) timer{
    
    if (timerSencond>0) {
        timerSencond--;
        [getCodeButton setTitle:[NSString stringWithFormat:@"%d秒后重新获取",timerSencond] forState:UIControlStateNormal];
        [getCodeButton setBackgroundImage:def_ImgStretchable(@"test_get_code_bg_gray.png", 5, 5) forState:UIControlStateNormal];
        if (timerSencond==0) {
            timerSencond = -100;
        }
    }
    else if( timerSencond == -100){
        [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [getCodeButton setBackgroundImage:def_ImgStretchable(@"test_get_code_bg.png", 5, 5) forState:UIControlStateNormal];
    }
}



- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
     [self resignkeyBoard];
    
}


- (void)cancel:(id)sender{
     [self resignkeyBoard];
    if ([self.delegate respondsToSelector:self.cancelButtonSelector]) {
        [self.delegate performSelector:self.cancelButtonSelector withObject:sender];
    }

}




- (void)enter:(id)sender{
    
    [self resignkeyBoard];
        if (_gstate == authCodeState) {
            
            if (textFiled1.text.length == 0  || textFiled2.text.length == 0) {
                
                [self HUDShow:@"请输入手机号和验证码" delay:1];
                
                return;
            }
            
            if ([self.delegate respondsToSelector:self.enterButtonSelector]) {
                NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
                [paraDict setValue:textFiled1.text forKey:@"tel"];
                [paraDict setValue:textFiled2.text forKey:@"code"];
                
                [self.delegate performSelector:self.enterButtonSelector withObject:paraDict];
            }
        }
        else if (_gstate == setPayPwdState){

            if (textFiled1.text.length == 0) {
                
                [self HUDShow:@"请输入支付密码" delay:1];
                
                return;
            }
            
            if ([self.delegate respondsToSelector:self.enterButtonSelector]) {
                NSMutableDictionary *paraDict = [NSMutableDictionary dictionary];
                [paraDict setValue:textFiled1.text forKey:@"password"];
                [self.delegate performSelector:self.enterButtonSelector withObject:paraDict];
            }
            
        }
    
}


-(void) initHUD {
    if (HUD == nil ) {
        HUD = [[MBProgressHUD alloc]initWithView:self];
        [bgView addSubview:HUD];
        HUD.delegate = self;
    }
}

-(void)HUDShow:(NSString*)text {
    
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
}

-(void)HUDShow:(NSString*)text delay:(float)second {
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    [HUD show:YES];
    [HUD hide:YES afterDelay:second];
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    [HUD removeFromSuperview];
    HUD = nil;
}


-(void)HUDdelayDo{
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

#pragma clang diagnostic pop



- (void)postNotificationToUpdateUserInfo{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"updataUserInfo" object:nil];
}

//- (void)layoutSubviews{
//    _bgView.frame = CGRectMake(10, 120, 300, 250);
//    _titleLabel.frame = CGRectMake(self.frame.size.width/2 - size.width/2, 3, size.width, 40);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
