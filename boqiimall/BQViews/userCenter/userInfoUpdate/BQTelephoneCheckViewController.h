//
//  BQTelephoneCheckViewController.h
//  boqiimall
//
//  Created by 张正超 on 14-8-11.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQIBaseViewController.h"


typedef enum UISTATE{
    isHasMobileToCheck = 1,
    isHasCheckToModify,
    isHasNoMobileToBind
} UISTATE;      //UI状态

typedef enum TeleBusinessState{
    authCodeHasCheckToSetPayPassword = 1,
    authCodeHasCheckToModifyTelePhoneNum,

} TeleBusinessState;   //业务状态

typedef enum SendAuthCode{
    bindTelePhoneCode = 1,
    modifyBindTelephoneCode,
    modifyPayPasswordCode
} SendAuthCode;

@interface BQTelephoneCheckViewController : BQIBaseViewController


@property(nonatomic,readwrite,assign)TeleBusinessState businessState;  //业务状态



@end
