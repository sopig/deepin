//
//  PullToRefreshTableView.m
//
//  Version 1.0
//
//  Created by hsit on 12-1-30.
//  Copyright (c) 2012年 QQ:115940737. All rights reserved.
//

#import "PullToRefreshTableView.h"
#import <QuartzCore/QuartzCore.h>

/**
 *
 * StateView 顶部和底部状态视图
 *
 **/

@implementation StateView

@synthesize indicatorView;
@synthesize arrowView;
@synthesize stateLabel;
@synthesize timeLabel;
@synthesize viewType;
@synthesize currentState;

- (id)initWithFrame:(CGRect)frame viewType:(int)type{
    CGFloat width = frame.size.width;
    
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, width, k_STATE_VIEW_HEIGHT)];
    
    if (self) {
        //  设置当前视图类型
        viewType = type == k_VIEW_TYPE_HEADER ? k_VIEW_TYPE_HEADER : k_VIEW_TYPE_FOOTER;
        self.backgroundColor = [UIColor clearColor];
        
        //  初始化加载指示器（菊花圈）
        indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((k_STATE_VIEW_INDICATE_WIDTH - 32) / 2, (k_STATE_VIEW_HEIGHT - 20) / 2, 20, 20)];
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
//        indicatorView.hidesWhenStopped = YES;
        [self addSubview:indicatorView];
        
        //  初始化箭头视图
//        arrowView = [[UIImageView alloc] initWithFrame:CGRectMake((k_STATE_VIEW_INDICATE_WIDTH - 32) / 2, (k_STATE_VIEW_HEIGHT - 32) / 2, 28/2, 60/2)];
        arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(width/2-100/4.4, 0, 100/2.2, 100/2.2)];
        NSString * imageNamed = type == k_VIEW_TYPE_HEADER ? @"loding_pic1":@"loding_pic1";//@"arrow_down.png" : @"arrow_up.png";
        arrowView.image = [UIImage imageNamed:imageNamed];
        [self addSubview:arrowView];
        
        //  初始化状态提示文本
        stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, width, 18)];
        stateLabel.font = [UIFont systemFontOfSize:12.0f];
        stateLabel.backgroundColor = [UIColor clearColor];
        [stateLabel setTextColor:[UIColor lightGrayColor]];
        stateLabel.textAlignment = NSTextAlignmentCenter;
        stateLabel.text = type == k_VIEW_TYPE_HEADER ? @"下拉可以刷新" : @"上拖加载更多";
//        [self addSubview:stateLabel];
        
        //  初始化更新时间提示文本
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, width, k_STATE_VIEW_HEIGHT - 20)];
        timeLabel.font = [UIFont systemFontOfSize:12.0f];
        timeLabel.backgroundColor = [UIColor clearColor];
        [timeLabel setTextColor:[UIColor lightGrayColor]];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.text = @"-";
//        [self addSubview:timeLabel];
    }
    return self;
}

- (void)changeState:(int)state{
    [indicatorView stopAnimating];
    arrowView.hidden = NO;
    [UIView beginAnimations:nil context:nil];
    switch (state) {
        case k_PULL_STATE_NORMAL:
            currentState = k_PULL_STATE_NORMAL;
            stateLabel.text = viewType == k_VIEW_TYPE_HEADER ? @"下拉可以刷新" : @"上拖加载更多";
            //  旋转箭头
//            arrowView.layer.transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            break;
        case k_PULL_STATE_DOWN:
            currentState = k_PULL_STATE_DOWN;
            stateLabel.text = @"释放刷新数据";
//            arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            break;
            
        case k_PULL_STATE_UP:
            currentState = k_PULL_STATE_UP;
            stateLabel.text = @"释放加载数据";
//            arrowView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            break;
            
        case k_PULL_STATE_LOAD:
            currentState = k_PULL_STATE_LOAD;
            stateLabel.text = viewType == k_VIEW_TYPE_HEADER ? @"正在刷新.." : @"正在加载..";
            [self loadingUpdateImage];
//            [indicatorView startAnimating];
//            arrowView.hidden = YES;
            break;
            
        case k_PULL_STATE_END:
            currentState = k_PULL_STATE_END;
            
            stateLabel.text = viewType == k_VIEW_TYPE_HEADER ? stateLabel.text : @"已加载全部数据";
            arrowView.hidden = YES;
            break;
            
        default:
            currentState = k_PULL_STATE_NORMAL;
            stateLabel.text = viewType == k_VIEW_TYPE_HEADER ? @"下拉可以刷新" : @"上拖加载更多";
//            arrowView.layer.transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            break;
    }
    [UIView commitAnimations];
}

