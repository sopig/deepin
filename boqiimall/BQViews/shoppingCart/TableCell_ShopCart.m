//
//  TableCell_ShopCart.m
//  boqiimall
//
//  Created by ysw on 14-10-14.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "TableCell_ShopCart.h"

#define paddingForLable 6
#define cellMinHeight   86

@implementation TableCell_ShopCart
@synthesize productIMG;
@synthesize lbl_title;
@synthesize lbl_salePrice;
@synthesize lbl_proSpec;
@synthesize lbl_proNum;
@synthesize txt_proNum;
@synthesize btn_check;

@synthesize view_activity;
@synthesize view_ResultsOfActivities;

@synthesize delegateCart;
@synthesize cellResourceData;
@synthesize dic_tagColor;
@synthesize lblDotLine;

- (void)awakeFromNib {
    dic_tagColor = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"活动|1E9E49"       ,@"actionid_0",
                    @"满减|FD5E44"       ,@"actionid_1",
                    @"折扣|1E9E49"       ,@"actionid_2",
                    @"折扣价|FF387F"     ,@"actionid_3",
                    @"多买优惠|556FB5"    ,@"actionid_4",
                    @"赠品|E3000F"       ,@"actionid_5",
                    @"团购|E3000F"       ,@"actionid_6",
                    @"满赠|FD5E44"       ,@"actionid_7",
                    @"换购|FEB037"       ,@"actionid_8",nil];
    
    productIMG.frame = CGRectMake(productIMG.frame.origin.x, productIMG.frame.origin.y, 60, 60);
    productIMG.BackgroundColor = [UIColor whiteColor];
    productIMG.layer.borderColor = color_d1d1d1.CGColor;
    productIMG.layer.borderWidth = 0.5f;

    [lbl_title setTextColor:color_333333];
    
    [lbl_salePrice setFont:defFont(YES, 13)];
    [lbl_salePrice setTextColor:color_fc4a00];
    
    [lbl_proSpec setFont:defFont12];
    [lbl_proSpec setTextColor:color_989898];
    
    [lbl_proNum setTextColor:color_989898];
    [txt_proNum setTextColor:color_989898];
    [txt_proNum setDelegate:self];
    [txt_proNum setBackgroundColor:[UIColor whiteColor]];
    [txt_proNum setBorderStyle:UITextBorderStyleNone];
    [txt_proNum setKeyboardType:UIKeyboardTypeNumberPad];
    txt_proNum.layer.borderWidth = 0.5;
    txt_proNum.layer.borderColor = color_d1d1d1.CGColor;
    
    [btn_check setImage:[UIImage imageNamed:@"checkbox_greenUnsel.png"] forState:UIControlStateNormal];
    [btn_check addTarget:self action:@selector(onCellProductChecked:) forControlEvents:UIControlEventTouchUpInside];
    
    //  -- 单品优惠活动 上面 的 虚线
    lblDotLine = [[UILabel alloc] initWithFrame:CGRectMake(productIMG.frame.origin.x, cellMinHeight, __MainScreen_Width-productIMG.frame.origin.x-10, 0.5)];
    [lblDotLine setBackgroundColor:[UIColor clearColor]];
    lblDotLine.layer.borderColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
    lblDotLine.layer.borderWidth=0.5f;
    [self addSubview:lblDotLine];
    
    //  --  活动说明区
    view_activity = [[UIView alloc] initWithFrame:CGRectMake(0, cellMinHeight + 10, __MainScreen_Width, 0)];
    [view_activity setBackgroundColor:[UIColor clearColor]];
    [self addSubview:view_activity];
    
    //  --  活动结果 & 更换优惠or换购 区
    view_ResultsOfActivities = [[UIView alloc] initWithFrame:CGRectMake(0, cellMinHeight + 10, __MainScreen_Width, 0)];
    [view_ResultsOfActivities setBackgroundColor:[UIColor clearColor]];
    [self addSubview:view_ResultsOfActivities];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark    --  加载 *活动说明* 区
- (void)setViewActivity{
    for (UIView * subview in view_activity.subviews) {
        [subview removeFromSuperview];
    }
    
    float areaHeight=0;
    int i=0;
    if (cellResourceData && cellResourceData.PreferentialInfo.count>0) {
        for (resMod_Mall_CartPreferentialInfo * tmpPreferential in cellResourceData.PreferentialInfo) {
            
            NSString * spreferential = [dic_tagColor objectForKey:[NSString stringWithFormat:@"actionid_%d",tmpPreferential.ActionId]];
            NSArray * arrpre = [spreferential componentsSeparatedByString:@"|"];
            
            CGSize tsize = [arrpre[0] sizeWithFont:defFont12 constrainedToSize:CGSizeMake(MAXFLOAT, 18)];
            //  -- 单个活动 活动介绍
            [UICommon Common_UILabel_Add:CGRectMake(productIMG.frame.origin.x, areaHeight + paddingForLable +2, tsize.width+4, 16)  targetView:view_activity
                                 bgColor:[UIColor convertHexToRGB:arrpre[1]]
                                     tag:3001
                                    text:arrpre[0]
                                   align:0 isBold:NO fontSize:12 tColor:[UIColor whiteColor]];
            
            CGRect cgframe1 = CGRectMake(productIMG.frame.origin.x + tsize.width + 12,
                                        areaHeight + paddingForLable,
                                        __MainScreen_Width-productIMG.frame.origin.x - tsize.width - 12 -12,
                                        20);

            UIButton * btnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnTitle setFrame:cgframe1];
            [btnTitle setBackgroundColor:[UIColor clearColor]];
            [btnTitle setTitle:tmpPreferential.ActionTitle forState:UIControlStateNormal];
            [btnTitle setTitleColor:color_333333 forState:UIControlStateNormal];
            [btnTitle setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btnTitle.titleLabel setFont:defFont12];
            [view_activity addSubview:btnTitle];
            
            areaHeight += cgframe1.size.height + paddingForLable;
            i++;
        }
    }
    
    [lblDotLine setHidden: areaHeight>0 ? NO:YES];
    [view_activity setFrame:CGRectMake(0, cellMinHeight, __MainScreen_Width, areaHeight+(areaHeight>0?5:0))];
}

