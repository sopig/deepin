//
//  MallProductSpecController.m
//  BoqiiLife
//
//  Created by YSW on 14-6-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MallProductSpecController.h"
#import "resMod_Mall_GoodsForApiParams.h"
#import "OfflineShoppingCart.h"
#import "OfflineGoods.h"

#define heightForTop    100
#define specRowHeight   50
#define heightBottomNumAndButton    170
//#define spectype        @"尺寸:XS,S,M,L|颜色:黑色,白色(贵族白),蓝色,橙色(经典波奇橙),红色(大红色的哦),绿色,黄色"


@implementation EC_ButtonForProSpec
@synthesize isCheckSpec,isNotExistSpec;
@synthesize propertyID,propertyName,specID,specName;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.isCheckSpec = NO;
    }
    return self;
}
@end


//  ---------
@implementation MallProductSpecController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        m_productSpecs = [[NSMutableArray alloc] initWithCapacity:0];
        m_productSpecGroup = [[NSMutableArray alloc] initWithCapacity:0];
        dic_allSpecBtns = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:color_bodyededed];
    productInfo = [self.receivedParams objectForKey:@"param_productinfo"];
    operType = [[self.receivedParams objectForKey:@"param_opertype"] isEqualToString:@"1"]?1:0;
    
    [self setTitle:operType==1 ? @"加入购物车":@"立即购买"];
    [self goApiRequest_ProductSpec];
}

#pragma mark    --  event

- (void)LoginSuccessPushViewController:(NSString *)m_str param:(id)m_param{
    if ([m_str isEqualToString:@"submitOrder"]) {
        [self onButtonOKClick:nil];
    }
}

