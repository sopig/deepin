//
//  OrderSubmitController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-8.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MapBaseViewController.h"
#import "EC_UIScrollView.h"
#import "EC_UITextField.h"
#import "resMod_TicketInfo.h"
#import "resMod_CommitOrder.h"

#import "LoginViewController.h"

@interface OrderSubmitController : BQIBaseViewController<UITextFieldDelegate,UIScrollViewDelegate,LoginDelegate>{
    
    EC_UIScrollView * rootScrollView;
    
    UIView * view_PriceAndProNum;
    UIView * viewbottom;
    UILabel * lbl_ActivityWarn;
    
    resMod_TicketInfo * ticketInfo;
    resMod_CommitOrderInfo * returnOrderInfo;
}

@property (strong, nonatomic) UILabel *lbl_psTitle;
@property (strong, nonatomic) UILabel *lbl_perPrice;
@property (strong, nonatomic) UILabel *lbl_totalPrice;


@property (strong, nonatomic) EC_UITextField *txt_phoneNum;
@property (strong, nonatomic) EC_UITextField *txt_productNum;

@property (strong, nonatomic) UIButton *btn_discount;
@property (strong, nonatomic) UIButton *btn_sum;
@property (strong, nonatomic) UIButton *btn_submitOrder;


- (void) onSubmitOrderClick:(id) sender;
@end
