//
//  TableCell_UserCenter.h
//  BoqiiLife
//
//  Created by YSW on 14-5-15.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableCellUserCenterDelegate <NSObject>

@optional
- (void) onOrderDetailClick:(UITableViewCell *) selCell;
- (void) OnDelegateDelCollect:(UITableViewCell *) cell;
- (void) onDelegateMallOrderListOperateButtonClick:(id) sender;
- (void) onDelegateMallOrderListProductClick:(int) pid;

@end


//  --  我的商城 订单 【商城】
@interface TableCell_MallOrder : UITableViewCell
@property (assign, nonatomic) id<TableCellUserCenterDelegate> userCenterMallOrderDelegate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_OrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lbl_OrderPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbl_OrderCreateTime;
@property (weak, nonatomic) IBOutlet UILabel *lbl_OrderStatus;

@property (weak, nonatomic) IBOutlet UIButton * btn_Operate1;
@property (weak, nonatomic) IBOutlet UIButton * btn_Operate2;

@property (strong, nonatomic)  UIView * ViewBG;
@property (strong, nonatomic)  UIScrollView * viewProductImgs;

- (void) loadOrderProductImages:(NSMutableArray *) products;
@end


//  --  我的服务 订单 【生活馆】
@interface TableCell_UserCenter : UITableViewCell
@property (assign, nonatomic) id<TableCellUserCenterDelegate> userCenterDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *ProductImg;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ProductTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Price;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Status;
@property (weak, nonatomic) IBOutlet UILabel *lbl_godetail;

- (void)setTitleFrame:(NSString *) _titletxt;
@end




//  --  优惠券。
@interface TableCell_Coupon : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *CouponImg;
@property (weak, nonatomic) IBOutlet UILabel *lbl_CouponTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Price;
@property (weak, nonatomic) IBOutlet UILabel *lbl_CouponStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbl_CouponRange;

@end



//  --  我的收藏 ：生活馆服务券
@interface TableCell_Collect : UITableViewCell

@property (assign,nonatomic) id<TableCellUserCenterDelegate> DelCollectDelegate;
@property (weak, nonatomic) IBOutlet UIView * imgbg;
@property (weak, nonatomic) IBOutlet UIImageView * ProductImg;
@property (weak, nonatomic) IBOutlet UILabel *ProductTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Price;
@property (weak, nonatomic) IBOutlet UILabel *lbl_markPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbl_Timeleft;
@property (weak, nonatomic) IBOutlet UIButton * btn_delete;

@property (strong, nonatomic) UILabel * lbl_delline;


//@property (strong ,nonatomic) UIView * view_delete;
//@property (strong ,nonatomic) UIButton * btn_OkDel;
//@property (strong ,nonatomic) UIButton * btn_Cancel;
@end


//  --  我的收藏 ：商城 商品
@interface TableCell_CollectMallProduct : UITableViewCell

@property (assign,nonatomic) id<TableCellUserCenterDelegate> DelCollectProductDelegate;
@property (weak, nonatomic) IBOutlet UIView * imgbg;
@property (weak, nonatomic) IBOutlet UIImageView * ProductImg;
@property (weak, nonatomic) IBOutlet UILabel *ProductTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Price;
@property (weak, nonatomic) IBOutlet UILabel *lbl_TimesView;
@property (weak, nonatomic) IBOutlet UIButton * btn_delete;
@end