- (void)onButtonOKClick:(id) sender{
    
    int txtNum = [txt_productNum.text intValue];
    if (txtNum<=0) {
        [self HUDShow:@"一件起售" delay:2];
        return;
    }
    
    //  --  有无规格 情况
    if ((m_productSpecs.count>0 && checkSpecGroup!=nil) || m_productSpecs.count==0) {
        
        BOOL allowBuy = [self checkTicketLimitNumber:[txt_productNum.text intValue]];
        
        if (allowBuy) {
            
            if ([UserUnit isUserLogin])
            {
                if (operType==1) {
                    NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
                    [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
                    [apiParams setObject:[NSString stringWithFormat:@"%d",productInfo.GoodsId] forKey:@"GoodsId"];
                    [apiParams setObject:txt_productNum.text  forKey:@"GoodsNum"];
                    [apiParams setObject:checkSpecGroup!=nil&&checkSpecGroup.SpecId!=nil ? checkSpecGroup.SpecId:@"" forKey:@"GoodsSpecId"];
                    [apiParams setObject:[NSString stringWithFormat:@"%d",productInfo.GoodsType] forKey:@"GoodsType"];
                    [self goApiRequest_AddCart:apiParams];
                }
                else{
                    resMod_Mall_GoodsForApiParams * goodsinfo = [[resMod_Mall_GoodsForApiParams alloc] init];
                    goodsinfo.GoodsId = productInfo.GoodsId;
                    goodsinfo.GoodsNum = [txt_productNum.text intValue];
                    goodsinfo.GoodsType = productInfo.GoodsType;
                    goodsinfo.GoodsSpecId = checkSpecGroup!=nil&&checkSpecGroup.SpecId!=nil ? checkSpecGroup.SpecId :@"";
                    [self pushNewViewController:@"MallOrderSubmitController" isNibPage:NO hideTabBar:YES setDelegate:NO
                                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[[NSMutableArray alloc] initWithObjects:goodsinfo, nil],@"param_proinfo", nil]];
                }
            }
            else {
                if (operType ==1) {
                    NSString *goodsSpecialIdStr =(checkSpecGroup!=nil&&checkSpecGroup.SpecId!=nil ? checkSpecGroup.SpecId:@"0");
                    NSInteger GoodsNum = [txt_productNum.text intValue];
                    NSDate *nowDate = [NSDate date];
                    OfflineGoods *item = [[OfflineGoods alloc] init];
                    item.selected = 1;
                    item.goodsID = productInfo.GoodsId;
                    item.goodsSpecId = goodsSpecialIdStr;
                    item.goodsType = productInfo.GoodsType;
                    item.totalNum = GoodsNum;
                    item.addedDate = nowDate;
                    item.changeBuyId = 0;
                    item.actionId = 0;
                    
                    if ([OfflineShoppingCart findByGoodsId:item.goodsID specialId:item.goodsSpecId])
                    {
                        [OfflineShoppingCart updateGoods:item];
                    }
                    else {
                        [OfflineShoppingCart insertGoods:item];
                    }
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else {
                    
                    if (![UserUnit isUserLogin]) {
                        [self goLogin:@"submitOrder" param:nil delegate:self];
                        return;
                    }
                    
                    resMod_Mall_GoodsForApiParams * goodsinfo = [[resMod_Mall_GoodsForApiParams alloc] init];
                    goodsinfo.GoodsId = productInfo.GoodsId;
                    goodsinfo.GoodsNum = [txt_productNum.text intValue];
                    goodsinfo.GoodsType = productInfo.GoodsType;
                    goodsinfo.GoodsSpecId = checkSpecGroup!=nil&&checkSpecGroup.SpecId!=nil ? checkSpecGroup.SpecId :@"";
                    [self pushNewViewController:@"MallOrderSubmitController" isNibPage:NO hideTabBar:YES setDelegate:NO
                                  setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[[NSMutableArray alloc] initWithObjects:goodsinfo, nil],@"param_proinfo", nil]];
                }
            }
            
//            if (![UserUnit isUserLogin]) {
//                [self goLogin:@"submitOrder" param:nil delegate:self];
//                return;
//            }
//            if (operType==1) {
//                NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
//                [apiParams setObject:[UserUnit userId] forKey:@"UserId"];
//                [apiParams setObject:[NSString stringWithFormat:@"%d",productInfo.GoodsId] forKey:@"GoodsId"];
//                [apiParams setObject:txt_productNum.text  forKey:@"GoodsNum"];
//                [apiParams setObject:checkSpecGroup!=nil&&checkSpecGroup.SpecId!=nil ? checkSpecGroup.SpecId:@"" forKey:@"GoodsSpecId"];
//                [apiParams setObject:[NSString stringWithFormat:@"%d",productInfo.GoodsType] forKey:@"GoodsType"];
//                [self goApiRequest_AddCart:apiParams];
//            }
//            else{
//                resMod_Mall_GoodsForApiParams * goodsinfo = [[resMod_Mall_GoodsForApiParams alloc] init];
//                goodsinfo.GoodsId = productInfo.GoodsId;
//                goodsinfo.GoodsNum = [txt_productNum.text intValue];
//                goodsinfo.GoodsType = productInfo.GoodsType;
//                goodsinfo.GoodsSpecId = checkSpecGroup!=nil&&checkSpecGroup.SpecId!=nil ? checkSpecGroup.SpecId :@"";
//                
//                [self pushNewViewController:@"MallOrderSubmitController" isNibPage:NO hideTabBar:YES setDelegate:NO
//                              setPushParams:[[NSMutableDictionary alloc] initWithObjectsAndKeys:[[NSMutableArray alloc] initWithObjects:goodsinfo, nil],@"param_proinfo", nil]];
//                
//            }
        }
    }
    else{
        [self HUDShow:@"请选择规格信息" delay:2];
    }
}


