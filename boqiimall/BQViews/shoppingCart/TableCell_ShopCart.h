//
//  TableCell_ShopCart.h
//  boqiimall
//
//  Created by ysw on 14-10-14.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "resMod_Mall_ShoppingCart.h"

//  -- cell delegate
@protocol TableCell_ShopCartDelegate <NSObject>
@optional
- (void) onDelegateCellRowProductChecked:(id) cell;
- (void) onDelegateChangeProNum:(id) cell;
- (void) onDelegateChangeType:(id) cell btnTag:(int) btag;
@end


//  -- cell
@interface TableCell_ShopCart : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView    *productIMG;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_salePrice;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_proSpec;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_proNum;
@property (weak, nonatomic) IBOutlet UITextField    *txt_proNum;

@property (weak, nonatomic) IBOutlet UIButton       *btn_check;

@property (strong, nonatomic) UILabel * lblDotLine;         //单品活动区上方的虚线
@property (strong, nonatomic) UIView * view_activity;       //活动说明区
@property (strong, nonatomic) UIView * view_ResultsOfActivities;       //活动结果区（包括更换按钮）


@property (assign, nonatomic) id<TableCell_ShopCartDelegate> delegateCart;
@property (strong, nonatomic) resMod_Mall_ShoppingCartGoodsInfo * cellResourceData;
@property (strong, nonatomic) NSDictionary * dic_tagColor;  //一些活动签颜色


- (void)setBtnCheckImage;

//  加载 *活动说明* 区
- (void)setViewActivity;
//  加载 *活动结果 & 更换优惠or换购* 区
- (void)setViewResultsOfActivities;
@end
