//
//  MallOrderDetailViewController.m
//  boqiimall
//
//  Created by YSW on 14-7-11.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "MallOrderDetailViewController.h"

#define orderMoneyDetail @"订单金额|商品金额|运费金额|优惠金额|使用优惠券"
#define heightRowOrderMoneyDetail 45
#define heightRowProductList    95

#define btnOprateCommon       @"点 评"
#define btnOprateBuyAgain     @"再次购买"

@implementation MallOrderDetailViewController
@synthesize param_OrderID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [btnOrderOperate setHidden:YES];
    [self goApiRequest_OrderDetail];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadNavBarView];
    [self setTitle:@"订单详情"];
    [self.view setBackgroundColor:color_bodyededed];
    
   // [self loadNavBarView:@"订单详情"];
    self.param_OrderID = [self.receivedParams objectForKey:@"param_orderid"];
    //  -- 取消订单
//    btnCancle = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnCancle setHidden:YES];
//    [btnCancle setFrame:CGRectMake(6, 2, 60, 40)];
//    [btnCancle setBackgroundColor:[UIColor clearColor]];
//    [btnCancle setTitleColor:color_fc4a00 forState:UIControlStateNormal];
//    [btnCancle.titleLabel setFont:defFont14];
//    [btnCancle setTitle:@"取消订单" forState:UIControlStateNormal];
//    [btnCancle addTarget:self action:@selector(onCancleOrderClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * r_bar = [[UIBarButtonItem alloc]initWithCustomView:btnCancle];
//    self.navigationItem.rightBarButtonItem = r_bar;
//    self.navigationItem.rightBarButtonItem.style = UIBarButtonItemStyleDone;
    
    //  --
    btnOrderOperate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOrderOperate setHidden:YES];
    [btnOrderOperate setFrame:CGRectMake(__MainScreen_Width-95, 15, 70, 35)];
    [btnOrderOperate setBackgroundColor:color_fc4a00];
    [btnOrderOperate setTitle:@"付 款" forState:UIControlStateNormal];
    [btnOrderOperate.titleLabel setFont:defFont14];
    btnOrderOperate.layer.cornerRadius = 2.0f;
    [btnOrderOperate addTarget:self action:@selector(onOperateClick:) forControlEvents:UIControlEventTouchUpInside];

    rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    rootTableView.backgroundColor = [UIColor clearColor];
    [rootTableView setHidden:YES];
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:rootTableView];
}

- (void)loadNavBarView
{
    [super loadNavBarView];
    [self._titleLabel setFrame:CGRectMake(80, 2, 160, 40)];
    btnCancle = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnCancle setHidden:YES];
    [btnCancle setFrame:CGRectMake(250, 2, 60, 40)];
    [btnCancle setBackgroundColor:[UIColor clearColor]];
    [btnCancle setTitleColor:color_fc4a00 forState:UIControlStateNormal];
    [btnCancle.titleLabel setFont:defFont14];
    //  btnCancle.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btnCancle setTitle:@"取消订单" forState:UIControlStateNormal];
    [btnCancle addTarget:self action:@selector(onCancleOrderClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.subNavBarView addSubview:btnCancle];
}

//- (void)loadNavBarView:(NSString *)title
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 2, 160, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = title;
//    [bgView addSubview:titleLabel];
//    btnCancle = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnCancle setHidden:YES];
//    [btnCancle setFrame:CGRectMake(250, 2, 60, 40)];
//    [btnCancle setBackgroundColor:[UIColor clearColor]];
//    [btnCancle setTitleColor:color_fc4a00 forState:UIControlStateNormal];
//    [btnCancle.titleLabel setFont:defFont14];
//  //  btnCancle.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [btnCancle setTitle:@"取消订单" forState:UIControlStateNormal];
//    [btnCancle addTarget:self action:@selector(onCancleOrderClick:) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:btnCancle];
//    [self.navBarView addSubview:bgView];
//}

