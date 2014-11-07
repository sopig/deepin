//
//  MerchantCommentViewController.m
//  boqiimall
//
//  Created by 张正超 on 14-7-14.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "MerchantCommentViewController.h"
#import "resMod_GetMerchantCommentList.h"
#import "BQMerchantCommentListCell.h"
#import "BQCustomBarButtonItem.h"
#define Number 6

@interface MerchantCommentViewController ()
{
    int StartIndex;
    NSMutableArray *merchantCommentArray;
    UITableView *_tableView;
    UIButton *btn_addmore;
    int count;
}

@end

@implementation MerchantCommentViewController

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
    [self setTitle:@"商户消费点评"];
    
    self.view.backgroundColor = color_bodyededed;
    
    
    
    StartIndex = 0;
    count = 0;
    merchantCommentArray = [NSMutableArray array];
     [self goApiRequestWithStartIndex:[NSString stringWithFormat:@"%d",StartIndex]];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    [_tableView setBackgroundColor:[UIColor clearColor]];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    
    btn_addmore = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn_addmore setBackgroundColor:[UIColor clearColor]];
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
//    titleLabel.text = @"商户消费点评";
//    [bgView addSubview:titleLabel];
//    [self.navBarView addSubview:bgView];
//}



#pragma mark - 数据准备


- (void)goApiRequestWithStartIndex:(NSString*)startIndex{
    
    NSMutableDictionary * dicParams = [NSMutableDictionary dictionary];
    
    [dicParams setValue:[self.receivedParams objectForKey:@"MerchantId"] forKey:@"MerchantId"];
    [dicParams setValue:startIndex forKey:@"StartIndex"];
       [dicParams setValue:[NSString stringWithFormat:@"%d",Number] forKey:@"Number"];

    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetMerchantCommentList:dicParams ModelClass:@"resMod_CallBack_GetMerchantCommentList" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
    
}


-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    [self hudWasHidden:HUD];
    
    if ([ApiName isEqualToString:kApiMethod_GetMerchantCommentList]) {
        resMod_CallBack_GetMerchantCommentList * backObj = [[resMod_CallBack_GetMerchantCommentList alloc] initWithDic:retObj];
        
        if ([backObj ResponseData].count == 0) {
            [self HUDShow:@"没有用户为该商户点评" delay:2];
        }
        
        count = [backObj ResponseData].count;
        
        if (count < Number) {
            btn_addmore.hidden = YES;
        }
        
        [merchantCommentArray addObjectsFromArray:[backObj ResponseData]];
        
        [_tableView reloadData];
    }
}



#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return merchantCommentArray.count;
    }
    else{
        return 1;
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = [NSString stringWithFormat:@"%d%d",indexPath.section,indexPath.row];
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            resMod_GetMerchantCommentList *model = [merchantCommentArray objectAtIndex:indexPath.row];
            
            CGSize defSize = CGSizeMake(296, MAXFLOAT);
            CGSize size = [model.CommentContent sizeWithFont:defFont12 constrainedToSize:defSize lineBreakMode:NSLineBreakByWordWrapping];
#define color_383838  [UIColor convertHexToRGB:@"383838"]
#if 0
            //评论
            [UICommon Common_UILabel_Add:CGRectMake(12, 10, 296, size.height) targetView:cell.contentView bgColor:[UIColor clearColor] tag:2323 text:model.CommentContent align:-1 isBold:NO fontSize:12 tColor:color_383838];
            
            
            //评论者
            NSString *name = (model.CommentName != nil) ? model.CommentName : @"匿名用户";
            CGSize defNameSize = CGSizeMake(80, 20);
            CGSize nameSize = [name sizeWithFont:defFont(NO, 11) constrainedToSize:defNameSize lineBreakMode:NSLineBreakByWordWrapping];
            
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 10 + size.height + 5, nameSize.width, 20)];
            [cell.contentView addSubview:nameLabel];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.text = name;
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.font = defFont(NO, 11);
            nameLabel.textColor = color_989898;

            
            //评论时间
            [UICommon Common_UILabel_Add:CGRectMake(__MainScreen_Width-105, 10 + size.height + 5, 90, 20) targetView:cell.contentView bgColor:[UIColor clearColor] tag:202
                                    text: model.CommentTime
                                   align:1 isBold:NO fontSize:11 tColor:color_989898];
            
            //评级
            for (int i=0; i<5; i++) {
                int iscore = floor((float)model.CommentScore);
                UIImageView * imgScore = [[UIImageView alloc] initWithFrame:CGRectMake(12+ nameSize.width+(i*17), 10 + size.height , 25, 25)];
                [imgScore setBackgroundColor:[UIColor clearColor]];
                [imgScore setImage:[UIImage imageNamed: i<iscore ? @"like_btn_sel.png":@"like_btn_nor.png"]];
                [cell.contentView addSubview:imgScore];
            }
            
//            UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(12, 10 + size.height + 5 + 25, 296, 0.5)];
//            imv.image = [UIImage imageNamed:@"dotted_line.png"];
//            [cell.contentView addSubview:imv];
            
            //titicket
