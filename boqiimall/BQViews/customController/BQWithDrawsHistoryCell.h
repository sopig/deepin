//
//  BQWithDrawsHistoryCell.h
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-24.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"
@interface BQWithDrawsHistoryCell : UITableViewCell

@property(nonatomic,readwrite,strong)RTLabel* timeLabel;
@property(nonatomic,readwrite,strong)RTLabel* AccountTypeLabel;
@property(nonatomic,readwrite,strong)RTLabel* CashAndStatusLabel;
@property(nonatomic,readwrite,strong)RTLabel* RemarksLabel;

@property(nonatomic,readwrite,strong)UIImageView *timeDot;


@end
