//
//  TicketCommentListVC.m
//  boqiimall
//
//  Created by 张正超 on 14-7-16.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "TicketCommentListVC.h"
#import "resMod_TicketInfo.h"
#import "BQTicketCommentTableViewCell.h"
//#import "BQTicketCommentListCell.h"
#import "PullToRefreshTableView.h"
#import "BQMerchantCommentListCell.h"
#import "resMod_Life_ticketCommentDetail.h" //生活馆服务券点评返回model
#import "resMod_Life_GetTicketCommentList.h" //生活馆服务券列表返回model

#define Number 6   //数据量


@interface TicketCommentListVC ()
{
    resMod_TicketInfo *modelTicketInfo;
    UITableView *_tableview;
    resMod_Life_ticketCommentDetail *markModel ;
    int StartIndex;
    int count;
    NSMutableArray *commentListMarkArray;
    UIButton *btn_addmore;
    
  
#if 0
    CGSize _contentHeight;
#endif
}

@end


@implementation TicketCommentListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"本单点评";
    self.view.backgroundColor = color_bodyededed;

    modelTicketInfo =  [self.receivedParams objectForKey:@"mod_TicketInfo"];

    StartIndex = 0;
    count = 0;
    commentListMarkArray = [NSMutableArray array];

    UIView * HeadView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, 60)];
    [HeadView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:HeadView];
    
    NSString* ticketPrice = [NSString stringWithFormat:@"%@元",[self.receivedParams objectForKey:@"TicketPrice"]];
    NSString* ticketOriPrice = [self.receivedParams objectForKey:@"TicketOriPrice"];
    NSString* TicketSale = [self.receivedParams objectForKey:@"TicketSale"];
    
    CGSize size_xj = [ticketPrice sizeWithFont:defFont(YES, 23) constrainedToSize:CGSizeMake(MAXFLOAT, 25)];
    CGSize size_yj = [ticketOriPrice sizeWithFont:defFont14    constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    //--现价.
    [UICommon Common_UILabel_Add:CGRectMake(12, 18, 100, 25) targetView:HeadView
                         bgColor:[UIColor clearColor] tag:1001
                            text:ticketPrice
                           align:-1 isBold:YES fontSize:20 tColor:color_fc4a00];
    //--原价.
    [UICommon Common_UILabel_Add:CGRectMake(size_xj.width+10, 22, size_yj.width, 20) targetView:HeadView
                         bgColor:[UIColor clearColor] tag:1002
                            text:ticketOriPrice
                           align:-1 isBold:NO fontSize:14 tColor:color_b3b3b3];
    [UICommon Common_line:CGRectMake(size_xj.width+10, 32, size_yj.width+2, 1) targetView:HeadView backColor:color_b3b3b3];
    
    //--折扣.
    [UICommon Common_UILabel_Add:CGRectMake(size_xj.width+10+size_yj.width+7, 22, 60, 20) targetView:HeadView
                         bgColor:[UIColor clearColor] tag:1003
                            text:TicketSale
                           align:-1 isBold:NO fontSize:15 tColor:color_fc4a00];

    
    UIButton *buyButton = [[UIButton alloc] initWithFrame:CGRectMake(__MainScreen_Width-90, 10, 80, 40)];
    buyButton.tag = 19040;
    [buyButton setTitle:modelTicketInfo.TicketRemain<0 ? @"已过期":@"立即购买" forState:UIControlStateNormal];
    [buyButton setBackgroundColor: modelTicketInfo.TicketRemain<0 ? color_b3b3b3 : color_fc4a00];
    [buyButton.titleLabel setFont: defFont(YES, 15)];
    buyButton.layer.cornerRadius = 3.0f;
    [buyButton addTarget:self action:@selector(onBuyClick:) forControlEvents:UIControlEventTouchUpInside];
    [HeadView addSubview:buyButton];
    
    [UICommon Common_line:CGRectMake(0, 59, __MainScreen_Width, 0.5) targetView:HeadView backColor:color_d1d1d1];
    
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 60+kNavBarViewHeight, self.view.frame.size.width,kMainScreenHeight-66 - kNavBarViewHeight) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
    [self goApiRequestForCommentDetail];
    
    btn_addmore = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_addmore setFrame:CGRectMake(0, 10, __MainScreen_Width, 40)];
    [btn_addmore setBackgroundColor:[UIColor clearColor]];
    [btn_addmore setTitle:@"点击查看更多" forState:UIControlStateNormal];
    [btn_addmore setTitleColor:color_575757 forState:UIControlStateNormal];
    [btn_addmore setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [btn_addmore.titleLabel setFont:defFont16];
    [btn_addmore setImage:[UIImage imageNamed:@"info_icon_open.png"] forState:UIControlStateNormal];
    [btn_addmore addTarget:self action:@selector(onAddMoreClick:) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)loadNavBarView
//{
//    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"本单点评";
//    [bgView addSubview:titleLabel];
//    [self.navBarView addSubview:bgView];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#define mark - 购买按钮点击事件
- (void) onBuyClick:(id) sender{
    UIButton * btnTmp = (UIButton*)sender;
    if (btnTmp.tag==19040) {
        if (modelTicketInfo.TicketRemain<0) {
            return;
        }
        if (![UserUnit isUserLogin]) {
            [self goLogin:@"go_ordersubmitcontroller" param:nil delegate:self];
            return;
        }
        else{
            [self goOrderSubmitController];
        }
//        NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithObjectsAndKeys: modelTicketInfo,@"orderNeed", nil];
//        [self pushNewViewController:@"OrderSubmitController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
    }
}

- (void) goOrderSubmitController{
    NSMutableDictionary * pms = [[NSMutableDictionary alloc] initWithObjectsAndKeys: modelTicketInfo,@"orderNeed", nil];
    [self pushNewViewController:@"OrderSubmitController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:pms];
}

- (void)LoginSuccessPushViewController:(NSString *)m_str param:(id)m_param{
    if ([m_str isEqualToString:@"go_ordersubmitcontroller"]) {
        [self goOrderSubmitController];
    }
}



#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
         return commentListMarkArray.count + 1;
    }
    else{
        return 1;
    }
   
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* CellID = [NSString stringWithFormat:@"Cell%d%d", indexPath.section, indexPath.row];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            BQTicketCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
            if (cell == nil) {
                cell = [[BQTicketCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //虚线      //    dotted_line@2x
            }
            
            cell.professionScoreIndicator.scoreValue = markModel.ProfessionalScore;
            cell.professionScoreLabel.text = [NSString stringWithFormat:@"%.1f",markModel.ProfessionalScore];
            
            cell.envScoreIndicator.scoreValue = markModel.EnvironmentScore;
            cell.envScoreLabel.text = [NSString stringWithFormat:@"%.1f",markModel.EnvironmentScore];
            
            cell.attiScoreIndicator.scoreValue = markModel.AttitudeScore;
            cell.attiScoreLabel.text = [NSString stringWithFormat:@"%.1f",markModel.AttitudeScore];
            
            cell.priceScoreIndicator.scoreValue = markModel.PriceScore;
            cell.priceScoreLabel.text = [NSString stringWithFormat:@"%.1f",markModel.PriceScore];
            return cell;
        }
        else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = color_bodyededed;
                
                resMod_Life_GetTicketCommentList *model = [commentListMarkArray objectAtIndex:indexPath.row -1];
#if 1
                CGSize defSize = CGSizeMake(296, MAXFLOAT);
                CGSize size = [model.CommentContent sizeWithFont:defFont12 constrainedToSize:defSize lineBreakMode:NSLineBreakByWordWrapping];
#endif
                
#define color_383838  [UIColor convertHexToRGB:@"383838"]
#if 0
                CGSize size = _contentHeight;
#endif
                //评论者
                NSString *name = (model.CommentName == nil || [model.CommentName isEqualToString:@""]) ?  @"匿名用户":model.CommentName;
                
                CGSize defNameSize = CGSizeMake(120, 20);
                CGSize nameSize = [name sizeWithFont:defFont(NO, 11) constrainedToSize:defNameSize lineBreakMode:NSLineBreakByWordWrapping];
//                CGRectMake(12, 8, 120, 20)
                UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 4, nameSize.width, 20)];
                [cell.contentView addSubview:nameLabel];
                nameLabel.backgroundColor = [UIColor clearColor];
                nameLabel.text = name;
                nameLabel.textAlignment = NSTextAlignmentLeft;
                nameLabel.font = defFont(NO, 11);
                nameLabel.textColor = color_989898;
                
                //评论时间CGRectMake(80, 8, 75, 20)
                [UICommon Common_UILabel_Add:CGRectMake(12+nameSize.width + 5, 4, 75, 20) targetView:cell.contentView bgColor:[UIColor clearColor] tag:202
                                        text: model.CommentTime
                                       align:1 isBold:NO fontSize:11 tColor:color_989898];

                //评级
                for (int i=0; i<5; i++) {
                    int iscore = floor((float)model.CommentScore);
                    UIImageView * imgScore = [[UIImageView alloc] initWithFrame:CGRectMake((__MainScreen_Width-100)+(i*17), 2, 25, 25)];
                    [imgScore setBackgroundColor:[UIColor clearColor]];
                    [imgScore setImage:[UIImage imageNamed: i<iscore ? @"like_btn_sel.png":@"like_btn_nor.png"]];
                    [cell.contentView addSubview:imgScore];
                }
                
                //评论
                [UICommon Common_UILabel_Add:CGRectMake(12, 28, def_WidthArea(12), size.height) targetView:cell.contentView bgColor:[UIColor clearColor] tag:2323 text:model.CommentContent align:-1 isBold:NO fontSize:12 tColor:color_383838];
                
                UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5 + size.height + 5 + 25 +3 , 296, 0.5)];
                imv.image = [UIImage imageNamed:@"dotted_line.png"];
                [cell.contentView addSubview:imv];
