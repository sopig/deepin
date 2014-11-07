//
//  TableCell_MallCart.m
//  BoqiiLife
//
//  Created by YSW on 14-6-24.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "TableCell_MallCart.h"
#import "resMod_Mall_ShoppingCart.h"

#define heightGiftImg   60
#define widthGiftImg    130/2
#define tagGiftImg      82369
#define tagGiftBG       6547

@implementation TableCell_MallCart
@synthesize cartDelegate;
@synthesize lbl_proSpec;
@synthesize lbl_salePrice;
@synthesize lbl_title;
@synthesize btn_check;
@synthesize productIMG;
@synthesize lbl_prono;
@synthesize btn_proNum;

@synthesize viewGift;
@synthesize viewProductList;
@synthesize btnGiftHead;
@synthesize IconBtnRight;
@synthesize scrollViewGift;
@synthesize arrGifts;

@synthesize IsOpenGiftView;

- (void)awakeFromNib {
    
    [productIMG setFrame:CGRectMake(productIMG.frame.origin.x, productIMG.frame.origin.y, 75, 75)];
    [productIMG setBackgroundColor:[UIColor whiteColor]];
    productIMG.layer.borderColor = color_d1d1d1.CGColor;
    productIMG.layer.borderWidth = 0.5f;
    
    [lbl_title setTextColor:color_333333];

    [lbl_salePrice setFont:defFont15];
    [lbl_salePrice setTextColor:color_fc4a00];

    [lbl_proSpec setFont:defFont13];
    [lbl_proSpec setTextColor:color_989898];
    
    [lbl_prono setTextColor:color_989898];
    [btn_proNum setBackgroundColor:[UIColor whiteColor]];
    [btn_proNum setTitleColor:color_333333 forState:UIControlStateNormal];
    btn_proNum.layer.borderWidth = 0.5;
    btn_proNum.layer.borderColor = color_d1d1d1.CGColor;
    [btn_proNum addTarget:self action:@selector(onBtnChangeProNumClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_check setTitle:@"" forState:UIControlStateNormal];
    [btn_check setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
    [btn_check addTarget:self action:@selector(onRowProductChecked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self initProductGifts];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//  --  set property
- (void)setTitleFrame:(NSString *) _titletxt{
    CGSize tSize=[_titletxt sizeWithFont:defFont14 constrainedToSize:CGSizeMake(self.lbl_title.frame.size.width, MAXFLOAT)];
    [self.lbl_title setFrame:CGRectMake(self.lbl_title.frame.origin.x,
                                        self.lbl_title.frame.origin.y,
                                        self.lbl_title.frame.size.width,
                                        tSize.height>40 ? 40:tSize.height)];
}
- (void)setCellRowCheckStatus:(BOOL) _bool{
    IsCheckedRow = _bool;
    [btn_check setImage:[UIImage imageNamed: IsCheckedRow?@"checkbox_greensel.png":@"checkbox_greenUnsel.png"]
               forState:UIControlStateNormal];
}


//  ---     event
- (void)onRowProductChecked:(id)sender{
    IsCheckedRow = !IsCheckedRow;
    [btn_check setImage:[UIImage imageNamed: IsCheckedRow?@"checkbox_greensel.png":@"checkbox_greenUnsel.png"]
               forState:UIControlStateNormal];
    if ([cartDelegate respondsToSelector:@selector(onDelegateCellRowProductChecked:ischecked:)]) {
        [cartDelegate onDelegateCellRowProductChecked:self ischecked:IsCheckedRow];
    }
}

- (void) onBtnChangeProNumClick:(id)sender{
    if ([cartDelegate respondsToSelector:@selector(onDelegateChangeProNumClick:)]) {
        [cartDelegate onDelegateChangeProNumClick:self];
    }
}

- (void) onBtnScrollClick:(id)sender{
    
    UIButton * btnTmp = (UIButton *)sender;
    if (btnTmp.tag==56783) {    //  --左
        if (scrollViewGift.contentOffset.x>0) {
            [scrollViewGift setContentOffset:CGPointMake(scrollViewGift.contentOffset.x-widthGiftImg, scrollViewGift.contentOffset.y) animated:YES];
        }
    }
    else if(btnTmp.tag==56783+1){   //  --右
        if (scrollViewGift.contentOffset.x+widthGiftImg>scrollViewGift.contentSize.width-scrollViewGift.frame.size.width) {
            [scrollViewGift setContentOffset:CGPointMake(scrollViewGift.contentSize.width-scrollViewGift.frame.size.width, scrollViewGift.contentOffset.y) animated:YES];
            return;
        }
        [scrollViewGift setContentOffset:CGPointMake(scrollViewGift.contentOffset.x+widthGiftImg, scrollViewGift.contentOffset.y) animated:YES];
    }
}

- (void) onBtnGiftHeadClick:(id) sender{
    
    if ([cartDelegate respondsToSelector:@selector(onDelegateShowOrHideGiftClick:)]) {
        [cartDelegate onDelegateShowOrHideGiftClick:self];
    }
    
    [btnGiftHead setTitle: IsOpenGiftView?@"收起赠品":@"查看赠品" forState:UIControlStateNormal];
    [self showOrhideGiftView];
}

- (void) onCartGiftClick:(id) sender{
    UITapGestureRecognizer* img_btn = (UITapGestureRecognizer*)sender;
    NSInteger tag = img_btn.view.tag;
    
    if ([cartDelegate respondsToSelector:@selector(onDelegateGiftClick:)]) {
        [cartDelegate onDelegateGiftClick:[NSString stringWithFormat:@"%d",tag]];
    }
}

#pragma mark    --  add Gifts
- (void) initProductGifts{
    
    self.arrGifts = [[NSMutableArray alloc] initWithCapacity:0];
    heightGiftArea = 80+30;
    
    viewGift=[[UIView alloc] initWithFrame:CGRectMake(12, 120, 592/2, heightGiftArea)];
    [viewGift setBackgroundColor:[UIColor clearColor]];
    [self addSubview:viewGift];
    [viewGift setHidden:YES];

    [UICommon Common_DottedCornerRadiusView:CGRectMake(0, 0, 592/2, heightGiftArea)
                                 targetView:viewGift tag:tagGiftBG dottedImgName:nil];
    
    btnGiftHead = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnGiftHead setFrame:CGRectMake(10, 0, viewGift.frame.size.width-10, 30)];
    [btnGiftHead setBackgroundColor:[UIColor clearColor]];
    [btnGiftHead setTitle: @"查看赠品" forState:UIControlStateNormal];
    [btnGiftHead setTitleColor:color_333333 forState:UIControlStateNormal];
    [btnGiftHead setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [btnGiftHead.titleLabel setFont:defFont14];
    [btnGiftHead addTarget:self action:@selector(onBtnGiftHeadClick:) forControlEvents:UIControlEventTouchUpInside];
    IconBtnRight = [[UIImageView alloc] initWithFrame:CGRectMake(btnGiftHead.frame.size.width-25, 7, 15, 15)];
    [IconBtnRight setBackgroundColor:[UIColor clearColor]];
    [IconBtnRight setImage:[UIImage imageNamed:@"right_icon.png"]];
    [btnGiftHead addSubview:IconBtnRight];
    [viewGift addSubview:btnGiftHead];
    
    UILabel * lbl_dotLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, viewGift.frame.size.width, 0.5)];
    [lbl_dotLine setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]]];
    [viewGift addSubview:lbl_dotLine];
    
    //
    viewProductList = [[UIView alloc] initWithFrame:CGRectMake(0, btnGiftHead.frame.size.height, viewGift.frame.size.width, heightGiftImg)];
    [viewProductList setBackgroundColor:[UIColor clearColor]];
    [viewGift addSubview:viewProductList];
    
    //  --  ..
    scrollViewGift = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 10, viewGift.frame.size.width-60, heightGiftImg)];
    [scrollViewGift setBackgroundColor:[UIColor clearColor]];
    [scrollViewGift setDelegate:self];
    [scrollViewGift setShowsHorizontalScrollIndicator:NO];
    [viewProductList addSubview:scrollViewGift];
    
    for (int i=0; i<2; i++) {
        UIButton * btn_LRScroll = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_LRScroll setFrame:CGRectMake(i==0?0:viewGift.frame.size.width-30, scrollViewGift.frame.origin.y, 30, heightGiftImg)];
        [btn_LRScroll setTag:56783+i];
        [btn_LRScroll setBackgroundColor:[UIColor clearColor]];
        [btn_LRScroll setImage:[UIImage imageNamed:i==0?@"left_icon.png":@"right_icon.png"] forState:UIControlStateNormal];
        [btn_LRScroll addTarget:self action:@selector(onBtnScrollClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewProductList addSubview:btn_LRScroll];
    }
}

