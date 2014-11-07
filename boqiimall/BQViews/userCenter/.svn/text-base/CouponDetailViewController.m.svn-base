//
//  CouponDetailViewController.m
//  BoqiiLife
//
//  Created by 张正超 on 14-7-22.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "CouponDetailViewController.h"

#define HeightHead  90
#define HeightTitle 40
#define couponCanUse @"ticket_number_icon.png:券号|money_icon.png:需消费金额|effective_time_icon.png:生效时间|dead_time_icon.png:失效时间|instructions_icon.png:优惠券说明|range_icon.png:使用范围"
#define couponHasUsed @"ticket_number_icon.png:券号|money_icon.png:需消费金额|effective_time_icon.png:生效时间|dead_time_icon.png:失效时间|ues_service_number_icon.png:使用订单号|use_time_icon.png:使用时间"

@interface CouponDetailViewController () {
    BOOL _isShow;
}
@end


@implementation CouponDetailViewController
@synthesize CouponType;
@synthesize couponStatus;
@synthesize params_couponid;
@synthesize params_couponrange;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.couponStatus = -100;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadNavBarView];
    [self setTitle:@"优惠券详情"];
   // [self setTitle:@"优惠券详情"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
  //  [self loadNavBarView:@"优惠券详情"];
    
    self.CouponType = [self.receivedParams objectForKey:@"param_CouponType"];
    self.couponStatus = [[self.receivedParams objectForKey:@"param_CouponStatus"] intValue];
    self.params_couponid = [self.receivedParams objectForKey:@"param_CouponId"];
    self.params_couponrange = [self.receivedParams objectForKey:@"param_CouponRange"];
    
    _isShow = NO;
    
    if (self.params_couponid.length==0) {
        [self HUDShow:@"优惠券id为空" delay:1.5];
        return;
    }
    
    rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    [rootScrollView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:rootScrollView];
    
    rootScrollView.backgroundColor = color_body;
    
  
    [self goApiRequest];
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
//    [self.navBarView addSubview:bgView];
//}

- (void) onBtnCopyClick:(id) sender{
    [MobClick event:@"userCenter_myTicketDetail_copy"];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:couponDetail.CouponNo];
    [self HUDShow:@"已复制" delay:1];
}

- (void) addView_head{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Height, HeightHead)];
    [headView setBackgroundColor:[UIColor whiteColor]];
    [rootScrollView addSubview:headView];
    
    UIImageView * imgcode = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 194/2, 130/2)];
    [imgcode setBackgroundColor:[UIColor clearColor]];
    [imgcode setImage:[UIImage imageNamed:self.couponStatus ==1 ? @"mycoupon_canUse" : @"mycoupon_noUse"]];
    [headView addSubview:imgcode];
    
    [UICommon Common_UILabel_Add:CGRectMake(115, 9, 200, 20)
                      targetView:headView bgColor:[UIColor clearColor] tag:1001
                            text: couponDetail.CouponTitle //@"优惠券详情优惠券详情优惠券详情" //@"9888 8888 88"
                           align:-1 isBold:NO fontSize:14 tColor:color_333333];
    [UICommon Common_UILabel_Add:CGRectMake(115, 35, 100, 20)
                      targetView:headView bgColor:[UIColor clearColor] tag:1003
                            text:[self convertPrice:couponDetail.CouponPrice]  //@"40元"
                           align:-1 isBold:YES fontSize:15 tColor:color_fc4a00];
    [UICommon Common_UILabel_Add:CGRectMake(180, 37, 45, 16)
                      targetView:headView
                         bgColor: self.couponStatus==1 ? color_8fc31f : (self.couponStatus==2 ? color_ff2a00 : color_989898)
                             tag:1004
                            text: self.couponStatus==1 ? @"未使用" : (self.couponStatus==2 ? @"已使用" : @"已过期")
                           align:0 isBold:NO fontSize:12 tColor:[UIColor whiteColor]];
    [UICommon Common_UILabel_Add:CGRectMake(115, 57, 200, 20)
                      targetView:headView bgColor:[UIColor clearColor] tag:1004
                            text:[NSString stringWithFormat:@"使用范围: %@",params_couponrange]
                           align:-1 isBold:NO fontSize:13 tColor:color_989898];
    
    [UICommon Common_line:CGRectMake(0, HeightHead-10, __MainScreen_Width, 10) targetView:rootScrollView backColor:color_body];
}

