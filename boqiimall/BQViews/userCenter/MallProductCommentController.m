//
//  MallProductCommentController.m
//  boqiimall
//
//  Created by YSW on 14-7-15.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "MallProductCommentController.h"

#define heightForCell   290

@implementation MallProductCommentController
@synthesize param_OrderID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadNavBarView];
    [self setTitle:@"商城点评"];
    [self.view setBackgroundColor:color_bodyededed];

   // [self loadNavBarView:@"商城点评"];
    
    param_OrderID = [self.receivedParams objectForKey:@"param_OrderID"];
    
    //  --  ........
    rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kNavBarViewHeight,__MainScreen_Width,kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    rootTableView.userInteractionEnabled = YES;
    rootTableView.backgroundColor = [UIColor clearColor];
    rootTableView.bounces = YES;
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    rootTableView.showsHorizontalScrollIndicator= NO;
    rootTableView.showsVerticalScrollIndicator  = YES;
    [self.view addSubview:rootTableView];
    
    //  --  ...
    [self goApiRequest_GetOrderGoodsInfo];
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


- (void) onButtonOkClick:(id) sender{
    [self goApiRequest_Comment];
}


#pragma mark    --  cell delegate

- (void) onDelegateScoreButtonClick:(UITableViewCell *) selCell{
    TableCell_MallComment * cell= (TableCell_MallComment*)selCell;
    NSIndexPath * indexpath = [rootTableView indexPathForCell:selCell];
    resMod_Mall_OrderCommentGoodsInfo * proinfo = orderCommentInfo.GoodsCommentList[indexpath.row];
    proinfo.DescriptionScore = cell.iscore_spms;
    proinfo.SatisfactionScore = cell.iscore_fwmyd;
    proinfo.SpeedScore = cell.iscore_fhsd;
}

- (void) onDelegateCommentContentChanged:(UITableViewCell*) cell{
    TableCell_MallComment * tabcell= (TableCell_MallComment*)cell;
    NSIndexPath * indexpath = [rootTableView indexPathForCell:cell];

    resMod_Mall_OrderCommentGoodsInfo * proinfo = orderCommentInfo.GoodsCommentList[indexpath.row];
    proinfo.GoodsComment = tabcell.txt_Content.text;
}

#pragma mark    --  api 请求 加调

//  --  得到订单信息
-(void) goApiRequest_GetOrderGoodsInfo{
    NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:3];
    [params setObject:[UserUnit userId] forKey:@"UserId"];
    [params setObject:param_OrderID forKey:@"OrderId"];
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_GetGoodsForOrderComment
//               class:@"resMod_CallBackMall_GoodsForOrderComment" params:params  isShowLoadingAnimal:YES hudShow:@""];
    
//    GetMyGoodsOrderComment
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMyGoodsOrderComment:params ModelClass:@"resMod_CallBackMall_GoodsForOrderComment" showLoadingAnimal:YES hudContent:@"" delegate:self];
}
//  --  提交评论
-(void) goApiRequest_Comment{
    
    NSString * stxt = [self convertGoodsInfoForComment:orderCommentInfo.GoodsCommentList];
    
    if (stxt.length>0) {
        NSMutableDictionary * params = [[NSMutableDictionary alloc] initWithCapacity:3];
        [params setObject:[UserUnit userId] forKey:@"UserId"];
        [params setObject:param_OrderID forKey:@"OrderId"];
        [params setObject:stxt forKey:@"GoodsInfo"];
        
        
//        CommitShoppingMallGoodsComment
//        [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_CommentGoods class:@"ResponseBase"
//                  params:params  isShowLoadingAnimal:NO hudShow:@"正在提交"];
        
        [[APIMethodHandle shareAPIMethodHandle]goApiRequestCommitShoppingMallGoodsComment:params ModelClass:@"ResponseBase" showLoadingAnimal:NO hudContent:@"正在提交" delegate:self];
        
    }
    else{
        [self HUDShow:@"请填写所有评论内容及评分" delay:2];
    }
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_Mall_GetGoodsForOrderComment]) {
        resMod_CallBackMall_GoodsForOrderComment * backObj = [[resMod_CallBackMall_GoodsForOrderComment alloc] initWithDic:retObj];
        orderCommentInfo = backObj.ResponseData;
        
        [rootTableView reloadData];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
    if ([ApiName isEqualToString:kApiMethod_Mall_CommentGoods]) {
        [self HUDShow:@"评论成功" delay:0.2 dothing:YES];
    }
}

-(void)HUDdelayDo {
    [self goBack:nil];
}