#if 0
                //评论
                [UICommon Common_UILabel_Add:CGRectMake(12, 5, 296, size.height) targetView:cell.contentView bgColor:[UIColor clearColor] tag:2323 text:model.CommentContent align:-1 isBold:NO fontSize:12 tColor:color_383838];
                
                
                //评论者
                NSString *name = (model.CommentName == nil || [model.CommentName isEqualToString:@""]) ?  @"匿名用户":model.CommentName;
                
                CGSize defNameSize = CGSizeMake(80, 20);
                CGSize nameSize = [name sizeWithFont:defFont(NO, 11) constrainedToSize:defNameSize lineBreakMode:NSLineBreakByWordWrapping];
//                CGRectMake(12, 8, 120, 20)
                UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 5 + size.height + 5, nameSize.width, 20)];
                [cell.contentView addSubview:nameLabel];
                nameLabel.backgroundColor = [UIColor clearColor];
                nameLabel.text = name;
                nameLabel.textAlignment = NSTextAlignmentLeft;
                nameLabel.font = defFont(NO, 11);
                nameLabel.textColor = color_989898;

                //评论时间
                [UICommon Common_UILabel_Add:CGRectMake(__MainScreen_Width-105, 5 + size.height + 5, 90, 20) targetView:cell.contentView bgColor:[UIColor clearColor] tag:202
                                        text: model.CommentTime
                                       align:1 isBold:NO fontSize:11 tColor:color_989898];
                
                //评级
                for (int i=0; i<5; i++) {
                    int iscore = floor((float)model.CommentScore);
                    UIImageView * imgScore = [[UIImageView alloc] initWithFrame:CGRectMake(12 + nameSize.width +(i*17), 5 + size.height , 25, 25)];
                    [imgScore setBackgroundColor:[UIColor clearColor]];
                    [imgScore setImage:[UIImage imageNamed: i<iscore ? @"like_btn_sel.png":@"like_btn_nor.png"]];
                    [cell.contentView addSubview:imgScore];
                }
                
                UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5 + size.height + 5 + 25 + 8, 296, 0.5)];
                imv.image = [UIImage imageNamed:@"dotted_line.png"];
                [cell.contentView addSubview:imv];