- (void) addDetailView{

    NSArray * arrDetails = [(self.couponStatus ==1 || self.couponStatus == 3 ? couponCanUse:couponHasUsed) componentsSeparatedByString:@"|"];
    int i=0;
    int ypoint = HeightHead;
    for (NSString * stxt in arrDetails) {
        NSArray * svalue = [stxt componentsSeparatedByString:@":"];
        NSString * titleIcon = svalue[0];
        NSString * stitle = svalue[1];
        
        //准备内容
         NSString * sContent = @"";
        if (i == 0) {
            sContent = couponDetail.CouponNo;
        }
        else if (i == 1){
            sContent = couponDetail.CouponCondition;
        }
        else if (i == 2){
            sContent = couponDetail.CouponStartTime;
        }
        else if (i == 3){
            sContent = couponDetail.CouponEndTime;
        }else if (i == 4){
            sContent = self.couponStatus==1 ? couponDetail.CouponDesc : couponDetail.CouponUsedOrder; //@"优惠券说明";
        }else if (i == 5){
            sContent = self.couponStatus==1 ? couponDetail.CouponRange: couponDetail.CouponUsedTime;
        }
        
        //添加视图
       
        if (i != 0 && i !=4) {
            [self creatLabelWithTitle:stitle andWithContent:sContent andWithIconImage:titleIcon addTarget:rootScrollView withYPoint:ypoint];
    }
        else if( i == 0)
        {
            
#define COUPON_STATUS_HASUSE 2
#define COUPON_STATUS_OVER_DUETIME 3
            
            if (sContent != nil && self.couponStatus != COUPON_STATUS_HASUSE && self.couponStatus != COUPON_STATUS_OVER_DUETIME )
            
            {
                _isShow = YES;
            }
            else
                _isShow = NO;
            
            CGSize defSize = CGSizeMake(300, MAXFLOAT);
            CGSize size = [sContent sizeWithFont:defFont18 constrainedToSize:defSize lineBreakMode:NSLineBreakByWordWrapping];
            [self addLabelWithTitle:stitle andWithContent:sContent andWithIconImage:titleIcon addTarget:rootScrollView withYPoint:ypoint withFont:defFont18 andWithContentLabelHeight:size.height showButton:_isShow];
        }
        else if (i == 4){
//            sContent = @"我的优惠券 我的优惠券 我的优惠券 我的优惠券 我的优惠券 我的优惠券 我的优惠券 我的优惠券 我的优惠券 我的优惠券 我的优惠券 我的优惠券 我的优惠券我的优惠券 我的优惠券 我的优惠券 我的优惠券";
            if (self.couponStatus == COUPON_STATUS_HASUSE) {
                
                 [self creatLabelWithTitle:stitle andWithContent:sContent andWithIconImage:titleIcon addTarget:rootScrollView withYPoint:ypoint];
                
            }
            else{
                CGSize defSize = CGSizeMake(300, MAXFLOAT);
                CGSize size = [sContent sizeWithFont:defFont15 constrainedToSize:defSize lineBreakMode:NSLineBreakByWordWrapping];
                [self addLabelWithTitle:stitle andWithContent:sContent andWithIconImage:titleIcon addTarget:rootScrollView withYPoint:ypoint withFont:defFont15 andWithContentLabelHeight:size.height showButton:NO];
            }
            
            
           
  }
        
        
        //视图布局处理
        if (i != 0 && i != 4) {
            ypoint += 58;
        }
        else if( i == 0){
            
            CGSize defSize = CGSizeMake(300, MAXFLOAT);
            CGSize size = [sContent sizeWithFont:defFont18 constrainedToSize:defSize lineBreakMode:NSLineBreakByWordWrapping];
            
            if (size.height < 38) {
                size.height = 38;
            }
            
            ypoint += 65 +size.height ;
        }
        else if (i == 4){
            
            if (self.couponStatus == COUPON_STATUS_HASUSE) {
                ypoint += 58;
            }
            else{
                
                CGSize defSize = CGSizeMake(300, MAXFLOAT);
                CGSize size = [sContent sizeWithFont:defFont15 constrainedToSize:defSize lineBreakMode:NSLineBreakByWordWrapping];
                
                if (size.height < 38) {
                    size.height = 38;
                }
                
                ypoint += 65 + size.height ;

            }
            
       }
    
        i++;
}
    [rootScrollView setContentSize:CGSizeMake(__MainScreen_Width, ypoint)];
    
}