- (void)loadingUpdateImage{
    
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"loding_pic2.png"],
                         [UIImage imageNamed:@"loding_pic3.png"],
                         [UIImage imageNamed:@"loding_pic4.png"],
                         [UIImage imageNamed:@"loding_pic3.png"], nil];
    
    arrowView.animationImages = myImages;
    arrowView.animationDuration = 1;
    arrowView.animationRepeatCount = 0;
    [arrowView startAnimating];
}

- (void)updateTimeLabel{
    [arrowView stopAnimating];
    [arrowView setImage:[UIImage imageNamed:@"loding_pic1.png"]];
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    timeLabel.text = [NSString stringWithFormat:@"更新于 %@", [formatter stringFromDate:date]];
    [formatter release];
}

- (void)dealloc{
    [indicatorView release];
    [arrowView release];
    [stateLabel release];
    [timeLabel release];
    
    [super dealloc];
}

@end


/**
 *
 * PullToRefreshTableView 拖动刷新/加载 表格视图
 *
 **/


@implementation PullToRefreshTableView
@synthesize isCloseFooter = _isCloseFooter;
@synthesize isCloseHeader = _isCloseHeader;
@synthesize footerView;
@synthesize isAutoLoad;

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initTabView:frame];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initTabView:frame];
    }
    return self;
}

- (void) initTabView:(CGRect) frame{
    //  --好多鱼背景
    headbg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-260/4, -50-65, 260/2, 131/2)];
    [headbg setBackgroundColor:[UIColor clearColor]];
    [headbg setImage:[UIImage imageNamed:@"loadingTopBG.png"]];
    [self addSubview:headbg];

    headerView = [[StateView alloc] initWithFrame:CGRectMake(0, -46, frame.size.width, 50) viewType:k_VIEW_TYPE_HEADER];
    footerView = [[StateView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 50) viewType:k_VIEW_TYPE_FOOTER];
    footerView.arrowView.frame = CGRectMake(CGRectGetMinX(footerView.arrowView.frame), 4, CGRectGetWidth(footerView.arrowView.frame), CGRectGetHeight(footerView.arrowView.frame));
    [footerView setHidden:YES];
    [self addSubview:headerView];
    [self setTableFooterView:footerView];
    self.isCloseHeader = NO;
    self.isCloseFooter = NO;
    self.isAutoLoad = NO;
}

- (void)contentStateColor:(UIColor*)textC timeColor:(UIColor *)timeC {
    [headerView.stateLabel setTextColor:textC];
    [headerView.timeLabel setTextColor:timeC];
    [footerView.stateLabel setTextColor:textC];
    [footerView.timeLabel setTextColor:timeC];
}

- (void)setIsCloseHeader:(BOOL)isCloseHeader {
    if(_isCloseHeader == isCloseHeader) {
        return;
    }
    
    _isCloseHeader = isCloseHeader;
    if(isCloseHeader) {
        headerView.hidden = YES;
        headbg.hidden = YES;
    }
    else{
        headerView.hidden = NO;
        headbg.hidden = NO;
    }
}
- (void)setIsCloseFooter:(BOOL)isCloseFooter {
    if(_isCloseFooter == isCloseFooter) {
        return;
    }
    
    _isCloseFooter = isCloseFooter;
    if(isCloseFooter) {
        footerView.hidden = YES;
    }
    else{
        footerView.hidden = NO;
    }
}
- (void)dealloc{
    [headerView release];
    [footerView release];
    [super dealloc];
}

- (void)launchRefreshing {
    [self setContentOffset:CGPointMake(0,0) animated:NO];
    [UIView animateWithDuration:0.18 animations:^{
        self.contentOffset = CGPointMake(0, -60-1);
        self.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
    } completion:^(BOOL bl){
        [self tableViewDidEndDragging];
    }];
}

