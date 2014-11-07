//
//  BQGrouponSegmentedView.h
//  boqiimall
//
//  Created by iXiaobo on 14-9-23.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BQGrouponSegmentedViewDelegate <NSObject>

- (void)onBQGrouponSegmentedViewSelected:(id)selectedObj;


@end


@interface BQGrouponSegmentedView : UIView
{
    NSArray *itemsArray;
    BOOL isEnable;
    
    id<BQGrouponSegmentedViewDelegate>delegate;
}
@property(nonatomic,assign)BOOL isEnable;

@property(strong,atomic)id<BQGrouponSegmentedViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)itemsArray;
- (void)setSelectedIndex:(NSInteger)index;

@end