#endif
            
            //评论者
            NSString *name = (model.CommentName == nil || [model.CommentName isEqualToString:@""]) ?  @"匿名用户":model.CommentName;
            
                            CGSize defNameSize = CGSizeMake(120, 20);
                            CGSize nameSize = [name sizeWithFont:defFont(NO, 11) constrainedToSize:defNameSize lineBreakMode:NSLineBreakByWordWrapping];
            //                CGRectMake(12, 8, 120, 20)
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 8, nameSize.width, 20)];
            [cell.contentView addSubview:nameLabel];
            nameLabel.backgroundColor = [UIColor clearColor];
            nameLabel.text = name;
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.font = defFont(NO, 11);
            nameLabel.textColor = color_989898;
            
            
            //评论时间
            [UICommon Common_UILabel_Add:CGRectMake(12+nameSize.width + 5, 8, 75, 20) targetView:cell.contentView bgColor:[UIColor clearColor] tag:202
                                    text: model.CommentTime
                                   align:1 isBold:NO fontSize:11 tColor:color_989898];
            
            
            //评级
            for (int i=0; i<5; i++) {
                int iscore = floor((float)model.CommentScore);
                UIImageView * imgScore = [[UIImageView alloc] initWithFrame:CGRectMake((__MainScreen_Width-100)+(i*17), 5, 25, 25)];
                [imgScore setBackgroundColor:[UIColor clearColor]];
                [imgScore setImage:[UIImage imageNamed: i<iscore ? @"like_btn_sel.png":@"like_btn_nor.png"]];
                [cell.contentView addSubview:imgScore];
            }
            
            //评论
            [UICommon Common_UILabel_Add:CGRectMake(12, 32, def_WidthArea(12), size.height) targetView:cell.contentView bgColor:[UIColor clearColor] tag:2323 text:model.CommentContent align:-1 isBold:NO fontSize:12 tColor:color_383838];
            
            
            
            //                [UICommon Common_UILabel_Add:CGRectMake(12, 5 + size.height + 5, 80, 20)
            //                                  targetView:cell.contentView bgColor:[UIColor clearColor] tag:202
            //                                        text: name
            //                                       align:-1 isBold:NO fontSize:11 tColor:color_989898];
            
            
            if (![model.TicketTitle isEqualToString:@""]) {
                
                UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(12, 5 + size.height + 5 + 25 +3 , 296, 0.5)];
                imv.image = [UIImage imageNamed:@"dotted_line.png"];
                [cell.contentView addSubview:imv];
                
                
                
                BQCustomBarButtonItem *ticketTitle = [[BQCustomBarButtonItem alloc]initWithFrame:CGRectMake(12, 10 + size.height  + 25 + 4 + 2, 296, 30)];
                
                ticketTitle.titleRect = CGRectMake(3, 3, 290, 25);
                ticketTitle.titleLabel.font = defFont12;
                
                
                
//                NSString* titleContent = ((model.TicketTitle == nil || [model.TicketTitle isEqualToString:@""]) ? @"没有数据":model.TicketTitle);
                
                ticketTitle.titleLabel.text = model.TicketTitle;
                ticketTitle.titleLabel.textColor = color_989898;
                ticketTitle.titleLabel.textAlignment = NSTextAlignmentLeft;
                [cell.contentView addSubview:ticketTitle];
                ticketTitle.Color = color_dedede;
                ticketTitle.radius = 3.0f;
                
                ticketTitle.delegate = self;
                ticketTitle.selector = NSSelectorFromString(@"ticketTitleButtonClick:");
                ticketTitle.paramObject = [NSString stringWithFormat:@"%d",model.TicketId];

            }
            
            [model.TicketTitle isEqualToString:@""] ? [UICommon Common_line:CGRectMake(0, 10 + size.height + 5 + 25  + 33 + 0.5 -30 , 320, 0.5) targetView:cell.contentView backColor:color_d1d1d1] :[UICommon Common_line:CGRectMake(0, 10 + size.height + 5 + 25  + 33 + 0.5 , 320, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
            
    }
        cell.opaque = YES;
        cell.backgroundColor = color_bodyededed;
        return cell;
}
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
             cell.backgroundColor = color_bodyededed;
        }
        cell.opaque = YES;
        
        //tableView 做性能优化，不要有透明 只需要绘出需要展示的内容
        //[cell setBackgroundColor:[UIColor clearColor]];
        //[cell.contentView setBackgroundColor:[UIColor clearColor]];
        if (count == Number) {
            [cell.contentView addSubview:btn_addmore];
//            cell.backgroundColor = color_bodyededed;
        }
         return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        CGFloat height = 0.0f;
        resMod_GetMerchantCommentList *model = [merchantCommentArray objectAtIndex:indexPath.row];
        
        CGSize defSize = CGSizeMake(296, MAXFLOAT);
        CGSize size = [model.CommentContent sizeWithFont:defFont12 constrainedToSize:defSize lineBreakMode:NSLineBreakByWordWrapping];
        [model.TicketTitle isEqualToString:@""] ? (height =  5 + size.height + 5 + 25  + 33 + 5 + 3 + 2 -30) : (height = 5 + size.height + 5 + 25  + 33 + 5 + 3 + 2);
        return height;
    }
  else
  {
      return merchantCommentArray.count == 0 ? 0:80;
      
  }
    
}


#pragma mark - addmore
- (void)onAddMoreClick:(id)sender{
    StartIndex = Number +StartIndex;
    [self goApiRequestWithStartIndex:[NSString stringWithFormat:@"%d",StartIndex]];
    
}



#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)ticketTitleButtonClick:(id)sender{
    
    NSString *ticketID = (NSString*)sender;
    
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:ticketID forKey:@"param_TicketId"];
    [self pushNewViewController:@"ServiceDetailViewController" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:paramDict];
    
}


@end
