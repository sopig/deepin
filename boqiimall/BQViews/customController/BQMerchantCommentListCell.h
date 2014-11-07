//
//  BQMerchantCommentListCell.h
//  boqiimall
//
//  Created by 张正超 on 14-7-18.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQStarRatingView.h"
@interface BQMerchantCommentListCell : UITableViewCell

@property(nonatomic,readwrite,strong)UILabel *contentLabel;
@property(nonatomic,readwrite,strong)UILabel *userNameLabel;
@property(nonatomic,readwrite,strong)UIImageView  *imv;
@property(nonatomic,readwrite,strong)UILabel  *CommentTimeLabel;
@property(nonatomic,readwrite,strong)BQStarRatingView* starRating;
@property(nonatomic,readwrite,strong)UILabel* TicketTitleLabel;

@property(nonatomic,readwrite,assign)CGFloat contentLabelHeight;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier showTicketTitle:(BOOL)show withHeight:(CGFloat)height addTargetView:(UIView*)targetView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier showTicketTitle:(BOOL)show;

@end
