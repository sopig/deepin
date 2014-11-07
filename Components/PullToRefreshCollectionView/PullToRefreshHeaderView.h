//
//  PullToRefreshHeaderView.h
//  FrameTest
//
//  Created by iXiaobo on 14-9-23.
//  Copyright (c) 2014年 iXiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PullToRefreshHeaderView : UIView
{
    UIImageView *_firstImageView;
    UIImageView *_secondImageView;
    
    id delegate;
  
}
@property(nonatomic,retain)id delegate;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidLoadingFinished:(UIScrollView *)scrollView;

@end

@protocol PullToRefreshHeaderViewDelegate <NSObject>

- (void)onPullToRefreshHeaderViewDidTriggerRefresh:(PullToRefreshHeaderView *)view;


@end