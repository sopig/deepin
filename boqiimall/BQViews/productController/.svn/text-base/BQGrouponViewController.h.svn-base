//
//  BQGrouponViewController.h
//  boqiimall
//
//  Created by iXiaobo on 14-9-23.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "BQGrouponSegmentedView.h"
#import "PullToRefreshHeaderView.h"
#import "PullToRefreshFooterView.h"

@interface BQGrouponViewController : BQIBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,BQGrouponSegmentedViewDelegate,PullToRefreshFooterViewDelegate,PullToRefreshHeaderViewDelegate>
{
    BQGrouponSegmentedView *grouponSegmentedView;
    
    NSMutableArray *groupGoodsArray;
    NSString *typeId;
    
    UICollectionView *_collectionView;
    PullToRefreshHeaderView *headerView;
    PullToRefreshFooterView *footerView;
    BOOL isFooterViewShouldShow;
    BOOL isRefreshFlag;
    NSTimer *refreshRemainTimer;
    NSMutableDictionary *willRefreshRemainTimerLabelsDict;
    NSMutableArray *arrCategoryType;
    
}




@end