#pragma mark    --  加载 *活动结果 & 更换优惠or换购* 区
- (void)setViewResultsOfActivities{
    for (UIView * subview in view_ResultsOfActivities.subviews) {
        [subview removeFromSuperview];
    }

    float fheight=0;
    
    //  -- 更换或换购按钮
    if(cellResourceData && (cellResourceData.IsChangeBuy || cellResourceData.IsPreferential)){
        
        if (cellResourceData.IsPreferential) {
            UIButton * btn_ChangePreferential = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn_ChangePreferential setTag:778866];
            [btn_ChangePreferential setFrame:CGRectMake(__MainScreen_Width-78, 7, 66, 25)];
            [btn_ChangePreferential setBackgroundImage:def_ImgStretchable(@"btn_bg_blackline.png",6,6)
                                              forState:UIControlStateNormal];
            [btn_ChangePreferential setTitle:@"更换优惠" forState:UIControlStateNormal];
            [btn_ChangePreferential setTitleColor:color_575757 forState:UIControlStateNormal];
            [btn_ChangePreferential.titleLabel setFont:defFont12];
            [btn_ChangePreferential addTarget:self action:@selector(onChangeClick:) forControlEvents:UIControlEventTouchUpInside];
            [view_ResultsOfActivities addSubview:btn_ChangePreferential];

            fheight = 25+7+7;
        }
        if (cellResourceData.IsChangeBuy){
            UIButton * btn_ChangeProduct = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn_ChangeProduct setTag:778899];
            [btn_ChangeProduct setFrame:CGRectMake(__MainScreen_Width-78, fheight, 66, 25)];
            [btn_ChangeProduct setBackgroundImage:def_ImgStretchable(@"btn_bg_blackline.png",6,6) forState:UIControlStateNormal];
            [btn_ChangeProduct setTitle:@"换购"
                               forState:UIControlStateNormal];
            [btn_ChangeProduct setTitleColor:color_575757 forState:UIControlStateNormal];
            [btn_ChangeProduct.titleLabel setFont:defFont12];
            [btn_ChangeProduct addTarget:self action:@selector(onChangeClick:) forControlEvents:UIControlEventTouchUpInside];
            [view_ResultsOfActivities addSubview:btn_ChangeProduct];

            fheight = fheight==0 ? 25+7+7 : fheight+25+7;
        }
    }
    
    //  -- 结果提示
    if (cellResourceData && cellResourceData.ActionResult.length>0) {
        
        fheight = fheight==0 ? 39:fheight;
        [UICommon Common_UILabel_Add:CGRectMake(productIMG.frame.origin.x,0,__MainScreen_Width-productIMG.frame.origin.x-80, fheight)
                          targetView:view_ResultsOfActivities
                             bgColor:[UIColor clearColor] tag:4002
                                text:cellResourceData.ActionResult//@"活动商品已购买满 100 元，送罐头"
                               align:-1 isBold:NO fontSize:12 tColor:[UIColor redColor]];
    }
    
    [lblDotLine setHidden: (!lblDotLine.hidden || fheight>0) ? NO:YES];
    [view_ResultsOfActivities setFrame:CGRectMake(0, CGRectGetMaxY(view_activity.frame), __MainScreen_Width, fheight)];
}


#pragma mark    --  event or cell delegate

- (void)setBtnCheckImage{
    [btn_check setImage:[UIImage imageNamed:cellResourceData.IsSelected?@"checkbox_greensel.png":@"checkbox_greenUnsel.png"]
               forState:UIControlStateNormal];
}

- (void)onCellProductChecked:(id)sender{
    
    cellResourceData.IsSelected = !cellResourceData.IsSelected;
    
    [self setBtnCheckImage];
    if ([delegateCart respondsToSelector:@selector(onDelegateCellRowProductChecked:)]) {
        [delegateCart onDelegateCellRowProductChecked:self];
    }
}

- (void)onChangeClick:(id) sender{
    UIButton * btntmp = (UIButton*)sender;
    if ([delegateCart respondsToSelector:@selector(onDelegateChangeType: btnTag:)]) {
        [delegateCart onDelegateChangeType:self btnTag:btntmp.tag];
    }
}

#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([delegateCart respondsToSelector:@selector(onDelegateChangeProNum:)]) {
        [delegateCart onDelegateChangeProNum:self];
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

@end




