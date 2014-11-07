//
//  ResetUserNickNameVC.m
//  boqiimall
//
//  Created by YSW on 14-8-7.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "ResetUserNickNameVC.h"
@implementation ResetUserNickNameVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)loadView{
    [super loadView];
    
    //  -- 保存
    UIButton * btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSave setFrame:CGRectMake(0, 2, 50, 40)];
    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
    [btnSave setBackgroundColor:[UIColor clearColor]];
    [btnSave setTitleColor:color_989898 forState:UIControlStateNormal];
    [btnSave.titleLabel setFont:defFont15];
    [btnSave setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btnSave addTarget:self action:@selector(onSaveClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:btnSave];
    self.navigationItem.rightBarButtonItem = r_bar;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
    
    
    txt_NickName  = [[EC_UITextField alloc] initWithFrame:CGRectMake(-1, 10+kNavBarViewHeight, __MainScreen_Width+2, 45)];
    txt_NickName.textFieldState = ECTextFieldNone;
    txt_NickName.borderStyle = UITextBorderStyleLine;
    [txt_NickName setBackgroundColor:[UIColor whiteColor]];
    txt_NickName.layer.borderColor = color_d1d1d1.CGColor;
    txt_NickName.layer.borderWidth = 1.0f;
    [txt_NickName setDelegate:self];
    [txt_NickName setReturnKeyType:UIReturnKeyDone];
    [txt_NickName setRightViewMode:UITextFieldViewModeWhileEditing];
    [txt_NickName setTextColor:color_4e4e4e];
    txt_NickName.placeholder = [UserUnit userNick];
    
    [self.view addSubview:txt_NickName];
    
    [UICommon Common_UILabel_Add:CGRectMake(0, 60+kNavBarViewHeight, __MainScreen_Width, 30)
                      targetView:self.view bgColor:[UIColor clearColor] tag:1021
                            text:@"限 2-10 个字符" align:0 isBold:NO fontSize:15 tColor:color_989898];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"昵称修改"];
    [self.view setBackgroundColor:color_bodyededed];
   // [self loadNavBarView:@"昵称修改"];
    [txt_NickName performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.6f];
}


- (void)loadNavBarView
{
    [super loadNavBarView];
    UIButton * btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSave setFrame:CGRectMake(265, 2, 50, 40)];
    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
    [btnSave setBackgroundColor:[UIColor clearColor]];
    [btnSave setTitleColor:color_989898 forState:UIControlStateNormal];
    [btnSave.titleLabel setFont:defFont15];
    [btnSave setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btnSave addTarget:self action:@selector(onSaveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btnSave];
}

//- (void)loadNavBarView:(NSString *)title
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = title;
//    [bgView addSubview:titleLabel];
//    UIButton * btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnSave setFrame:CGRectMake(265, 2, 50, 40)];
//    [btnSave setTitle:@"保存" forState:UIControlStateNormal];
//    [btnSave setBackgroundColor:[UIColor clearColor]];
//    [btnSave setTitleColor:color_989898 forState:UIControlStateNormal];
//    [btnSave.titleLabel setFont:defFont15];
//    [btnSave setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
//    [btnSave addTarget:self action:@selector(onSaveClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:btnSave];
//    [self.navBarView addSubview:bgView];
//}



- (void) onSaveClick:(id) sender{
    [txt_NickName resignFirstResponder];
    [self goApiRequest_CheckNick];
}


#pragma mark    --  api 请 求 & 回 调.
-(void)goApiRequest_CheckNick{
    if (txt_NickName.text.length==0) {
        [self HUDShow:@"请输入您的昵称" delay:2];
        return;
    }
    NSMutableDictionary * param  = [[NSMutableDictionary alloc] initWithCapacity:2];
    [param setValue:[UserUnit userId] forKey:@"UserId"];
    [param setValue:txt_NickName.text forKey:@"NickName"];
    
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_CheckNickName class:@"ResponseBase"
//              params:param  isShowLoadingAnimal:NO hudShow:@"正在修改"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestCheckNickName:param ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在修改" delegate:self];
    
}
-(void)goApiRequest_ResetNick{
    NSMutableDictionary * param  = [[NSMutableDictionary alloc] initWithCapacity:2];
    [param setValue:[UserUnit userId] forKey:@"UserId"];
    [param setValue:txt_NickName.text forKey:@"NickName"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestModifyNickName:param ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"" delegate:self];
    
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_ModifyNickName class:@"ResponseBase"
//              params:param isShowLoadingAnimal:NO  hudShow:@""];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_CheckNickName]) {
        [self goApiRequest_ResetNick];
    }
    if ([ApiName isEqualToString:kApiMethod_ModifyNickName]) {
        [UserUnit saveUserNick:txt_NickName.text];
        [self HUDShow:@"修改成功" delay:2 dothing:YES];
    }
}

-(void)HUDdelayDo {
    [self goBack:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self goApiRequest_CheckNick];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