- (void) setGiftData:(NSMutableArray *) _arrData{
    
    arrGifts =_arrData;
    [viewGift setHidden:YES];
    for (UIImageView * IMGView in scrollViewGift.subviews) {
        [IMGView removeFromSuperview];
    }
    
    if (arrGifts.count>0) {
        [viewGift setHidden:NO];
        if (lbl_proSpec.text.length==0) {
            [viewGift setFrame:CGRectMake(viewGift.frame.origin.x, 108, viewGift.frame.size.width, heightGiftArea)];
        }
        
        if (IsOpenGiftView) {
            
            [scrollViewGift setContentSize:CGSizeMake((widthGiftImg+20)*arrGifts.count, heightGiftImg)];
            
            for (int i=0; i<arrGifts.count; i++) {
                
                resMod_Mall_CartPresentInfo * giftinfo = arrGifts[i];
                
                UIImageView * GiftImg = [[UIImageView alloc] init];
                [GiftImg setFrame:CGRectMake((widthGiftImg+20)*i,0, widthGiftImg, heightGiftImg)];
                [GiftImg setBackgroundColor:[UIColor clearColor]];
                [GiftImg setTag:giftinfo.PresentId];
                GiftImg.layer.borderColor = color_b3b3b3.CGColor;
                GiftImg.layer.borderWidth = 0.5f;
                [GiftImg sd_setImageWithURL:[NSURL URLWithString: giftinfo.PresentImg]
                        placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
                UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCartGiftClick:)];
                [GiftImg addGestureRecognizer:singleTap];
                GiftImg.userInteractionEnabled =YES;
                [self.scrollViewGift addSubview:GiftImg];
                
                UILabel * lblno = [[UILabel alloc] init];
                [lblno setFrame:CGRectMake(0, GiftImg.frame.size.height-18, GiftImg.frame.size.width, 18)];
                [lblno setBackgroundColor:[UIColor blackColor]];
                [lblno setTextColor:[UIColor whiteColor]];
                [lblno setTextAlignment:NSTextAlignmentCenter];
                [lblno setAlpha:0.5];
                [lblno setText:[NSString stringWithFormat:@"数量X%d",giftinfo.PresentNum]];
                [lblno setFont:defFont12];
                [GiftImg addSubview:lblno];
            }
        }
    }
    
    [self showOrhideGiftView];
}

- (void) showOrhideGiftView{
    
    UIView * giftBG = [viewGift viewWithTag:tagGiftBG];
    [giftBG removeFromSuperview];
    giftBG = nil;
    
    if (arrGifts.count>0) {
        if (IsOpenGiftView) {
            [IconBtnRight setImage:[UIImage imageNamed:@"info_icon_open.png"]];
            [viewProductList setHidden:NO];
            giftBG = [UICommon Common_DottedCornerRadiusView:CGRectMake(0, 0, 592/2, heightGiftArea)
                                                  targetView:viewGift tag:tagGiftBG dottedImgName:nil];
        }
        else{
            [IconBtnRight setImage:[UIImage imageNamed:@"right_icon.png"]];
            [viewProductList setHidden:YES];
            giftBG = [UICommon Common_DottedCornerRadiusView:CGRectMake(0, 0, 592/2, 35)
                                                  targetView:viewGift tag:tagGiftBG dottedImgName:nil];
        }
    }
    
    [viewGift sendSubviewToBack: giftBG];
}

@end