- (void)onProductNumClick:(id) sender{
    UIButton * btnTmp = (UIButton *)sender;
    int iNum= [txt_productNum.text intValue];
    switch (btnTmp.tag) {
        case 597:{
            if (iNum==1||iNum<1) {
                txt_productNum.text = @"1";
            }else{
                txt_productNum.text = [NSString stringWithFormat:@"%d",--iNum];
            }
        }
            break;
        case 598: {
            ++iNum;
            [self checkTicketLimitNumber:iNum];
        }
            break;
            
        default:
            break;
    }
    
    
    //  -- 取限购数量
    int limitProNum = checkSpecGroup!=nil ? checkSpecGroup.SpecLimit : productInfo.GoodsLimitNum;
    if (iNum<2) {
        [btn_discount setBackgroundImage:[UIImage imageNamed:@"icon_reduce_normal.png"] forState:UIControlStateNormal];
        [btn_sum setBackgroundImage:[UIImage imageNamed:@"icon_add_highlight.png"] forState:UIControlStateNormal];
    }
    else if(limitProNum==0||limitProNum>iNum){
        [btn_discount setBackgroundImage:[UIImage imageNamed:@"icon_reduce_highlight.png"]forState:UIControlStateNormal];
        [btn_sum setBackgroundImage:[UIImage imageNamed:@"icon_add_highlight.png"] forState:UIControlStateNormal];
    }
    else if(limitProNum==iNum){
        [btn_sum setBackgroundImage:[UIImage imageNamed:@"icon_add_normal.png"] forState:UIControlStateNormal];
    }
}


- (BOOL) checkTicketLimitNumber:(int) proNum{
    
    //  -- 取限购数量
    int limitProNum = checkSpecGroup!=nil ? checkSpecGroup.SpecLimit : productInfo.GoodsLimitNum;
    //  -- 取库存
    int SotckNum = checkSpecGroup!=nil ? checkSpecGroup.SpecSotck : productInfo.GoodsStockNum;

    limitProNum = limitProNum==0?999:limitProNum;
    if ( limitProNum>0 && proNum>limitProNum) {
        [self HUDShow:[NSString stringWithFormat:@"限购 %d 件",limitProNum] delay:2];
        txt_productNum.text = [NSString stringWithFormat:@"%d",limitProNum];
        return NO;
    }
    else if(proNum>SotckNum){
        [self HUDShow:@"库存不足" delay:2];
        txt_productNum.text = [NSString stringWithFormat:@"%d",checkSpecGroup.SpecSotck];
        return NO;
    }
    else{
        txt_productNum.text = [NSString stringWithFormat:@"%d",proNum];
        return YES;
    }
}