//  -- post到服务器的评论信息
- (NSString*) convertGoodsInfoForComment:(NSMutableArray*) paramGoodsList{
    NSString * sjsonGoodsInfo = @"";
    for(int i=0;i<paramGoodsList.count;i++){
        
        resMod_Mall_OrderCommentGoodsInfo * pGoodsInfo = paramGoodsList[i];
        pGoodsInfo.GoodsSpecId = pGoodsInfo.GoodsSpecId!=nil?pGoodsInfo.GoodsSpecId:@"";
        
        if (pGoodsInfo.GoodsComment.length==0) {
            return @"";
        }
        if (pGoodsInfo.DescriptionScore==0 || pGoodsInfo.SatisfactionScore==0 || pGoodsInfo.SpeedScore==0 ) {
            return @"";
        }
        
        sjsonGoodsInfo = [NSString stringWithFormat:@"%@%@{\"GoodsId\": %d,\"GoodsSpecId\": \"%@\",\"GoodsPackageId\": %d,\"GoodsComment\": \"%@\",\"DescriptionScore\": %d, \"SatisfactionScore\": %d,\"SpeedScore\": %d}",sjsonGoodsInfo,sjsonGoodsInfo.length>0?@",":@"",pGoodsInfo.GoodsId,pGoodsInfo.GoodsSpecId,pGoodsInfo.GoodsPackageId,pGoodsInfo.GoodsComment,pGoodsInfo.DescriptionScore,pGoodsInfo.SatisfactionScore,pGoodsInfo.SpeedScore];
    }
    return [NSString stringWithFormat:@"[%@]",sjsonGoodsInfo];
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==0 ? orderCommentInfo.GoodsCommentList.count :1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightForCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * IdentifierCell = @"CommentProductListCell";
//    NSString * IdentifierCell = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
    
    if (indexPath.section==0) {
    
        TableCell_MallComment *cell = (TableCell_MallComment*)[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
        if ( cell == nil ) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TableCell_MallComment" owner:self options:nil];
            for(id oneObject in nib) {
                if([oneObject isKindOfClass:[TableCell_MallComment class]]) {
                    cell = (TableCell_MallComment *)[nib objectAtIndex:0];
                    cell.commentDelegate = self;
                    cell.userInteractionEnabled = YES;
                    
                    UIView * viewcontent=[UICommon Common_DottedCornerRadiusView:CGRectMake(12, 12, 592/2, heightForCell-13) targetView:cell.contentView tag:1000 dottedImgName:@"dottedLineWhite"];
                    [cell.contentView sendSubviewToBack:viewcontent];
                }
            }
        }
        
        if (orderCommentInfo.GoodsCommentList>0) {
            resMod_Mall_OrderCommentGoodsInfo * productinfo = orderCommentInfo.GoodsCommentList[indexPath.row];
            [cell.productIMG sd_setImageWithURL:[NSURL URLWithString:productinfo.GoodsImg]
                               placeholderImage:[UIImage imageNamed:@"placeHold_75x75.png"]];
            [cell.lbl_ProductTitle setText:productinfo.GoodsTitle];
            [cell.lbl_ProductPrice setText:[self convertPrice:productinfo.GoodsPrice]];
            [cell.lbl_ProductMarketPrice setText:[self convertPrice:productinfo.GoodsOriPrice]];
            [cell.lbl_score setText:[NSString stringWithFormat:@"%.1f",productinfo.GoodsScore]];
            //  --
            [cell setScore:productinfo.GoodsScore];
            [cell.txt_Content setText:productinfo.GoodsComment];
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        UIButton * btn_ok = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_ok setFrame:CGRectMake(12, 12, def_WidthArea(12), 38)];
        [btn_ok setBackgroundColor:color_fc4a00];
        [btn_ok setTitle:@"提交评论" forState:UIControlStateNormal];
        [btn_ok.titleLabel setFont:defFont16];
        btn_ok.layer.cornerRadius = 3.0f;
        [btn_ok addTarget:self action:@selector(onButtonOkClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btn_ok];
        
        [UICommon Common_line:CGRectMake(0, 68, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
        CGSize tsize = [orderCommentInfo.CommentTips sizeWithFont:defFont13 constrainedToSize:CGSizeMake(def_WidthArea(12), MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        [UICommon Common_UILabel_Add:CGRectMake(12, 68, def_WidthArea(12), tsize.height+20)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:2001
                                text:orderCommentInfo.CommentTips
                               align:-1 isBold:NO fontSize:13 tColor:color_989898];
        
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