#endif
            }
            return cell;
        }

    }
    else{
        static NSString* cellID = @"cellID2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];

        if (count == Number) {
            [cell.contentView addSubview:btn_addmore];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 205.5 + 5;
        }
        else {
            resMod_Life_GetTicketCommentList *model = [commentListMarkArray objectAtIndex:indexPath.row -1];
            
            CGSize defSize = CGSizeMake(296, MAXFLOAT);
            CGSize size = [model.CommentContent sizeWithFont:defFont12 constrainedToSize:defSize lineBreakMode:NSLineBreakByWordWrapping];
#if 0
            _contentHeight = size;
#endif
   
            return 5 + size.height + 5 + 25 +5 + 5;
            
        }
    }
    else{
        return 70;
    }
}



#pragma mark - 数据准备

- (void)goApiRequestForCommentDetail{
    
    NSMutableDictionary * dicParams = [NSMutableDictionary dictionary];
                        
                                       
    [dicParams setValue:[NSString stringWithFormat:@"%d",modelTicketInfo.TicketId] forKey:@"TicketId"];
    
//    [self ApiRequest:api_BOQIILIFE method:kApiMethod_GetTicketCommentDetail class:@"resMod_CallBack_ticketCommentDetail"
//              params:dicParams isShowLoadingAnimal:NO hudShow:@"正在加载"];
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetTicketCommentDetail:dicParams ModelClass:@"resMod_CallBack_ticketCommentDetail" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
}