//  --  规格选择
- (void)onProductSpecCheck:(id) sender{
    
    EC_ButtonForProSpec * btnSpecSelect = (EC_ButtonForProSpec*)sender;
    
    if (btnSpecSelect.isNotExistSpec) {
        return;
    }
    
    int selSpecCount = 1;
    checkSpecGroup = nil;
    
    
    for (NSString * dickeys in dic_allSpecBtns.allKeys) {
        
        for (EC_ButtonForProSpec * btnCurrent in [dic_allSpecBtns objectForKey:dickeys]) {
            
            //  --  本组：属性规格按钮状态
            if ([dickeys isEqualToString:btnSpecSelect.propertyName]) {
                
                btnCurrent.isNotExistSpec = NO;
                [btnCurrent setBackgroundColor:[UIColor whiteColor]];
                
                //  -- 当属性列表只有一种时  保存选中的组合值
                if (m_productSpecs.count==1) {
                    for (resMod_Mall_GoodsSpecGroups * specgroup in m_productSpecGroup) {
                        if ([specgroup.SpecProperties isEqualToString:btnSpecSelect.specName]) {
                            checkSpecGroup = specgroup;
                            int limit = checkSpecGroup.SpecLimit==0 ? 999:checkSpecGroup.SpecLimit;
                            [lbl_LimitNum setText:[NSString stringWithFormat:@"限购%d件",limit]];
                            [lbl_StockNum setText:[NSString stringWithFormat:@"库存%d件",checkSpecGroup.SpecSotck]];
                        }
                    }
                }
                
                if ([btnSpecSelect.specName isEqualToString:btnCurrent.specName]){
                    btnCurrent.isCheckSpec = YES;
                    btnCurrent.layer.borderColor = color_fc4a00.CGColor;
                    [btnSpecSelect setTitleColor:color_fc4a00 forState:UIControlStateNormal];
                }
                else{
                    btnCurrent.isCheckSpec = NO;
                    btnCurrent.layer.borderColor = color_d1d1d1.CGColor;
                    [btnCurrent setTitleColor:color_4e4e4e forState:UIControlStateNormal];
                }
            }
            //  --  其它组：属性规格按钮状态
            else{
                
                //  -- 找按钮对应的规格组合集
                NSMutableArray * specgroupBySelectBtn = [[NSMutableArray alloc] initWithCapacity:0];
                for (resMod_Mall_GoodsSpecGroups * specgroup in m_productSpecGroup) {
                    NSArray * arrspec = [specgroup.SpecProperties componentsSeparatedByString:@","];
                    if ([arrspec containsObject:btnSpecSelect.specName]) {
                        [specgroupBySelectBtn addObject:specgroup];
                    }
                }
                
                //  -- 看是否存在
                BOOL    bIsNotExist = YES;
                for (resMod_Mall_GoodsSpecGroups * specgroup in specgroupBySelectBtn) {
                    NSArray * arrspec = [specgroup.SpecProperties componentsSeparatedByString:@","];
                    if ([arrspec containsObject:btnCurrent.specName]) {
                        bIsNotExist = NO;
                        
                        //  --保存选中的组合值
                        if (!bIsNotExist && btnCurrent.isCheckSpec) {
                            selSpecCount++;
                            if (selSpecCount == m_productSpecs.count) {
                                checkSpecGroup = specgroup;
                                int limit = checkSpecGroup.SpecLimit==0 ? 999:checkSpecGroup.SpecLimit;
                                [lbl_LimitNum setText:[NSString stringWithFormat:@"限购%d件",limit]];
                                [lbl_StockNum setText:[NSString stringWithFormat:@"库存%d件",checkSpecGroup.SpecSotck]];
                            }
                        }
                    }
                }
                
                if (bIsNotExist) {
                    btnCurrent.isCheckSpec = NO;
                    btnCurrent.isNotExistSpec = YES;
                    btnCurrent.layer.borderColor = color_d1d1d1.CGColor;
                    [btnCurrent setBackgroundColor: [UIColor convertHexToRGB:@"E8E8E8"]];
                    [btnCurrent setTitleColor:[UIColor convertHexToRGB:@"d5d5d5"] forState:UIControlStateNormal];
                }
                else{
                    btnCurrent.isNotExistSpec = NO;
                    btnCurrent.layer.borderColor = btnCurrent.isCheckSpec?color_fc4a00.CGColor:color_d1d1d1.CGColor;
                    [btnCurrent setBackgroundColor: [UIColor whiteColor]];
                    [btnCurrent setTitleColor:color_4e4e4e forState:UIControlStateNormal];
                }
            }
        }
    }
}


#pragma mark    --  load ui

