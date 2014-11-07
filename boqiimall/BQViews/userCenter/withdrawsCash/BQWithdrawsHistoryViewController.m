//
//  BQWithdrawsHistoryViewController.m
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-22.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQWithdrawsHistoryViewController.h"

#import "PullToRefreshTableView.h"
#import "BQWithDrawsHistoryCell.h"
#import "resMod_GetWithDrawCashHistory.h"
#define REQUEST_NUMBER 6
@interface BQWithdrawsHistoryViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    PullToRefreshTableView *_tableView;
    NSMutableArray *_dataArray;
    resMod_GetWithDrawCashHistory *_model;
    BOOL _isFreshing;
}
@end

@implementation BQWithdrawsHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self loadNavBarView];
    [self setTitle:@"提现记录"];
    _dataArray = [NSMutableArray array];
    _isFreshing = NO;
    _model = [[resMod_GetWithDrawCashHistory alloc]init];
    
    _dataArray.count !=0 ?[_dataArray removeAllObjects]:nil;
    
    [self mainViewConfigure];
    
    [self goApiRequest_GetWithDrawCashHistory];
    
    
}


- (void)mainViewConfigure
{
    _tableView = [[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = color_bodyededed;
    
    UIView *timeLine = [[UIView alloc]initWithFrame:CGRectMake(15,-138, 1, 138)];
    timeLine.backgroundColor = [UIColor convertHexToRGB:@"989898"];
    
    
    [_tableView addSubview:timeLine];
    [self.view addSubview:_tableView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_tableView tableViewDidDragging];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)_scrollView willDecelerate:(BOOL)decelerate{
    NSInteger returnKey = [_tableView tableViewDidDragging];
    if (returnKey == k_RETURN_REFRESH) {   // 下拉刷新
        _isFreshing = YES;
        [self goApiRequest_GetWithDrawCashHistory];
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger returnKey = [_tableView tableViewDidEndDragging];
    if (returnKey == k_RETURN_LOADMORE){    // 上拉加载更多
        [self goApiRequest_GetWithDrawCashHistory];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
     [self freeViews];
}


- (void)goBack:(id)sender
{
   // [self freeViews];
    [super goBack:sender];
    
}

- (void)freeViews
{
    for (UIView* view in self.view.subviews) {
        [view removeFromSuperview];
    }
}


#pragma mark - 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (BQWithDrawsHistoryCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_dataArray.count == 0)return nil;
    
    static NSString *identifer = @"com.boqii.cell";
    
    BQWithDrawsHistoryCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifer];
    
    if (cell == nil) {
        cell = [[BQWithDrawsHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.backgroundColor = color_bodyededed;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    
    _model = _dataArray[indexPath.row];
    [_model.AccountType isEqualToString:@"支付宝"] ?(cell.timeDot.image = [UIImage imageNamed:@"icon_alipay.png"]):(cell.timeDot.image = [UIImage imageNamed:@"icon_bank.png"]);
    
    cell.timeLabel.text =[NSString stringWithFormat:@"<font size=11 color='#ffffff'><center>%@</center></font>",_model.Time] ;
    cell.AccountTypeLabel.text = [NSString stringWithFormat: @"<font color='#383838' size=14 >%@</font>",_model.AccountType];
    cell.CashAndStatusLabel.text =[NSString stringWithFormat:@"<font color='#fc4a00' size=15><b>%@</b></font><font size=11 color='#989898'> 元</font><font size=12 color='#8fc31f'>  %@</font>",_model.Cash,_model.Status] ;
    cell.RemarksLabel.text =[NSString stringWithFormat: @"<font size=12 color='#989898'>%@</font>",_model.Remarks];
    
    return cell;
    
    
    
}



#pragma  mark - API请求

- (void)goApiRequest_GetWithDrawCashHistory
{
    NSMutableDictionary *para = (NSMutableDictionary*)
  @{
      @"UserId":[UserUnit userId],
      @"StartIndex":[NSString stringWithFormat:@"%d",_dataArray.count],
      @"Number":[NSString stringWithFormat:@"%d",REQUEST_NUMBER]
    };
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestLifeGetWithDrawCashHistory:para ModelClass:@"resMod_CallBack_GetWithDrawCashHistory" showLoadingAnimal:NO hudContent:@"Loading..." delegate:self];
}

#pragma mark - API请求回调

- (void)interfaceExcuteSuccess:(id)retObj apiName:(NSString *)ApiName
{
    
    
    if ([ApiName isEqualToString:kApiMethod_GetWithDrawCashHistory]) {
        resMod_CallBack_GetWithDrawCashHistory *backObj = [[resMod_CallBack_GetWithDrawCashHistory alloc]initWithDic:retObj];
        if (backObj.ResponseData.count == 0) {
            return ;
        }
        if (_isFreshing) {
              _dataArray.count !=0 ?[_dataArray removeAllObjects]:nil;
            _isFreshing = NO;
        }
        
        [self hudWasHidden:HUD];
        [_dataArray addObjectsFromArray:backObj.ResponseData];
        
     
        [_tableView reloadData:backObj.ResponseData.count>=REQUEST_NUMBER?NO:YES allDataCount:_dataArray.count];
         _tableView.contentSize = CGSizeMake(__MainScreen_Width, 138*_dataArray.count + 45);
        UIView *timeLine = [[UIView alloc]initWithFrame:CGRectMake(15,138*_dataArray.count, 1, 138)];
        timeLine.backgroundColor = [UIColor convertHexToRGB:@"989898"];
        [_tableView addSubview:timeLine];

    }
}

- (void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName {
    [super interfaceExcuteError:error apiName:ApiName];
    
    if (_dataArray.count==0) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((__MainScreen_Width-115/2)/2, (__MainScreen_Height- 167/2)/2 - 100, 115/2, 167/2)];
        imageView.image = [UIImage imageNamed:@"img_nodata.png"];
        [self.view addSubview:imageView];
        
        _tableView.scrollEnabled = NO;

    }

    if ([ApiName isEqualToString:kApiMethod_GetWithDrawCashHistory]) {
        _isFreshing = NO;
        [self hudWasHidden:HUD];
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