- (void)goApiRequestForCommentListWithStartIndex:(NSString*)start{
    
    NSMutableDictionary * dicParams = [NSMutableDictionary dictionary];
    
    [dicParams setValue:[NSString stringWithFormat:@"%d",modelTicketInfo.TicketId] forKey:@"TicketId"];
    [dicParams setValue:start forKey:@"StartIndex"];
    [dicParams setValue:[NSString stringWithFormat:@"%d",Number] forKey:@"Number"];

    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetTicketCommentList:dicParams ModelClass:@"resMod_CallBack_GetTicketCommentList" showLoadingAnimal:NO hudContent:@"" delegate:self];
}


-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    if ([ApiName isEqualToString:kApiMethod_GetTicketCommentDetail]) {
        resMod_CallBack_ticketCommentDetail * backObj = [[resMod_CallBack_ticketCommentDetail alloc] initWithDic:retObj];

        markModel = [backObj ResponseData] ;
//        [_tableview reloadData];
        
         [self goApiRequestForCommentListWithStartIndex:[NSString stringWithFormat:@"%d",StartIndex]];//评论分数请求成功之再请求评论列表
        
    }
    
    if ([ApiName isEqualToString:kApiMethod_GetTicketCommentList]) {
        resMod_CallBack_GetTicketCommentList * backObj = [[resMod_CallBack_GetTicketCommentList alloc] initWithDic:retObj];
        if ([backObj ResponseData].count == 0) {
            [self HUDShow:@"没有用户为该服务券点评" delay:1];
        }
        count = [backObj ResponseData].count;
        if (count < Number) {
            btn_addmore.hidden = YES;
        }
        
        [commentListMarkArray addObjectsFromArray:[backObj ResponseData]];
        
        [_tableview reloadData];
    }
}

#pragma mark - addmore
- (void)onAddMoreClick:(id)sender{
    StartIndex += Number;
    [self goApiRequestForCommentListWithStartIndex:[NSString stringWithFormat:@"%d",StartIndex]];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