#pragma mark    --  取消订单
- (void) onCancleOrderClick:(id)sender{
    EC_UICustomAlertView *alertView = [[EC_UICustomAlertView alloc]initWithTitle:@"取消订单" message:@"您确定要取消该订单吗?" cancelButtonTitle:@"否" okButtonTitle:@"是"];
    alertView.delegate1 = self;
    [alertView show];
//    [alertView showInView:[UIApplication sharedApplication].keyWindow];
}

- (void) onOperateClick:(id)sender{
    
    if (m_OrderDetail.OrderStatusInt==2) {  //待付款
        
        NSMutableDictionary * dicparam = [[NSMutableDictionary alloc]init];
        [dicparam setObject:self.param_OrderID forKey:@"param_orderid"];
        [dicparam setObject:[NSString stringWithFormat:@"%.2f",m_OrderDetail.OrderPrice] forKey:@"param_orderprice"];
        [dicparam setObject:@"100" forKey:@"param_isFromOrderList"];
        [dicparam setObject:m_OrderDetail.IsUseBalance?@"100":@"0" forKey:@"param_isUsedBalance"];
        [dicparam setObject:[NSString stringWithFormat:@"%.2f",m_OrderDetail.BalanceUsed] forKey:@"param_BalanceUsed"];
        [self pushNewViewController:@"MallOrderPaymentVC" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:dicparam];
    }
    if (m_OrderDetail.OrderStatusInt==4) {  //&& m_OrderDetail.OrderLogisticsUrl.length>0
        NSMutableDictionary * param = [[NSMutableDictionary alloc] init];
        [param setValue:self.param_OrderID forKey:@"param_OrderId"];
//        [param setValue:m_OrderDetail.OrderLogisticsUrl forKey:@"param_url"];
        [self pushNewViewController:@"LogisticsViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:param];
    }
    
}

- (void) onBuyAgainClick:(id)sender{
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_BuyAgain class:@"ResponseBase"
//              params:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                      [UserUnit userId],@"UserId",self.param_OrderID,@"OrderId",nil]  isShowLoadingAnimal:NO hudShow:@"正在加载"];
    
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestShoppingMallOrderReBuy:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                                               [UserUnit userId],@"UserId",self.param_OrderID,@"OrderId",nil] ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
    
    
}

