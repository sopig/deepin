//
//  BQGrouponCollectionViewCell.h
//  FrameTest
//
//  Created by iXiaobo on 14-9-23.
//  Copyright (c) 2014年 iXiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"


@interface BQGrouponCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
@property (weak, nonatomic) IBOutlet UILabel *goodsOriPrice;

@property (weak, nonatomic) IBOutlet UIView *horizontalLineView;

@property (weak, nonatomic) IBOutlet UILabel *goodsCurrentPrice;
@property (weak, nonatomic) IBOutlet UILabel *remainTime;
@property (weak, nonatomic) IBOutlet UIImageView *discountImage;
@property (weak, nonatomic) IBOutlet UILabel *TotalNumber;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@end