#pragma mark    --  api 请求 加调

-(void) goApiRequest{
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKeyPath:@"UserId"];
    [dicParams setValue:self.params_couponid forKey:@"CouponId"];
    [dicParams setValue:self.CouponType  forKey:@"CouponType"];
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_CouponDetailV2 class:@"resMod_CallBack_GetCoupon" params:dicParams  isShowLoadingAnimal:NO hudShow:@"正在加载"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetCouponDetailV2:dicParams ModelClass:@"resMod_CallBack_GetCoupon" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
    
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self.lodingAnimationView stopLoadingAnimal];
    if ([ApiName isEqualToString:kApiMethod_CouponDetailV2]) {
        resMod_CallBack_GetCoupon * backObj = [[resMod_CallBack_GetCoupon alloc] initWithDic:retObj];
        couponDetail = backObj.ResponseData;
        
        if (couponDetail!=nil) {
            [self addView_head];
            [self addDetailView];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)addLabelWithTitle:(NSString*)title andWithContent:(NSString*)content andWithIconImage:(NSString*)img addTarget:(UIView*)targetView withYPoint:(CGFloat)ypoint withFont:(UIFont*)font andWithContentLabelHeight:(CGFloat)height showButton:(BOOL)show
{
#define color_383838 [UIColor convertHexToRGB:@"383838"]
    if (height <= 38) {
        height = 38;
    }
    
    //背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ypoint, __MainScreen_Width, 50 + height + 4)];
    bgView.backgroundColor = [UIColor whiteColor];
    [targetView addSubview:bgView];

    
    //分割线
    [UICommon Common_line:CGRectMake(0,94/2,__MainScreen_Width,0.5) targetView:bgView backColor:color_bodyededed];
    
    //icon
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10 , 30, 30)];
    iconImageView.backgroundColor = [UIColor clearColor];
    iconImageView.image = [UIImage imageNamed:img];
    [bgView addSubview:iconImageView];

    
    //title
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 100, 38)];
    titleLabel.text = title;
    titleLabel.font = defFont15;
    titleLabel.textColor = color_383838;
    [bgView addSubview:titleLabel];
    

    //内容
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 300, height)];
    contentLabel.text = content;
    contentLabel.textColor = color_989898;
    contentLabel.font = font;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:contentLabel];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    //复制按钮
    if (show) {
        UIButton * btnCopy = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCopy setFrame:CGRectMake(200, 55, 100, 30)];
        [btnCopy setBackgroundColor: color_fc4a00];
        [btnCopy setTitle:@"点击复制" forState:UIControlStateNormal];
        [btnCopy.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btnCopy addTarget:self action:@selector(onBtnCopyClick:) forControlEvents:UIControlEventTouchUpInside];
         btnCopy.layer.cornerRadius = 3.0;
        [bgView addSubview:btnCopy];

    }
}

- (void)creatLabelWithTitle:(NSString*)title andWithContent:(NSString*)content andWithIconImage:(NSString*)img addTarget:(UIView*)targetView withYPoint:(CGFloat)ypoint
{
#define color_383838 [UIColor convertHexToRGB:@"383838"]
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ypoint, __MainScreen_Width, 46)];
    bgView.backgroundColor = [UIColor whiteColor];
    [targetView addSubview:bgView];
    
    
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10 , 30, 30)];
    iconImageView.backgroundColor = [UIColor clearColor];
    iconImageView.image = [UIImage imageNamed:img];
    [bgView addSubview:iconImageView];
    
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 100, 38)];
    titleLabel.text = title;
    titleLabel.font = defFont15;
    titleLabel.textColor = color_383838;
    [bgView addSubview:titleLabel];
    
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 5, 160, 38)];
    contentLabel.text = content;
    contentLabel.textColor = color_989898;
    contentLabel.font = defFont12;
    contentLabel.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:contentLabel];
}


@end
