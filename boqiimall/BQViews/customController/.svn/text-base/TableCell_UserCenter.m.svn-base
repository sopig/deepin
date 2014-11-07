//
//  TableCell_UserCenter.m
//  BoqiiLife
//
//  Created by YSW on 14-5-15.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "TableCell_UserCenter.h"
#import "resMod_Mall_Order.h"


//  --  我的商城 订单 【商城】
@implementation TableCell_MallOrder
@synthesize userCenterMallOrderDelegate;
@synthesize lbl_OrderNum;
@synthesize lbl_OrderPrice;
@synthesize lbl_OrderCreateTime;
@synthesize lbl_OrderStatus;
@synthesize btn_Operate1;
@synthesize btn_Operate2;

@synthesize ViewBG,viewProductImgs;

- (void)awakeFromNib {
    
    self.ViewBG = [UICommon Common_DottedCornerRadiusView:CGRectMake(12, 6, 592/2, 200-12) targetView:self tag:1000 dottedImgName:@"dottedLineWhite"];
    [self sendSubviewToBack:ViewBG];
    
    [self.lbl_OrderNum setTextColor:color_989898];
    [self.lbl_OrderPrice setTextColor:color_989898];
    [self.lbl_OrderStatus setTextColor:color_fc4a00];
    [self.lbl_OrderCreateTime setTextColor:color_989898];
    
    [self.btn_Operate1 setTag:1000];
    [self.btn_Operate1 setBackgroundImage:def_ImgStretchable(@"btn_bg_blackline.png", 8, 8) forState:UIControlStateNormal];
    [self.btn_Operate1 addTarget:self action:@selector(onOperateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_Operate2 setTag:2000];
    [self.btn_Operate2 setBackgroundImage:def_ImgStretchable(@"btn_bg_blackline.png", 8, 8) forState:UIControlStateNormal];
    [self.btn_Operate2 addTarget:self action:@selector(onOperateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    viewProductImgs = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 82, ViewBG.frame.size.width-60, 60)];
    [viewProductImgs setBackgroundColor:[UIColor clearColor]];
    [viewProductImgs setShowsHorizontalScrollIndicator:YES];
    [viewProductImgs setShowsVerticalScrollIndicator:NO];
    [self addSubview:viewProductImgs];
    
    UILabel * lbl_spaceDotLine = [[UILabel alloc] initWithFrame:CGRectMake(25, 152, def_WidthArea(25), 0.5)];
    [lbl_spaceDotLine setBackgroundColor:[UIColor clearColor]];
    lbl_spaceDotLine.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
    lbl_spaceDotLine.layer.borderWidth = 0.5f;
    [self addSubview:lbl_spaceDotLine];
}

- (void) loadOrderProductImages:(NSMutableArray *) products{
    
    for (UIImageView * proimg in viewProductImgs.subviews) {
        [proimg removeFromSuperview];
    }
    
    float fContentWidth = 80*products.count;
    [viewProductImgs setFrame:CGRectMake(30,82,fContentWidth>ViewBG.frame.size.width-40 ? ViewBG.frame.size.width-40:fContentWidth, 60)];
    [viewProductImgs setContentSize:CGSizeMake(fContentWidth, 60)];
    
    for (int i=0; i<products.count; i++) {
        resMod_Mall_OrderGoodsInfo  * protmp = products[i];
        UIImageView * proimg = [[UIImageView alloc] initWithFrame:CGRectMake(80*i, 1, 58, 58)];
        [proimg setBackgroundColor:[UIColor clearColor]];
        [proimg setTag:protmp.GoodsId];
        [proimg sd_setImageWithURL:[NSURL URLWithString: protmp.GoodsImg]
                  placeholderImage:[UIImage imageNamed:@"placeHold_75x75.png"]];
        proimg.layer.borderColor = color_d1d1d1.CGColor;
        proimg.layer.borderWidth = 1.0;
        
        UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onProductClick:)];
        [proimg addGestureRecognizer:singleTap];
        proimg.userInteractionEnabled =YES;
        [viewProductImgs addSubview:proimg];
    }
}

//  --
- (void) setButtonFrame:(int) orderstatus iscomment:(BOOL) _iscomment{
    
}

- (void) onProductClick:(id) sender{
    
    UITapGestureRecognizer* img_btn = (UITapGestureRecognizer*)sender;
    NSInteger tag = img_btn.view.tag;
    
    if ([userCenterMallOrderDelegate respondsToSelector:@selector(onDelegateMallOrderListProductClick:)]) {
        [userCenterMallOrderDelegate onDelegateMallOrderListProductClick:tag];
    }
}

