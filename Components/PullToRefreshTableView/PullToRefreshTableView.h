//
//  PullToRefreshTableView.h
//
//  Version 1.0
//
//  下拉刷新 及 上拖加载 表视图
//  使用本类，您无需去关注StateView中的方法，只要调用PullToRefreshTableView中以下三种方法即可
//
//  - (void)tableViewDidDragging;
//  - (int)tableViewDidEndDragging;
//  - (void)reloadData:(BOOL)dataIsAllLoaded;
//
//  本类未对DataSource及Delegate进行任何处理，您可自定义您的数据源及委托
//  Created by Chyo on 12-1-30.
//  Copyright (c) 2012年 QQ:115940737. All rights reserved.
//

#import <UIKit/UIKit.h>

#define k_PULL_STATE_NORMAL         0     //  状态标识：下拉可以刷新/上拖加载更多
#define k_PULL_STATE_DOWN           1     //  状态标识：释放可以刷新
#define k_PULL_STATE_LOAD           2     //  状态标识：正在加载
#define k_PULL_STATE_UP             3     //  状态标识：释放加载更多
#define k_PULL_STATE_END            4     //  状态标识：已加载全部数据

#define k_RETURN_DO_NOTHING         0     //  返回值：不执行
#define k_RETURN_REFRESH            1     //  返回值：下拉刷新
#define k_RETURN_LOADMORE           2     //  返回值：加载更多

#define k_VIEW_TYPE_HEADER          0     //  视图标识：下拉刷新视图
#define k_VIEW_TYPE_FOOTER          1     //  视图标识：上拖加载视图

#define k_STATE_VIEW_HEIGHT         40    //  视图窗体：视图高度
#define k_STATE_VIEW_INDICATE_WIDTH 185    //  视图窗体：视图箭头指示器宽度

/**
 *
 *  下拉/上拖 状态视图
 *  本接口作为内部接口使用，使用本类，您无需关注本接口，只要调用PullToRefreshTableView中以下三种方法即可
 *
 **/
@interface StateView : UIView {
@private
    UIActivityIndicatorView * indicatorView;  //  加载指示器（菊花圈）
    UIImageView             * arrowView;      //  箭头视图
    UILabel                 * stateLabel;     //  状态文本
    UILabel                 * timeLabel;      //  时间文本
    int                       viewType;       //  标识是下拉还是上拖视图
    int                       currentState;   //  标识视图当前状态
}

@property (nonatomic, retain) UIActivityIndicatorView * indicatorView;
@property (nonatomic, retain) UIImageView             * arrowView;
@property (nonatomic, retain) UILabel                 * stateLabel;
@property (nonatomic, retain) UILabel                 * timeLabel;
@property (nonatomic)         int                       viewType;
@property (nonatomic)         int                       currentState;

/**
 *  初始化视图
 *  type : 下拉/上拖视图标识  k_VIEW_TYPE_HEADER 或 k_VIEW_TYPE_FOOTER
 **/
- (id)initWithFrame:(CGRect)frame viewType:(int)type;

/**
 *  改变视图状态
 *  state : 视图状态 k_PULL_STATE_XXX
 **/
- (void)changeState:(int)state;

/**
 *  更新时间文本（当前时间）
 **/
- (void)updateTimeLabel;

@end


/**
 *
 *  下拉刷新/上拖加载 表视图
 *  使用本类，您只要调用以下三种方法即可
 *
 **/
@interface PullToRefreshTableView : UITableView{
    UIImageView * loadingBg;
    UIImageView * headbg;
    StateView * headerView;  //  下拉刷新视图
    StateView * footerView;  //  上拖加载视图
    BOOL isRefresh;          //  标识本次是下拉刷新
    
    UIView * loadingAnimal;  //  第一次加载时的动画
    UIImageView * AnimalImages;  //  动画图片
}
@property (nonatomic, assign, setter = setIsCloseHeader:) BOOL isCloseHeader;
@property (nonatomic, assign, setter = setIsCloseFooter:) BOOL isCloseFooter;
@property (nonatomic, retain) StateView *footerView;
@property (nonatomic, assign) BOOL isAutoLoad;//是否需要上拉来能加载更多的，还是只要到了最后一行就加载更多
/**
 *  当表视图拖动时的执行方法
 *  使用方法：设置表视图的delegate，实现- (void)scrollViewDidScroll:(UIScrollView *)scrollView方法，在垓方法中直接调用本方法
 **/
- (int)tableViewDidDragging;

/**
 *  当表视图结束拖动时的执行方法
 *  使用方法：设置表视图的delegate，实现- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate方法，在垓方法中直接调用本方法
 **/
- (int)tableViewDidEndDragging;


- (void)tableViewIsRefreshing;

/**
 *  刷新表视图数据
 *  dataIsAllLoaded 标识数据是否已全部加载（即“上拖加载更多”是否可用）
 *  datacount 数据总数，标识当总数据为空时，不显示下面的footerview
 **/
- (void)reloadData:(BOOL)dataIsAllLoaded allDataCount:(int) datacount;

//设置刷新加载时文字的颜色   状态的颜色跟时间的颜色
- (void)contentStateColor:(UIColor*)textC timeColor:(UIColor *)timeC;
//第一次自动下拉
- (void)launchRefreshing;
@end