- (void)loadView_ContentUI{
    scrollview_Root = [[EC_UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    [scrollview_Root setBackgroundColor:[UIColor clearColor]];
    [scrollview_Root setDelegate:self];
    [scrollview_Root setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:scrollview_Root];
    
    TopProductInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightForTop)];
    [TopProductInfo setBackgroundColor:[UIColor clearColor]];
    [scrollview_Root addSubview:TopProductInfo];
    
    [self loadView_proInfo];
    [self loadView_ProductSpec];
    [self loadView_proNum];
    
    [scrollview_Root setContentSize:CGSizeMake(__MainScreen_Width, heightForTop+fSpecHeight+heightBottomNumAndButton)];
    
    [UICommon Common_line:CGRectMake(0, scrollview_Root.contentSize.height-60, __MainScreen_Width, 0.5)
               targetView:scrollview_Root backColor:color_d1d1d1];
    UIButton * btn_ok = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_ok setFrame:CGRectMake(10, scrollview_Root.contentSize.height-50, def_WidthArea(10), 40)];
    [btn_ok setBackgroundColor:color_fc4a00];
    btn_ok.layer.cornerRadius = 2.0;
    [btn_ok setTitle: operType==1 ? @"确定添加" : @"确认购买" forState:UIControlStateNormal];
    [btn_ok addTarget:self action:@selector(onButtonOKClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollview_Root addSubview:btn_ok];
}
//  --  商品信息
- (void)loadView_proInfo{
    
    NSArray * arrimg = [productInfo.GoodsImgList componentsSeparatedByString:@","];
    UIImageView * proImg = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 75, 75)];
    [proImg setBackgroundColor:[UIColor clearColor]];
    proImg.layer.borderColor = color_d1d1d1.CGColor;
    proImg.layer.borderWidth = 0.5f;
    [proImg sd_setImageWithURL:[NSURL URLWithString: (arrimg.count>0 ? arrimg[0]:@"")]
              placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
    [TopProductInfo addSubview:proImg];
    
    [UICommon Common_UILabel_Add:CGRectMake(100, 10, __MainScreen_Width-100, 40)
                      targetView:TopProductInfo bgColor:[UIColor clearColor] tag:1212
                            text:productInfo.GoodsTitle
                           align:-1 isBold:NO fontSize:14 tColor:color_333333];
    
    [UICommon Common_UILabel_Add:CGRectMake(100, 66, 100, 20)
                      targetView:TopProductInfo bgColor:[UIColor clearColor] tag:1213
                            text:[self convertPrice:productInfo.GoodsPrice]
                           align:-1 isBold:NO fontSize:18 tColor:color_fc4a00];
    
    NSString * marktPrice = [self convertPrice:productInfo.GoodsOriPrice];
    [UICommon Common_UILabel_Add:CGRectMake(200, 68, 100, 20)
                      targetView:TopProductInfo bgColor:[UIColor clearColor] tag:1214
                            text:marktPrice
                           align:-1 isBold:NO fontSize:13 tColor:color_b3b3b3];
    
    CGSize tsize = [marktPrice sizeWithFont:defFont13 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    [UICommon Common_line:CGRectMake(197, 78, tsize.width+6, 1)
               targetView:TopProductInfo backColor:color_b3b3b3];
    
    [UICommon Common_line:CGRectMake(0, heightForTop-0.5, __MainScreen_Width, 0.5)
               targetView:TopProductInfo backColor:color_d1d1d1];
    
}

//  --  规格信息
- (void)loadView_ProductSpec{
    
    for (resMod_Mall_GoodsSpecProperties * spec in m_productSpecs) {
        
        int   currentLine=0;        //规格属性当前行数.
        float xpoint = 10;          //按钮xpoint.
        float ypoint = heightForTop+25;
        float paddingX = 10;        //按钮左边距.
        float btnDefaultWidth = 130/2;  //按钮默认宽
        float btnwidth;
        
        UIView * rowview_spec = [[UIView alloc] init];
        [rowview_spec setFrame:CGRectMake(0, heightForTop+fSpecHeight, __MainScreen_Width,specRowHeight+25)];
        [rowview_spec setBackgroundColor:[UIColor clearColor]];
        [scrollview_Root addSubview:rowview_spec];
        
        [UICommon Common_UILabel_Add:CGRectMake(10, 7, 100, 20)
                          targetView:rowview_spec bgColor:[UIColor clearColor] tag:1214
                                text:spec.PropertyName
                               align:-1 isBold:YES fontSize:15 tColor:color_333333];
        
        
        NSMutableArray * specBtnsByType = [[NSMutableArray alloc] initWithCapacity:0];
        for (resMod_Mall_GoodsSpecPropertyInfo * specinfo in spec.Properties) {
            
            //根据text算出动态的宽度
            CGSize tSize = [specinfo.Name sizeWithFont: defFont15 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
            
            btnwidth = btnDefaultWidth;
            //  --  如果字的宽度超过默认按钮宽度，那么自适应宽度
            if (tSize.width > btnDefaultWidth) {
                btnwidth = tSize.width+10;
            }
            //  --  如果字的宽度超过一定宽度，那么也自适应宽度，不然会太拥挤
            if (tSize.width > btnDefaultWidth-10) {
                btnwidth = tSize.width+10;
            }
            
            if (xpoint+btnwidth>def_WidthArea(10)) {//如果(下个按钮)x+width大于frame的宽度那么换到下行
                xpoint=10;
                ypoint += specRowHeight;
                currentLine++;//行数加1
            }
            else{
                ypoint = 25 + currentLine*specRowHeight;
            }
            
            EC_ButtonForProSpec * btnSpec = [EC_ButtonForProSpec buttonWithType:UIButtonTypeCustom];
            [btnSpec setFrame:CGRectMake(xpoint, ypoint+10, btnwidth, specRowHeight-15)];
            [btnSpec setBackgroundColor:[UIColor whiteColor]];
            [btnSpec setTitle:specinfo.Name forState:UIControlStateNormal];
            [btnSpec setTitleColor:color_4e4e4e forState:UIControlStateNormal];
            [btnSpec.titleLabel setFont:defFont14];
            btnSpec.layer.borderColor = color_d1d1d1.CGColor;
            btnSpec.layer.borderWidth = 0.5f;
            btnSpec.propertyID = spec.PropertyID;
            btnSpec.propertyName = spec.PropertyName;
            btnSpec.specID    = specinfo.Id;
            btnSpec.specName    = specinfo.Name;
            [btnSpec addTarget:self action:@selector(onProductSpecCheck:) forControlEvents:UIControlEventTouchUpInside];
            [rowview_spec addSubview:btnSpec];
            
            [specBtnsByType addObject:btnSpec];
            xpoint += btnwidth+paddingX;
        }
        
        //  -- 按分类记住规格 button
        [dic_allSpecBtns setObject:specBtnsByType forKey:spec.PropertyName];
        
        [rowview_spec setFrame:CGRectMake(0, rowview_spec.frame.origin.y, __MainScreen_Width, ypoint+specRowHeight+6)];

        
        //  -- 下面的虚线
        UILabel * dotLine = [[UILabel alloc] init];
        [dotLine setFrame:CGRectMake(10, rowview_spec.frame.size.height-0.5, def_WidthArea(10), 0.5)];
        [dotLine setBackgroundColor:[UIColor clearColor]];
        dotLine.layer.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted_line.png"]].CGColor;
        dotLine.layer.borderWidth = 0.5;
        [rowview_spec addSubview:dotLine];
        
        fSpecHeight += rowview_spec.frame.size.height;
    }
}

//  --  数量
- (void)loadView_proNum {
    UIView * numview = [[UIView alloc] init];
    [numview setFrame:CGRectMake(0, heightForTop+fSpecHeight, __MainScreen_Width,specRowHeight+25)];
    [numview setBackgroundColor:[UIColor clearColor]];
    [scrollview_Root addSubview:numview];
    
    [UICommon Common_UILabel_Add:CGRectMake(10, 6, 100, 20)
                      targetView:numview bgColor:[UIColor clearColor] tag:1114
                            text:@"数量"
                           align:-1 isBold:YES fontSize:15 tColor:color_333333];

    //--数量 : 减
    btn_discount = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 40, 40)];
    [btn_discount setBackgroundColor:[UIColor whiteColor]];
    [btn_discount setTag:597];
    [btn_discount setBackgroundImage:[UIImage imageNamed:@"icon_reduce_normal"] forState:UIControlStateNormal];
    [btn_discount setBackgroundImage:[UIImage imageNamed:@"icon_reduce_sel"] forState:UIControlStateHighlighted];
    [btn_discount addTarget:self action:@selector(onProductNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [numview addSubview:btn_discount];
    
    //--数量 : 加
    btn_sum = [[UIButton alloc] initWithFrame:CGRectMake(140, 30, 40, 40)];
    [btn_sum setBackgroundColor:[UIColor whiteColor]];
    [btn_sum setTag:598];
    [btn_sum setBackgroundImage:[UIImage imageNamed:@"icon_add_highlight"] forState:UIControlStateNormal];
    [btn_sum setBackgroundImage:[UIImage imageNamed:@"icon_add_sel"] forState:UIControlStateHighlighted];
    [btn_sum addTarget:self action:@selector(onProductNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [numview addSubview:btn_sum];
    
    //--
    txt_productNum = [[UITextField alloc] initWithFrame:CGRectMake(60, 30, 70, 40)];
    [txt_productNum setTag:8989];
    [txt_productNum setDelegate:self];
    [txt_productNum setBackgroundColor:[UIColor whiteColor]];
    [txt_productNum setTextAlignment:NSTextAlignmentCenter];
    [txt_productNum setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    txt_productNum.keyboardType=UIKeyboardTypeNumberPad;
    txt_productNum.text = @"1";
    txt_productNum.layer.borderColor = color_d1d1d1.CGColor;
    txt_productNum.layer.borderWidth = 0.5f;
    [numview addSubview:txt_productNum];
    
    //  --.....
    lbl_LimitNum = [[UILabel alloc] init];
    [lbl_LimitNum setFrame:CGRectMake(btn_sum.frame.origin.x+btn_sum.frame.size.width+10, 30, 120, 20)];
    [lbl_LimitNum setBackgroundColor:[UIColor clearColor]];
    [lbl_LimitNum setText:[NSString stringWithFormat:@"限购%d件",productInfo.GoodsLimitNum]];
    [lbl_LimitNum setTextAlignment:NSTextAlignmentLeft];
    [lbl_LimitNum setFont:defFont14];
    [lbl_LimitNum setTextColor:color_fc4a00];
    [numview addSubview:lbl_LimitNum];
    
    //  --.....
    lbl_StockNum = [[UILabel alloc] init];
    [lbl_StockNum setFrame:CGRectMake(btn_sum.frame.origin.x+btn_sum.frame.size.width+10, 50, 120, 20)];
    [lbl_StockNum setBackgroundColor:[UIColor clearColor]];
    [lbl_StockNum setText:[NSString stringWithFormat:@"库存%d件",productInfo.GoodsStockNum]];
    [lbl_StockNum setTextAlignment:NSTextAlignmentLeft];
    [lbl_StockNum setFont:defFont14];
    [lbl_StockNum setTextColor:color_333333];
    [numview addSubview:lbl_StockNum];
}


#pragma mark    --  api 请 求 & 回 调.

-(void)goApiRequest_AddCart:(NSMutableDictionary*) apiParams{
    
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_AddCart class:@"ResponseBase"
//              params:apiParams  isShowLoadingAnimal:NO  hudShow:@"正在添加"];
//    AddToShoppingCart
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestAddToShoppingCart:apiParams ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在添加" delegate:self];
}

-(void)goApiRequest_ProductSpec{
    
    if (productInfo!=nil) {
        NSMutableDictionary * apiParams=[[NSMutableDictionary alloc] init];
        [apiParams setObject:[NSString stringWithFormat:@"%d",productInfo.GoodsId] forKey:@"GoodsId"];
        
//        [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_GoodsSpec class:@"resMod_CallBackMall_GoodsSpec"
//                  params:apiParams  isShowLoadingAnimal:NO hudShow:@"正在加载"];
//        GetShoppingMallGoodsSpec
        
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingMallGoodsSpec:apiParams ModelClass:@"resMod_CallBackMall_GoodsSpec" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
    }
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_Mall_GoodsSpec]) {
        resMod_CallBackMall_GoodsSpec * backObj = [[resMod_CallBackMall_GoodsSpec alloc] initWithDic:retObj];
        resMod_Mall_GoodsSpecList * speclist = backObj.ResponseData;
        
        [m_productSpecs addObjectsFromArray:speclist.GoodsProperties];
        [m_productSpecGroup addObjectsFromArray:speclist.GoodsSpecs];
        [self loadView_ContentUI];
        [self hudWasHidden:HUD];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_AddCart]) {
        [UIView animateWithDuration:2
                         animations:^{
                             [self HUDShow:@"添加购物车成功" delay:2];
                         }
                         completion:^(BOOL finished){
                             
                             [self.navigationController popViewControllerAnimated:YES];
                         }];
    }
}

#pragma mark - TextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if (textField.tag==8989) {
        [self checkTicketLimitNumber:[txt_productNum.text intValue]];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if (textField.tag==8989) {
        [self checkTicketLimitNumber:[txt_productNum.text intValue]];
    }
    return YES;
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"%@,%d,%d",string,range.location,range.length);
//    return YES;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




