//
//  BQMerchantCommentListCell.m
//  boqiimall
//
//  Created by 张正超 on 14-7-18.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQMerchantCommentListCell.h"


@implementation BQMerchantCommentListCell

- (void)awakeFromNib
{
    // Initialization code
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier showTicketTitle:(BOOL)show withHeight:(CGFloat)height addTargetView:(UIView*)targetView
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, targetView.frame.size.width, height )];
        bgView.backgroundColor = [UIColor clearColor];
        [targetView addSubview:bgView];
        
        bgView.layer.borderColor = [UIColor redColor].CGColor;
        bgView.layer.borderWidth = 1;
        
        
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 3, 280, height)];
        //        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 280, 40)];
        self.contentLabel.font = defFont12;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textColor = [UIColor convertHexToRGB:@"383838"];
        [self addSubview:self.contentLabel];
        
        
        self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 3 + height + 5, 69, 21)];
        //        self.userNameLabel.text = @"测试";
        self.userNameLabel.font = defFont12;
        self.userNameLabel.textColor = color_989898;
        [self addSubview:self.userNameLabel];
        
        self.imv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 3 + height + 5 + 21 + 3, 280, 0.5)];
        self.imv.image = [UIImage imageNamed:@"dotted_line.png"];
        [self addSubview:self.imv];
        
        
        self.CommentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 3 + height + 5, 87, 21)];
        self.CommentTimeLabel.font = defFont(NO, 11);
        self.CommentTimeLabel.textColor = color_989898;
        [self addSubview:self.CommentTimeLabel];
        
        
        
        self.starRating = [[BQStarRatingView alloc]initWithFrame:CGRectMake(85, 3 + height + 5, 120, 24) numberOfStar:5 withStatue:1];
        [self addSubview:self.starRating];
        
        if (show) {
            self.TicketTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 3 + height + 5 + 21 + 3 , 280, 33)];
            self.TicketTitleLabel.font = defFont12;
            self.TicketTitleLabel.textColor = color_989898;
            [self addSubview:self.TicketTitleLabel];
            
            [UICommon Common_line:CGRectMake(0, 100, 320, 0.5) targetView:self backColor:color_d1d1d1];
            
        }
    }
    return self;
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier showTicketTitle:(BOOL)show
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    
         self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 280, 40)];
//        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 280, 40)];
        self.contentLabel.font = defFont12;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textColor = [UIColor convertHexToRGB:@"383838"];
        [self addSubview:self.contentLabel];
        
        
        self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 52, 69, 21)];
        //        self.userNameLabel.text = @"测试";
        self.userNameLabel.font = defFont12;
        self.userNameLabel.textColor = color_989898;
        [self addSubview:self.userNameLabel];
        
        self.imv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 73, 280, 0.5)];
        self.imv.image = [UIImage imageNamed:@"dotted_line.png"];
        [self addSubview:self.imv];
        
        
        self.CommentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(240, 52, 87, 21)];
        self.CommentTimeLabel.font = defFont(NO, 11);
        self.CommentTimeLabel.textColor = color_989898;
        [self addSubview:self.CommentTimeLabel];
        
        
        
        self.starRating = [[BQStarRatingView alloc]initWithFrame:CGRectMake(85, 48, 120, 24) numberOfStar:5 withStatue:1];
        [self addSubview:self.starRating];
        
        if (show) {
            self.TicketTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 280, 33)];
            self.TicketTitleLabel.font = defFont12;
            self.TicketTitleLabel.textColor = color_989898;
            [self addSubview:self.TicketTitleLabel];
            
            [UICommon Common_line:CGRectMake(0, 100, 320, 0.5) targetView:self backColor:color_d1d1d1];

        }
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
