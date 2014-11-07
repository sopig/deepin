//
//  MyAddressListController.h
//  boqiimall
//
//  Created by YSW on 14-6-30.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "resMod_Address.h"

@protocol MyAddressListDelegate <NSObject>

@optional
//  --使用中登录回传事件
- (void)OnDelegateSelectedAddress:(resMod_AddressInfo*) selAddress;
@end



@interface MyAddressListController : BQIBaseViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView * rootTableView;
    NSMutableArray * m_AddressList;

    UITableViewCell * whileDelAddressCell;
    int whileDelAddressID;
    int selAddressID;
    BOOL isFromSubmitOrder;
}

@property (assign,nonatomic) id<MyAddressListDelegate> Delegate;
//@property (strong,nonatomic) NSString * param_submitOrder_Addressid;    //--从提交订单页跳进来时的id
@end
