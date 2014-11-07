//
//  EditAddressViewController.h
//  boqiimall
//
//  Created by YSW on 14-6-30.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "HZAreaPickerView.h"
#import "EC_UIScrollView.h"

#import "resMod_Address.h"

@protocol EditAddressDelegate <NSObject>

@optional
- (void)OnDelegateEditAddress:(resMod_AddressInfo*) selAddress;
@end


@interface EditAddressViewController : BQIBaseViewController<UITextFieldDelegate,UIScrollViewDelegate,HZAreaPickerDelegate>{
    EC_UIScrollView * rootScrollView;
    HZAreaPickerView* loacatePicker;
    UIView * viewContent;
    
    resMod_AddressInfo * userNowAddress;
    resMod_ProvinceCityArea * paddressInfo;
    BOOL isCreateNewAddress;
    
    UITextField * tmpTxtField;
    BOOL isFromSubmitOrder;
}

@property (assign,nonatomic) id<EditAddressDelegate> Delegate;
@end