- (void) onOperateButtonClick:(id) sender{

    if ([userCenterMallOrderDelegate respondsToSelector:@selector(onDelegateMallOrderListOperateButtonClick:)]) {
        [userCenterMallOrderDelegate onDelegateMallOrderListOperateButtonClick:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end



//  --  我的服务 订单 【生活馆】
@implementation TableCell_UserCenter
@synthesize userCenterDelegate;
@synthesize ProductImg;
@synthesize lbl_Price;
@synthesize lbl_ProductTitle;
@synthesize lbl_Status;
@synthesize lbl_godetail;


- (void)awakeFromNib {
    
    self.ProductImg.layer.borderColor = color_d1d1d1.CGColor;
    self.ProductImg.layer.borderWidth = 0.5;
    [self.ProductImg setFrame:CGRectMake(10, 11, 100, 70)];
    
    [self.lbl_ProductTitle setTextColor:color_333333];
    [self.lbl_ProductTitle setFont:defFont14];
    
    [self.lbl_Price setTextColor:color_fc4a00];
    [self.lbl_Price setFont:defFont(YES, 15)];
    
    [self.lbl_Status setTextColor:color_989898];
    [self.lbl_godetail setTextColor:color_8fc31f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTitleFrame:(NSString *) _titletxt{
    CGSize tSize = [_titletxt sizeWithFont:defFont14 constrainedToSize:CGSizeMake(self.lbl_ProductTitle.frame.size.width, MAXFLOAT)];
    [self.lbl_ProductTitle setFrame:CGRectMake(self.lbl_ProductTitle.frame.origin.x,
                                        self.lbl_ProductTitle.frame.origin.y+4,
                                        self.lbl_ProductTitle.frame.size.width,
                                        tSize.height>40 ? 40:tSize.height)];
}

//  -- 查看详情按钮
//- (void)onGODetailClick:(UITableViewCell *) selCell{
//    if ([userCenterDelegate respondsToSelector:@selector(onOrderDetailClick:)]) {
//        [userCenterDelegate onOrderDetailClick:self];
//    }
//}

@end



//  --  我的优惠券
@implementation TableCell_Coupon
@synthesize CouponImg;
@synthesize lbl_Price;
@synthesize lbl_CouponTitle;
@synthesize lbl_CouponStatus;
@synthesize lbl_CouponRange;

- (void)awakeFromNib {
    [self.CouponImg setImage:[UIImage imageNamed:@"mycoupon_canUse"]];
    [self.CouponImg setFrame:CGRectMake(10, 12, 194/2, 130/2)];
    
    [self.lbl_Price setTextColor:color_fc4a00];
    [self.lbl_Price setFont:defFont(YES, 14)];

    [self.lbl_CouponStatus setTextColor:[UIColor whiteColor]];
    [self.lbl_CouponRange setTextColor:color_989898];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end





//  --  我的收藏 ：生活馆服务券
@implementation TableCell_Collect
@synthesize DelCollectDelegate;
@synthesize imgbg;
@synthesize ProductImg;
@synthesize ProductTitle;
@synthesize lbl_Price;
@synthesize lbl_markPrice;
@synthesize lbl_Timeleft;
@synthesize btn_delete;
@synthesize lbl_delline;

//@synthesize view_delete;
//@synthesize btn_OkDel;
//@synthesize btn_Cancel;

- (void)awakeFromNib {
    
    [lbl_Price setFont:defFont(YES, 15)];
    [lbl_Price setTextColor:color_fc4a00];
    
    [lbl_Timeleft setTextColor:color_4e4e4e];
    
    lbl_delline = [[UILabel alloc] initWithFrame:CGRectMake(self.lbl_markPrice.frame.origin.x-1,self.lbl_markPrice.frame.origin.y+10, 60, 1)];
    [lbl_delline setBackgroundColor:color_b3b3b3];
    [self addSubview:lbl_delline];
    
    
    [self.ProductImg setFrame:CGRectMake(10, 12, 100, 70)];
    [imgbg setFrame:CGRectMake(ProductImg.frame.origin.x-2, ProductImg.frame.origin.y-2, ProductImg.frame.size.width+4, ProductImg.frame.size.height+4)];
    [imgbg setBackgroundColor:[UIColor whiteColor]];
    imgbg.layer.borderColor = color_d1d1d1.CGColor;
    imgbg.layer.borderWidth = 0.5f;
    imgbg.layer.cornerRadius = 2.0f;
    
    [self.btn_delete addTarget:self action:@selector(onOkClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /////////// --  删除层
//    view_delete = [[UIView alloc] initWithFrame:CGRectMake(0, 97, 0, 36)];
//    [view_delete setBackgroundColor:color_fc4a00];
////    [self.contentView addSubview:view_delete];
//    UILabel * lbl_warn = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 150, view_delete.frame.size.height)];
//    [lbl_warn setText:@"是否确定删除这条收藏?"];
//    [lbl_warn setFont:defFont13];
//    [lbl_warn setTextColor:[UIColor whiteColor]];
//    [lbl_warn setBackgroundColor:[UIColor clearColor]];
//    [view_delete addSubview:lbl_warn];
//    
//    //  ....
//    btn_OkDel = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_OkDel setTag:999];
//    [btn_OkDel setFrame:CGRectMake(__MainScreen_Width-120, 3, 50, 30)];
//    [btn_OkDel setBackgroundColor:[UIColor whiteColor]];
//    [btn_OkDel setTitle:@"确定" forState:UIControlStateNormal];
//    [btn_OkDel setTitleColor:color_333333 forState:UIControlStateNormal];
//    [btn_OkDel.titleLabel setFont:defFont13];
//    btn_OkDel.layer.cornerRadius = 3.0;
//    [btn_OkDel addTarget:self action:@selector(onOkClick:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //  .....
//    btn_Cancel = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn_Cancel setTag:111];
//    [btn_Cancel setFrame:CGRectMake(__MainScreen_Width-60, 3, 50, 30)];
//    [btn_Cancel setBackgroundColor:[UIColor whiteColor]];
//    [btn_Cancel setTitle:@"取消" forState:UIControlStateNormal];
//    [btn_Cancel setTitleColor:color_333333 forState:UIControlStateNormal];
//    [btn_Cancel.titleLabel setFont:defFont13];
//    btn_Cancel.layer.cornerRadius = 3.0;
//    [btn_Cancel addTarget:self action:@selector(onCancelClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//- (void) addDeleteView{
//    [UIView animateWithDuration:0.05
//                     animations:^{
//                         [self.contentView addSubview:view_delete];
//                         [view_delete setFrame:CGRectMake(0, 97, __MainScreen_Width, 36)];
//                     } completion:^(BOOL finished){
//                         [view_delete addSubview:btn_OkDel];
//                         [view_delete addSubview:btn_Cancel];
//                     }];
//}
//
////  --取消
//- (void) onCancelClick:(id) sender{
//    [UIView animateWithDuration:0.05
//                     animations:^{
//                         [btn_OkDel removeFromSuperview];
//                         [btn_Cancel removeFromSuperview];
//                         [view_delete setFrame:CGRectMake(0, 97, 0, 36)];
//                     } completion:^(BOOL finished){
//                         [view_delete removeFromSuperview];
//                     }];
//}

//  --确定
- (void) onOkClick:(id) sender{
    if ([self.DelCollectDelegate respondsToSelector:@selector(OnDelegateDelCollect:)]) {
        [self.DelCollectDelegate OnDelegateDelCollect:self];
    }
}
@end






//  --  我的收藏 ：生活馆服务券
@implementation TableCell_CollectMallProduct
@synthesize DelCollectProductDelegate;
@synthesize imgbg;
@synthesize ProductImg;
@synthesize ProductTitle;
@synthesize lbl_Price;
@synthesize lbl_TimesView;
@synthesize btn_delete;

- (void)awakeFromNib {
    
    [lbl_Price setFont:defFont(YES, 15)];
    [lbl_Price setTextColor:color_fc4a00];
    
    [self.ProductTitle setTextColor:color_333333];
    [self.ProductImg setFrame:CGRectMake(10, 12, 75, 75)];
    [imgbg setFrame:CGRectMake(ProductImg.frame.origin.x-2, ProductImg.frame.origin.y-2, ProductImg.frame.size.width+4, ProductImg.frame.size.height+4)];
    [imgbg setBackgroundColor:[UIColor whiteColor]];
    imgbg.layer.borderColor = color_d1d1d1.CGColor;
    imgbg.layer.borderWidth = 0.5f;
    imgbg.layer.cornerRadius = 2.0f;
    
    [self.btn_delete addTarget:self action:@selector(onOkClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

//  --确定
- (void) onOkClick:(id) sender{
    if ([self.DelCollectProductDelegate respondsToSelector:@selector(OnDelegateDelCollect:)]) {
        [self.DelCollectProductDelegate OnDelegateDelCollect:self];
    }
}
@end







