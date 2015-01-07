//
//  ViewController.m
//  DDTimeLineDemo
//
//  Created by tolly on 15/1/6.
//  Copyright (c) 2015年 tolly. All rights reserved.
//

#import "ViewController.h"
#import "DDTimeScroller.h"

#import "DDPopKeyWordsView.h"

#import "DDMacro.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,DDTimeScrollerDelegate,DDSearchShowViewDelegate>
{
    NSMutableArray *_datasource;
    DDTimeScroller *_timeScroller;
}
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headView = [[[NSBundle mainBundle] loadNibNamed:@"DDHeadInfoView" owner:nil options:nil] lastObject];
    _tableView.tableHeaderView  = _headView;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    __weak ViewController* wself = self;
    [_headView setHandleRefreshEvent:^{
        
        //刷新方法
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
        
            
            [wself.headView stopRefresh];
        });
    }];
    
     _timeScroller = [[DDTimeScroller alloc] initWithDelegate:self];
 
    
    [self setupDatasource];
}
#pragma mark- scroll delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.headView.offsetY = scrollView.contentOffset.y;
    [_timeScroller scrollViewDidScroll];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _headView.touching = NO;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(decelerate==NO)
    {
        _headView.touching = NO;
    }
    
      [_timeScroller scrollViewDidEndDecelerating];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _headView.touching = YES;
    [_timeScroller scrollViewWillBeginDragging];
}
#pragma mark-

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


DDPopKeyWordsView *popKeyWordsView = nil;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString*cellIdentifer = [NSString stringWithFormat:@"cellId"];
    
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        for (UIView*view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hah)];
    [cell.contentView addGestureRecognizer:tap];
    
    
    popKeyWordsView = [[DDPopKeyWordsView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 300)];
    popKeyWordsView.keyWordArray = [NSMutableArray arrayWithObjects:@"张正超",@"董铎",@"boqii.com",@"iOS",@"NSScanner", @"NSArray",@"i love UNIX", @"奔跑吧骚年",@"优雅", @"哈哈哈哈",@"HTTP", @"协议",@"命名", @"我注定这样。。",@"接收者", @"获取",  nil];
    popKeyWordsView.delegate = self;
    [cell.contentView addSubview:popKeyWordsView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [popKeyWordsView changeSearchKeyWord];
    });
    

    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hah{
    [popKeyWordsView changeSearchKeyWord];
}

#pragma mark - 

- (void)setupDatasource
{
    _datasource = [NSMutableArray new];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *today = [NSDate date];
    NSDateComponents *todayComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    for (NSInteger i = [todayComponents day]; i >= -15; i--)
    {
        [components setYear:[todayComponents year]];
        [components setMonth:[todayComponents month]];
        [components setDay:i];
        [components setHour:arc4random() % 23];
        [components setMinute:arc4random() % 59];
        
        NSDate *date = [calendar dateFromComponents:components];
        [_datasource addObject:date];
    }
}

#pragma mark -

- (UITableView *)tableViewForTimeScroller:(DDTimeScroller *)timeScroller
{
    return _tableView;
}

- (NSDate *)timeScroller:(DDTimeScroller *)timeScroller dateForCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    return _datasource[[indexPath row]];
}

- (id)timeScroller:(DDTimeScroller *)timeScroller ContentdateForCell:(UITableViewCell *)cell{
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    
    NSMutableArray *dataA = [NSMutableArray array];
    for (int i =0; i < 10; i++) {
        NSString *string = [NSString stringWithFormat:@"%d月大的狗狗",i];
        [dataA addObject:string];
    }
    
    return dataA[indexPath.row];
}


#pragma mark - 
- (void)searchHotTaglibWithKeyWord:(NSString *)keyWords{
    DDLog(@"%@",keyWords);
}


@end
