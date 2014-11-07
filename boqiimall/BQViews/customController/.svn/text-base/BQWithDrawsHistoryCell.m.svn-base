//
//  BQWithDrawsHistoryCell.m
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-24.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQWithDrawsHistoryCell.h"


#define TIME_HEIGHT 16.5
#define ACCOUNT_HEIGHT 20
#define CASH_HEIGHT 25
#define REMARK_HEIGHT 35


#define BG_WIDTH 278
#define CONTENT_ORIGIN_X 30

@implementation BQWithDrawsHistoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        UIView *timeLine = [[UIView alloc]initWithFrame:CGRectMake(15,-130, 1, 138+130)];
          UIView *timeLine = [[UIView alloc]initWithFrame:CGRectMake(15,0, 1, 138)];
        timeLine.backgroundColor = [UIColor convertHexToRGB:@"989898"];
    
        
        _timeDot = [[UIImageView alloc]initWithFrame:CGRectMake(9, 14, 12,12)];

        

        UIImageView *timeBGLabelIV = [[UIImageView alloc]initWithFrame:CGRectMake(CONTENT_ORIGIN_X , 12, 120, TIME_HEIGHT)];
        UIImage *image = [UIImage imageNamed:@"time_bg.png"];
        timeBGLabelIV.image = [image stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        _timeLabel = [[RTLabel alloc]initWithFrame:CGRectMake(2 , 2, 120, TIME_HEIGHT)];
        [timeBGLabelIV addSubview:_timeLabel];
        

        _AccountTypeLabel = [[RTLabel alloc]initWithFrame:CGRectMake(CONTENT_ORIGIN_X+ 10, 12 +TIME_HEIGHT + 12 + 5, BG_WIDTH, ACCOUNT_HEIGHT)];
        
        _CashAndStatusLabel = [[RTLabel alloc]initWithFrame:CGRectMake(CONTENT_ORIGIN_X+ 10, 12 +TIME_HEIGHT + 12 + ACCOUNT_HEIGHT + 5, BG_WIDTH, CASH_HEIGHT)];
        
        
        _RemarksLabel = [[RTLabel alloc]initWithFrame:CGRectMake(CONTENT_ORIGIN_X+ 10, 12 +TIME_HEIGHT + 12 + ACCOUNT_HEIGHT + CASH_HEIGHT+ 5 , BG_WIDTH, REMARK_HEIGHT)];
        _RemarksLabel.lineBreakMode = RTTextLineBreakModeWordWrapping;
        
        UIImageView *dotLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CONTENT_ORIGIN_X, 12 +TIME_HEIGHT + 12 + ACCOUNT_HEIGHT + CASH_HEIGHT +REMARK_HEIGHT + 12+ 5, BG_WIDTH, 0.5)];
        dotLineImageView.image = [UIImage imageNamed:@"dotted_line.png"];
        
        
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(CONTENT_ORIGIN_X , 12 +TIME_HEIGHT + 12, BG_WIDTH-5, ACCOUNT_HEIGHT+CASH_HEIGHT+REMARK_HEIGHT+ 10)];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.shadowColor = [UIColor convertHexToRGB:@"d1d1d1"].CGColor;
        contentView.layer.shadowRadius = 1.0f;
        contentView.layer.shadowOpacity = 0.9;
        contentView.layer.shadowOffset = CGSizeMake(5,0);
        contentView.layer.borderColor = [UIColor convertHexToRGB:@"d1d1d1"].CGColor;
        contentView.layer.borderWidth = 0.5;
        contentView.layer.cornerRadius = 3.0f;
        
        
        [self addSubview:contentView];
        [self addSubview:timeLine];
        [self addSubview:_timeDot];
        [self addSubview:timeBGLabelIV];
        [self addSubview:_AccountTypeLabel];
        [self addSubview:_CashAndStatusLabel];
        [self addSubview:_RemarksLabel];
        [self addSubview:dotLineImageView];
        
    }
    return self;
}


@end
