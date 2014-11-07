//
//  EditAddressViewController.m
//  boqiimall
//
//  Created by YSW on 14-6-30.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "EditAddressViewController.h"
#import "resMod_ProvinceCityArea.h"

#define heightRow   92/2
#define tagContent  666
#define addressTexts  @"收  货  人:请输入收件人姓名|所在地区:北京|详细地址:请输入收货详细地址|手机号码:收货人手机号|电话号码:手机号与固定电话至少填一个|邮      编:可不填"

@implementation EditAddressViewController
@synthesize Delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:color_bodyededed];
   // [self navRight_SaveAddress];
  //  [self loadNavBarView:@"新建收货人"];
    //[self loadNavBarView];
    [self setTitle:@"新建收货人"];
    isFromSubmitOrder = [[self.receivedParams objectForKey:@"param_isFromSubmitOrder"] isEqualToString:@"1"] ? YES : NO;
    userNowAddress = [self.receivedParams objectForKey:@"param_AddressInfo"];
    isCreateNewAddress = userNowAddress.AddressId > 0 ? NO : YES;

    rootScrollView = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Height, kMainScreenHeight - kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [rootScrollView setDelegate:self];
    [self.view addSubview:rootScrollView];
    
    [self loadView_content];
    
    [(UITextField*)[viewContent viewWithTag:666] performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.6];
 
    //  --  地址选择器
    paddressInfo = [[resMod_ProvinceCityArea alloc]init];
    if (isCreateNewAddress) {
        // 添加新地址
        paddressInfo.pca_provinceId = @"11";
        paddressInfo.pca_cityId = @"1101";
        
        [self setTitle:@"新建收货人"];
    }
    else{
        // 修改地址
        paddressInfo.pca_provinceId = [NSString stringWithFormat:@"%d",userNowAddress.AddressProvinceId];
        paddressInfo.pca_cityId = [NSString stringWithFormat:@"%d",userNowAddress.AddressCityId];
        paddressInfo.pca_areaId = [NSString stringWithFormat:@"%d",userNowAddress.AddressAreaId];
        [self bindUserAddressInfo];
        
        [self setTitle:@"修改收货人"];
    }
    
    [self goApiRequest_ProvinceCityArea];
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    
    UIButton * btn_save = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_save setFrame:CGRectMake(265, 0, 50, 44)];
    [btn_save setBackgroundColor:[UIColor clearColor]];
    [btn_save setTitle:@"保存" forState:UIControlStateNormal];
    [btn_save setTitleColor:color_fc4a00 forState:UIControlStateNormal];
    [btn_save.titleLabel setFont:defFont15];
    [btn_save addTarget:self action:@selector(onButton_OkClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btn_save];
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
//    UIButton * btn_save = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_save setFrame:CGRectMake(265, 0, 50, 44)];
//    [btn_save setBackgroundColor:[UIColor clearColor]];
//    [btn_save setTitle:@"保存" forState:UIControlStateNormal];
//    [btn_save setTitleColor:color_fc4a00 forState:UIControlStateNormal];
//    [btn_save.titleLabel setFont:defFont15];
//    [btn_save addTarget:self action:@selector(onButton_OkClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:btn_save];
//    [self.navBarView addSubview:bgView];
//}



- (void)bindUserAddressInfo {
    UITextField * txt_666 = (UITextField*)[viewContent viewWithTag:666];
    UITextField * txt_667 = (UITextField*)[viewContent viewWithTag:667];
    UITextField * txt_668 = (UITextField*)[viewContent viewWithTag:668];
    UITextField * txt_669 = (UITextField*)[viewContent viewWithTag:669];
    UITextField * txt_670 = (UITextField*)[viewContent viewWithTag:670];
    UITextField * txt_671 = (UITextField*)[viewContent viewWithTag:671];
    
    [txt_666 setText:userNowAddress.UserName];
    [txt_667 setText:[NSString stringWithFormat:@"%@ %@ %@",
                      userNowAddress.AddressProvince,
                      userNowAddress.AddressCity,
                      userNowAddress.AddressArea]];
    [txt_668 setText:userNowAddress.AddressDetail];
    [txt_669 setText:userNowAddress.Mobile];
    [txt_670 setText:userNowAddress.Phone];
    [txt_671 setText:userNowAddress.ZipCode];
}

#pragma mark    -- event


//  --  改变 省、市、区
-(void)pickerDidChaneStatus:(BOOL) b_type {
    
    UITextField * txt_667 = (UITextField*)[viewContent viewWithTag:667];
    if (b_type) {
        [txt_667 setText:[NSString stringWithFormat:@"%@ %@ %@",
                          loacatePicker.locate_province.ProvinceName,
                          loacatePicker.locate_city.CityName,
                          loacatePicker.locate_area.AreaName]];
    }
    [loacatePicker cancelPicker];
}

//  -- 保存地址
- (void)onButton_OkClick:(id) sender{
    
    UITextField * txt_666 = (UITextField*)[viewContent viewWithTag:666];
    UITextField * txt_667 = (UITextField*)[viewContent viewWithTag:667];
    UITextField * txt_668 = (UITextField*)[viewContent viewWithTag:668];
    UITextField * txt_669 = (UITextField*)[viewContent viewWithTag:669];
    UITextField * txt_670 = (UITextField*)[viewContent viewWithTag:670];
    UITextField * txt_671 = (UITextField*)[viewContent viewWithTag:671];
    [txt_666 resignFirstResponder];
    [txt_667 resignFirstResponder];
    [txt_668 resignFirstResponder];
    [txt_669 resignFirstResponder];
    [txt_670 resignFirstResponder];
    [txt_671 resignFirstResponder];
    
    if (txt_666.text.length == 0){
        [self HUDShow:@"收货人姓名不可为空" delay:2];
    }
    else if (txt_667.text.length == 0){
        [self HUDShow:@"请选择地区" delay:2];
    }
    else if (txt_668.text.length == 0){
        [self HUDShow:@"请输入详细地址" delay:2];
    }
    else if (txt_669.text.length == 0 && txt_670.text.length == 0){
        [self HUDShow:@"手机号码与固定电话至少填写一个" delay:2];
    }
    else{
        
        NSMutableDictionary* newDic = [[NSMutableDictionary alloc]init];
        [newDic setObject:[UserUnit userId] forKey:@"UserId"];
        [newDic setObject:txt_666.text forKey:@"UserName"];
        [newDic setObject:txt_668.text forKey:@"AddressDetail"];
        [newDic setObject:[NSString stringWithFormat:@"%d",loacatePicker.locate_province.ProvinceId] forKey:@"AddressProvinceId"];
        [newDic setObject:[NSString stringWithFormat:@"%d",loacatePicker.locate_city.CityId] forKey:@"AddressCityId"];
        [newDic setObject:[NSString stringWithFormat:@"%d",loacatePicker.locate_area.AreaId] forKey:@"AddressAreaId"];

        if (txt_669.text.length>0) {
            [newDic setObject:txt_669.text forKey:@"Mobile"];
        }
        if (txt_670.text.length>0) {
            [newDic setObject:txt_670.text forKey:@"Phone"];
        }
        if (txt_671.text.length>0) {
            [newDic setObject:txt_671.text forKey:@"ZipCode"];
        }
        
        if (!isCreateNewAddress) {
            [newDic setValue:[NSString stringWithFormat:@"%d",userNowAddress.AddressId] forKey:@"AddressId"];
        }
        
//        [self ApiRequest:api_BOQIIMALL
//                  method:isCreateNewAddress ? kApiMethod_AddressAdd:kApiMethod_AddressUpdate
//                   class:isCreateNewAddress ? @"resMod_CallBack_AddUserAddress":@"ResponseBase"
//                  params:newDic isShowLoadingAnimal:NO hudShow:@"保存中..."];
        
        if (isCreateNewAddress) {
            [[APIMethodHandle shareAPIMethodHandle]goApiRequestAddUserAddress:newDic ModelClass:@"resMod_CallBack_AddUserAddress" showLoadingAnimal:NO hudContent:@"正在保存" delegate:self];
        }else {
            [[APIMethodHandle shareAPIMethodHandle]goApiRequestUpdateUserAddress:newDic ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在保存" delegate:self];
        }
        
        
        
    }
}

#pragma mark    --  ui

//  --保存.
- (void) navRight_SaveAddress{
    UIButton * btn_save = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_save setFrame:CGRectMake(5, 0, 50, 44)];
    [btn_save setBackgroundColor:[UIColor clearColor]];
    [btn_save setTitle:@"保存" forState:UIControlStateNormal];
    [btn_save setTitleColor:color_fc4a00 forState:UIControlStateNormal];
    [btn_save.titleLabel setFont:defFont15];
    [btn_save addTarget:self action:@selector(onButton_OkClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:btn_save];
    self.navigationItem.rightBarButtonItem = r_bar;
    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
}

- (void) loadView_content{
    
    NSArray * arrContents = [addressTexts componentsSeparatedByString:@"|"];
    viewContent = [[UIView alloc] initWithFrame:CGRectMake(15, -0.5, def_WidthArea(15), heightRow*arrContents.count)];
    [viewContent setBackgroundColor:[UIColor whiteColor]];
    viewContent.layer.borderColor = color_d1d1d1.CGColor;
    viewContent.layer.borderWidth = 0.5f;
    [rootScrollView addSubview:viewContent];
    
    int i=0;
    for (NSString * stxt in arrContents) {
        
        NSArray * contentInfo = [stxt componentsSeparatedByString:@":"];
        
        [UICommon Common_UILabel_Add:CGRectMake(0, heightRow*i, 80, heightRow)
                          targetView:viewContent bgColor:[UIColor clearColor] tag:tagContent+100+i
                                text:[NSString stringWithFormat:@"%@:",contentInfo[0]]
                               align:1 isBold:NO fontSize:14 tColor:color_333333];
        
        UITextField * txtField = [[UITextField alloc] initWithFrame:CGRectMake(85, heightRow*i, __MainScreen_Width-120, heightRow)];
        [txtField setTag:tagContent +i];
        [txtField setBackgroundColor:[UIColor clearColor]];
        [txtField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [txtField setTextColor:color_989898];
        [txtField setFont:defFont14];
        [txtField setPlaceholder:contentInfo[1]];
        txtField.delegate = self;
        [txtField setKeyboardType: i==3||i==4||i==5 ? UIKeyboardTypeNumberPad : UIKeyboardTypeDefault];
        [txtField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [txtField setReturnKeyType:UIReturnKeyNext];
        [viewContent addSubview:txtField];
        
        if (i==1) {
            UIImageView *btnImg = [[UIImageView alloc]initWithFrame:CGRectMake(txtField.frame.size.width - 25, 14, 18, 18)];
            [btnImg setImage:[UIImage imageNamed:@"right_icon.png"]];
            [txtField addSubview:btnImg];
        }
        
        if (i>0) {
            [UICommon Common_line:CGRectMake(0, heightRow*i, viewContent.frame.size.width, 0.5) targetView:viewContent backColor:color_d1d1d1];
        }
        
        i++;
    }
}

//  --  加载 省 市 区
- (void) loadView_PCA{
    loacatePicker = [[HZAreaPickerView alloc]initWithStyle:paddressInfo delegate:self frame:CGRectMake( 0, kMainScreenHeight, self.view.frame.size.width, 0)];
    loacatePicker.hidden = YES;
    [self.view addSubview:loacatePicker];
}

#pragma mark    --  api 请求 加调

-(void) goApiRequest_ProvinceCityArea{

//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_GetProviceCityArea class:@"resMod_CallBack_ProvinceCityArea"
//              params:nil  isShowLoadingAnimal:NO hudShow:@""];
//    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetProviceCityArea:nil ModelClass:@"resMod_CallBack_ProvinceCityArea" showLoadingAnimal:NO hudContent:@"" delegate:self];

}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_GetProviceCityArea]) {
        
        [self loadView_PCA];
        [self hudWasHidden:HUD];
    }
    if ([ApiName isEqualToString:kApiMethod_AddressAdd]) {
        resMod_CallBack_AddUserAddress * backObj = [[resMod_CallBack_AddUserAddress alloc] initWithDic:retObj];
        resMod_AddressInfo * objInfo = backObj.ResponseData;
        
        //  --  ....
        if (isFromSubmitOrder) {
            if ([Delegate respondsToSelector:@selector(OnDelegateEditAddress:)]) {
                
                UITextField * txt_666 = (UITextField*)[viewContent viewWithTag:666];
                UITextField * txt_668 = (UITextField*)[viewContent viewWithTag:668];
                UITextField * txt_669 = (UITextField*)[viewContent viewWithTag:669];
                UITextField * txt_670 = (UITextField*)[viewContent viewWithTag:670];
                UITextField * txt_671 = (UITextField*)[viewContent viewWithTag:671];
                
                resMod_AddressInfo * address = [[resMod_AddressInfo alloc] init];
                address.AddressId = objInfo.AddressId;
                address.UserName  = txt_666.text;
                address.AddressDetail = txt_668.text;
                address.Mobile  = txt_669.text;
                address.Phone   = txt_670.text;
                address.ZipCode = txt_671.text;
                address.AddressProvinceId = loacatePicker.locate_province.ProvinceId;
                address.AddressProvince = loacatePicker.locate_province.ProvinceName;
                address.AddressCityId = loacatePicker.locate_city.CityId;
                address.AddressCity = loacatePicker.locate_city.CityName;
                address.AddressAreaId = loacatePicker.locate_area.AreaId;
                address.AddressArea = loacatePicker.locate_area.AreaName;
                [Delegate OnDelegateEditAddress:address];
            }
        }
        [self HUDShow:@"新建地址成功" delay:2 dothing:YES];
    }
    if ([ApiName isEqualToString:kApiMethod_AddressUpdate]) {
        [self HUDShow:@"编辑成功" delay:2 dothing:YES];
    }
}

- (void)HUDdelayDo{
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField.tag==667) {   //当是选地区时
        [tmpTxtField resignFirstResponder];
        [loacatePicker showInView:self.view];
        return NO;
    }
    else{
        tmpTxtField =  textField;
        [loacatePicker cancelPicker];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag == 670) {
        [textField resignFirstResponder];
    }
    else{
        UITextField * tmptxt = (UITextField *)[viewContent viewWithTag:textField.tag+1];
        [tmptxt becomeFirstResponder];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