- (int)tableViewDidDragging{
    CGFloat offsetY = self.contentOffset.y;
    //  判断是否正在加载
    if (headerView.currentState == k_PULL_STATE_LOAD ||
        footerView.currentState == k_PULL_STATE_LOAD) {
        
        if (headerView.currentState == k_PULL_STATE_LOAD) {
            [UIView animateWithDuration:0.2 animations:^{
                CGFloat offset = MAX(self.contentOffset.y * -1, 0);
                offset = MIN(offset, 50);
                self.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
            }];
        }
        return -1;
    }
    
    //  改变“下拉可以刷新”视图的文字提示
    if (offsetY < -k_STATE_VIEW_HEIGHT - 15 ) {
        if(self.isCloseHeader == NO)    {
            [headerView changeState:k_PULL_STATE_DOWN];
            return k_RETURN_REFRESH;
        }
    }
    else if(offsetY < 0) {
        if(self.isCloseHeader == NO)    {
            [headerView changeState:k_PULL_STATE_NORMAL];
            return k_RETURN_DO_NOTHING;
        }
    }
    
    //  判断数据是否已全部加载
    if (footerView.currentState == k_PULL_STATE_END) {
        return -1;
    }
    //  计算表内容大小与窗体大小的实际差距
    CGFloat differenceY = self.contentSize.height>self.frame.size.height ? (self.contentSize.height-self.frame.size.height):0;
    //  改变“上拖加载更多”视图的文字提示
    if (!isAutoLoad) {
        if (offsetY > differenceY + k_STATE_VIEW_HEIGHT/3) {
            if(self.isCloseFooter == NO)    [footerView changeState:k_PULL_STATE_UP];
        } else {
            if(self.isCloseFooter == NO)    [footerView changeState:k_PULL_STATE_NORMAL];
        }
    }
    return -1;
}

- (int)tableViewDidEndDragging{
    CGFloat offsetY = self.contentOffset.y;
    //  是否正在加载数据
    if (headerView.currentState == k_PULL_STATE_LOAD ||
        footerView.currentState == k_PULL_STATE_LOAD) {
        
        return k_RETURN_DO_NOTHING;
    }
    
    //  上拉加载    :   改变视图的文字及箭头提示
    CGFloat differenceY=self.contentSize.height>self.frame.size.height ? (self.contentSize.height-self.frame.size.height):0;
    if (!isAutoLoad) {

        if (footerView.currentState != k_PULL_STATE_END && offsetY+k_STATE_VIEW_HEIGHT > differenceY) {
            if(self.isCloseFooter) {
                return k_RETURN_DO_NOTHING;
            }
            else{
                [footerView changeState:k_PULL_STATE_LOAD];
                return k_RETURN_LOADMORE;
            }
        }
    }
    else{
        if (footerView.currentState != k_PULL_STATE_END && offsetY > differenceY-50) {
            //不需要上拉加载，只要滑动最后一行就加载
            [footerView changeState:k_PULL_STATE_LOAD];
            return k_RETURN_LOADMORE;
        }
    }
    return k_RETURN_DO_NOTHING;
}

- (void)tableViewIsRefreshing{
    isRefresh = YES;
    [headerView changeState:k_PULL_STATE_LOAD];
}

- (void)reloadData:(BOOL)dataIsAllLoaded allDataCount:(int) datacount{
    [self reloadData];
    [footerView setHidden: datacount>0 ? NO:YES];

//    self.contentInset = UIEdgeInsetsZero;
    [headerView changeState:k_PULL_STATE_NORMAL];
    if (isRefresh) {
        isRefresh = NO;
        if (self.contentInset.top != 0) {
            [UIView animateWithDuration:0.2 animations:^{
                self.contentInset = UIEdgeInsetsZero;
            }];
        }
    }
    //  如果数据已全部加载，则禁用“上拖加载”
    if (dataIsAllLoaded) {
        if (isAutoLoad) {
            self.tableFooterView = nil;
        }
        [footerView changeState:k_PULL_STATE_END];
        self.tableFooterView = nil;
    }
    else {
        self.tableFooterView = footerView;
        [footerView changeState:k_PULL_STATE_NORMAL];
    }
    
    //  更新时间提示文本
    [headerView updateTimeLabel];
    [footerView updateTimeLabel];
}
@end