- (void) onCommentClick:(id)sender{
    
    if (m_OrderDetail.OrderStatusInt==4) {
        [self pushNewViewController:@"MallProductCommentController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                     self.param_OrderID,@"param_OrderID", nil]];
    }
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return section==2 ? m_OrderDetail.GoodsList.count :1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float cellheight = 0;
    if (indexPath.section ==0) {
        cellheight = 75;
    }
    if (indexPath.section ==1) {
        cellheight = 20 + heightRowOrderMoneyDetail*5+10;
    }
    if (indexPath.section ==2) {
        
        cellheight = heightRowProductList;
        if (indexPath.row==0) {
            cellheight += 60;
        }
        if (indexPath.row==9) {
            cellheight += 12;
        }
    }
    if (indexPath.section ==3) {
        cellheight = 230;
    }
    return cellheight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int section = indexPath.section;
    static  NSString * Identifier = @"mallOrderDetailCell";
    UITableViewCell * cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    
    if (section>0 && section!=3 && indexPath.row==0 ) {
         [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
    }
    
    if (section==0) {
        [UICommon Common_DottedCornerRadiusView:CGRectMake(12, -3, 592/2, 70) targetView:cell.contentView tag:1000 dottedImgName:nil];
        
        [UICommon Common_UILabel_Add:CGRectMake(22, 10, 70, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1000
                                text:@"订单状态:" align:-1 isBold:NO fontSize:14 tColor:color_333333];
        
        [UICommon Common_UILabel_Add:CGRectMake(88, 10, 80, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1000
                                text: m_OrderDetail.OrderStatusString// @"待付款"
                               align:-1 isBold:NO fontSize:14 tColor:color_fc4a00];
        
        [UICommon Common_UILabel_Add:CGRectMake(22, 35, 60, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1000
                                text:@"订单号:" align:-1 isBold:NO fontSize:14 tColor:color_333333];
        
        [UICommon Common_UILabel_Add:CGRectMake(75, 35, 80, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:1000
                                text:self.param_OrderID align:-1 isBold:NO fontSize:14 tColor:color_989898];
        
        if (m_OrderDetail.OrderStatusInt==2 && m_OrderDetail.PaymentId!=2) {  //待付款
            [btnOrderOperate setHidden:NO];
            [btnOrderOperate setTitle:@"立即支付" forState:UIControlStateNormal];
        }
        if (m_OrderDetail.OrderStatusInt==4) {  //&& m_OrderDetail.OrderLogisticsUrl.length>0
            [btnOrderOperate setHidden:NO];
            [btnOrderOperate setTitle:@"查看物流" forState:UIControlStateNormal];
        }

        [cell.contentView addSubview:btnOrderOperate];
    }
    else if (section==1) {
        //  --  支付明细
        UIView *view_PayDetail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightRowOrderMoneyDetail*5+20)];
        [view_PayDetail setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:view_PayDetail];
        
        UIImageView * bgTop = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, def_WidthArea(10), view_PayDetail.frame.size.height-10)];
        [bgTop setBackgroundColor:[UIColor clearColor]];
        [bgTop setImage:def_ImgStretchable(@"green_bg.png", 11, 10)];
        [view_PayDetail addSubview:bgTop];
        
        UIImageView * bgFoot = [[UIImageView alloc] initWithFrame:CGRectMake(15, view_PayDetail.frame.size.height, view_PayDetail.frame.size.width-30, 7/2)];
        [bgFoot setBackgroundColor:[UIColor clearColor]];
        [bgFoot setImage:[UIImage imageNamed:@"misumi_ine.png"]];
        [view_PayDetail addSubview:bgFoot];
        float ypoint = 0;
        NSArray * arrPays = [orderMoneyDetail componentsSeparatedByString:@"|"];
        for (int i=0; i<arrPays.count; i++) {
            
            ypoint = 14 + heightRowOrderMoneyDetail*i;
            
            float fmoney = 0.0;
            
            switch (i) {
                case 0: fmoney = m_OrderDetail.OrderPrice;
                    break;
                case 1: fmoney = m_OrderDetail.GoodsPrice;
                    break;
                case 2: fmoney = m_OrderDetail.ExpressagePrice;
                    break;
                case 3: fmoney = m_OrderDetail.PreferentialPrice;
                    break;
                case 4: fmoney = m_OrderDetail.CouponPrice;
                    break;
                default:
                    break;
            }
            
            [UICommon Common_UILabel_Add:CGRectMake(26, ypoint, 80, heightRowOrderMoneyDetail)
                              targetView:cell.contentView bgColor:[UIColor clearColor] tag:4002
                                    text:[NSString stringWithFormat:@"%@:",arrPays[i]]
                                   align:-1 isBold:NO
                                fontSize:14
                                  tColor:color_4e4e4e];
            
            [UICommon Common_UILabel_Add: CGRectMake(__MainScreen_Width-106, ypoint, 80, heightRowOrderMoneyDetail)
                              targetView: cell.contentView bgColor:[UIColor clearColor] tag:1000
                                    text: [self convertPrice:fmoney]
                                   align: 1
                                  isBold: i==0 ? YES:NO
                                fontSize: i==0 ? 15:14
                                  tColor: i==0 ? color_fc4a00:color_4e4e4e];
            if (i>0) {
                UILabel * dotLine = [[UILabel alloc] initWithFrame:CGRectMake(21, ypoint, def_WidthArea(21), 0.5)];
                [dotLine setBackgroundColor:[UIColor clearColor]];
                dotLine.layer.borderColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
                dotLine.layer.borderWidth=0.5f;
                [cell.contentView addSubview:dotLine];
            }
        }
    }
    else if(section==2){
        
        resMod_Mall_OrderGoodsInfo * proinfo = m_OrderDetail.GoodsList[indexPath.row];
        
        float heighttop = 0;
        if (indexPath.row==0) {
            heighttop = 60;
            UIImageView *topBg = [[UIImageView alloc] init];
            [topBg setFrame:CGRectMake(12,10,592/2,3)];
            [topBg setBackgroundColor:[UIColor clearColor]];
            [topBg setImage:[UIImage imageNamed:@"dottedLineWhite_top.png"]];
            [cell.contentView addSubview:topBg];

            [UICommon Common_UILabel_Add:CGRectMake(25, 20, 190, 30)
                              targetView:cell.contentView bgColor:[UIColor clearColor] tag:2003
                                    text:@"商品列表"
                                   align:-1 isBold:NO fontSize:18 tColor:color_333333];
            UIButton * btnBuyAgain = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnBuyAgain setFrame:CGRectMake(__MainScreen_Width-93, 22, 70, 26)];
            [btnBuyAgain setBackgroundColor:[UIColor clearColor]];
            [btnBuyAgain setBackgroundImage:def_ImgStretchable(@"btn_bg_blackline.png", 8, 8) forState:UIControlStateNormal];
            [btnBuyAgain setTitle:@"再次购买" forState:UIControlStateNormal];
            [btnBuyAgain setTitleColor:color_333333 forState:UIControlStateNormal];
            [btnBuyAgain addTarget:self action:@selector(onBuyAgainClick:) forControlEvents:UIControlEventTouchUpInside];
            [btnBuyAgain.titleLabel setFont:defFont14];
            [cell.contentView addSubview:btnBuyAgain];
            
            UIButton * btnOprate = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnOprate setFrame:CGRectMake(__MainScreen_Width-80, 22, 52, 26)];
            [btnOprate setHidden: YES];
            [btnOprate setBackgroundColor:[UIColor clearColor]];
            [btnOprate setBackgroundImage:def_ImgStretchable(@"btn_bg_blackline.png", 8, 8) forState:UIControlStateNormal];
            [btnOprate setTitle:@"点 评" forState:UIControlStateNormal];
            [btnOprate setTitleColor:color_333333 forState:UIControlStateNormal];
            [btnOprate addTarget:self action:@selector(onCommentClick:) forControlEvents:UIControlEventTouchUpInside];
            [btnOprate.titleLabel setFont:defFont14];
            [cell.contentView addSubview:btnOprate];
            
            if (m_OrderDetail.OrderStatusInt == 4 && m_OrderDetail.OrderCanComment==1) {
                
                [btnOprate setTitle:btnOprateCommon forState:UIControlStateNormal];
                [btnOprate setFrame:CGRectMake(__MainScreen_Width-77, 22, 52, 26)];
                [btnOprate setHidden:NO];
                
                [btnBuyAgain setFrame:CGRectMake(__MainScreen_Width-155, 22, 70, 26)];
            }
            
            [UICommon Common_line:CGRectMake(13, 59, def_WidthArea(13),0.5) targetView:cell.contentView backColor:color_d1d1d1];
        }
        
        float viewbgHeight = heightRowProductList+heighttop;
        viewbgHeight -= indexPath.row==0 ? 10 :0;
        UIView * viewbg=[[UIView alloc]initWithFrame:CGRectMake(12,indexPath.row==0?10:0, 592/2, viewbgHeight)];
        viewbg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dottedLineWhite_center.png"]];
        [cell.contentView addSubview:viewbg];
        [cell.contentView sendSubviewToBack:viewbg];
        
        if (indexPath.row+1 == m_OrderDetail.GoodsList.count) {
            UIImageView *bottomBg = [[UIImageView alloc] init];
            [bottomBg setFrame:CGRectMake(12,heightRowProductList+(indexPath.row==0?heighttop:0),592/2,3)];
            [bottomBg setBackgroundColor:[UIColor clearColor]];
            [bottomBg setImage:[UIImage imageNamed:@"dottedLineWhite_bottom.png"]];
            [cell.contentView addSubview:bottomBg];
        }
        
        //  --  图片
        UIImageView * productIMG = [[UIImageView alloc] initWithFrame:CGRectMake(24, heighttop+10, 75, 75)];
        [productIMG setBackgroundColor:[UIColor clearColor]];
        productIMG.layer.borderColor = color_d1d1d1.CGColor;
        productIMG.layer.borderWidth = 0.5f;
        [productIMG sd_setImageWithURL:[NSURL URLWithString:proinfo.GoodsImg]
                   placeholderImage:[UIImage imageNamed:@"placeHold_75x75"]];
        [cell.contentView addSubview:productIMG];
        
        //  --  标题
        [UICommon Common_UILabel_Add:CGRectMake(22+87, heighttop+8, 190, 40)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:2003
                                text:proinfo.GoodsTitle
                               align:-1 isBold:NO fontSize:14 tColor:color_333333];
        //  --规格
        NSString * spec = @"";
        int i=0;
        for (resMod_Mall_OrderGoodsSpec * sproperty in proinfo.GoodsSpec) {
            spec = [NSString stringWithFormat:@"%@%@%@",spec,(i>0?@"，":@""),sproperty.Value];
            i++;
        }
        spec = [NSString stringWithFormat:@"%@%@", (spec.length>0?@"规格: ":@"") ,spec];
        CGSize tsize = [spec sizeWithFont:defFont14 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
        [UICommon Common_UILabel_Add:CGRectMake(22+87, heighttop+8+40, tsize.width, 18)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:20002
                                text:spec align:-1 isBold:NO fontSize:14 tColor:color_989898];
        
        //  --  是否为代发货
        [UICommon Common_UILabel_Add:CGRectMake(22+87+tsize.width+(tsize.width>0?8:0), heighttop+8+40, proinfo.IsDropShopping==1?40:0, 18) targetView:cell.contentView bgColor:color_26A9E1 tag:2004
                                text:proinfo.IsDropShopping==1 ? @"代发货" :@""
                               align:0 isBold:NO fontSize:12 tColor:[UIColor whiteColor]];
        //  --  数量
        [UICommon Common_UILabel_Add:CGRectMake(22+87, heighttop+67, 100, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:2005
                                text:[NSString stringWithFormat:@"数量:%d",proinfo.GoodsNum]
                               align:-1 isBold:NO fontSize:14 tColor:color_989898];
        //  --  是否点评
        [UICommon Common_UILabel_Add:CGRectMake(__MainScreen_Width-155, heighttop+67, 125, 20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:2006
                                text:m_OrderDetail.OrderStatusInt==4 ? (proinfo.IsCommented==0?@"未点评":@"已点评"):@""
                               align:1 isBold:NO fontSize:13 tColor:color_333333];
        
        if (indexPath.row>0) {
            UILabel * lbl_dotline = [[UILabel alloc] initWithFrame:CGRectMake(23, 0.5, def_WidthArea(23), 0.5)];
            lbl_dotline.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
            lbl_dotline.layer.borderWidth = 0.5;
            [cell.contentView addSubview:lbl_dotline];
        }
    }
    else if(section==3){
        
        float ypoint_content = 10;
        for (int i=0; i<3; i++) {
            
            float contentRowHeight = i==0 ? 80 : 50;
            
            UIView * viewcontent=[UICommon Common_DottedCornerRadiusView:CGRectMake(12, ypoint_content, 592/2, contentRowHeight) targetView:cell.contentView tag:3000 dottedImgName:@"dottedLineWhite"];
            ypoint_content += viewcontent.frame.size.height+10;
            
            NSString * stxt_lbl1 = @"";
            NSString * stxt_lbl2 = @"";
            CGRect cgframe_1  = CGRectZero;
            CGRect cgframe_2  = CGRectZero;
            if (i==0) {
                
                resMod_AddressInfo * addressinfo = m_OrderDetail.AddressInfo;
                
                cgframe_1 = CGRectMake(12, 3, def_WidthArea(22), 30);
                cgframe_2 = CGRectMake(12, 30, def_WidthArea(22), 40);
                stxt_lbl1 = [NSString stringWithFormat:@"%@ %@",addressinfo.UserName,addressinfo.Mobile];
                stxt_lbl2 = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",addressinfo.AddressProvince,addressinfo.AddressCity,addressinfo.AddressArea,addressinfo.AddressDetail,addressinfo.ZipCode];
            }
            if (i==1) {
                cgframe_1 = CGRectMake(12, 0, 100, 50);
                cgframe_2 = CGRectMake(__MainScreen_Width-214, 0, 180, 50);
                stxt_lbl1 = @"支付方式";
                stxt_lbl2 = m_OrderDetail.PaymentTitle;// @"网上支付(支付宝)";
            }
            if (i==2) {
                cgframe_1 = CGRectMake(12, 0, 100, 50);
                cgframe_2 = CGRectMake(__MainScreen_Width-134, 0, 100, 50);
                stxt_lbl1 = @"配送方式";
                stxt_lbl2 = m_OrderDetail.ExpressageTitle;//@"全峰快递";
            }
            
            [UICommon Common_UILabel_Add:cgframe_1
                              targetView:viewcontent bgColor:[UIColor clearColor] tag:2003
                                    text:stxt_lbl1 align:-1
                                  isBold:NO fontSize:14
                                  tColor:color_333333];
            
            [UICommon Common_UILabel_Add:cgframe_2
                              targetView:viewcontent bgColor:[UIColor clearColor] tag:2003
                                    text:stxt_lbl2
                                   align: i==0 ? -1:1
                                  isBold:NO
                                fontSize:14
                                  tColor: i==0 ? color_333333:color_989898];
        }
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==2){
        NSString * PID = [NSString stringWithFormat:@"%d",[m_OrderDetail.GoodsList[indexPath.row] GoodsId]];
        [self pushNewViewController:@"MallProductDetailController" isNibPage:NO hideTabBar:YES setDelegate:NO
                      setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:PID,@"paramGoodsID", nil]];
    }
}



#pragma mark    --  api 请求 加调

-(void) goApiRequest_OrderDetail{
    NSMutableDictionary * dicParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dicParams setValue:[UserUnit userId] forKey:@"UserId"];
    [dicParams setValue:self.param_OrderID forKey:@"OrderId"];
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_MallOrderDetail class:@"resMod_CallBackMall_GoodsOrderDetail" params:dicParams  isShowLoadingAnimal:YES hudShow:@"正在加载"];\\
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingMallOrderDetail:dicParams ModelClass:@"resMod_CallBackMall_GoodsOrderDetail" showLoadingAnimal:YES hudContent:@"" delegate:self];
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_Mall_MallOrderDetail]) {
        resMod_CallBackMall_GoodsOrderDetail * backObj = [[resMod_CallBackMall_GoodsOrderDetail alloc] initWithDic:retObj];
        m_OrderDetail = backObj.ResponseData;
        
        if(m_OrderDetail){
            [btnCancle setHidden:m_OrderDetail.OrderStatusInt!=2];
        }

        [rootTableView reloadData];
        [rootTableView setHidden:NO];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_OrderCancle]) {

        [self HUDShow:@"订单取消成功"];
        [UIView animateWithDuration:2
                         animations:^{
                            
                         }
                         completion:^(BOOL finished){
                             [self hudWasHidden:HUD];
                             [self goBack:nil];
                         }];
    }
    
    if ([ApiName isEqualToString:kApiMethod_Mall_BuyAgain]) {
        [self HUDShow:@"已加入购物车" delay:0.2 dothing:YES];
    }
}

-(void)HUDdelayDo {
    [self pushNewViewController:@"ShoppingCartViewController" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"param_isFromPush", nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 消息提示

//- (void)alert:(NSString *)title msg:(NSString *)msg {
//    EC_UICustomAlertView *alertView = [[EC_UICustomAlertView alloc]initWithTitle:title message:msg cancelButtonTitle:@"Cancel" okButtonTitle:@"Ok"];
//    alertView.delegate1 = self;
//    [alertView showInView:[UIApplication sharedApplication].keyWindow];
//}


-(void)alertView:(EC_UICustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [alertView hide];
    }
    else if (buttonIndex == 1)
    {
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestShoppingMallCancelOrder:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[UserUnit userId],@"UserId",self.param_OrderID,@"OrderId",nil] ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];

        [alertView hide];
    }
}


@end
