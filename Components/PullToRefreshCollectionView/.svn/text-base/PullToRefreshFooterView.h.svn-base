//
//  PullToRefreshFooterView.h
//  FrameTest
//
//  Created by iXiaobo on 14-9-23.
//  Copyright (c) 2014年 iXiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PullToRefreshFooterView : UIView
{
    id delegate;
    UIImageView *_imageView;
}
@property(nonatomic,strong)id delegate;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidLoadingFinished:(UIScrollView *)scrollView;


@end

@protocol PullToRefreshFooterViewDelegate <NSObject>

- (void)onPullToRefreshFooterViewDidTriggerRefresh:(PullToRefreshFooterView *)view;


@end