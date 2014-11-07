//
//  BQTicketCommentTableViewCell.m
//  boqiimall 
//
//  Created by 张正超 on 14-7-17.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQTicketCommentTableViewCell.h"

//#import "BQIndicatorView.h"

@implementation BQIndicator

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        isSet = NO;
        backView = [[UIView alloc]initWithFrame:self.bounds];
        backView.layer.cornerRadius = 2.0f;
        backView.backgroundColor = color_bodyededed;
        [self addSubview:backView];
        
        
        foreView = [[UIView alloc]initWithFrame:self.bounds];
        foreView.backgroundColor = color_fc4a00;
        foreView.layer.cornerRadius = 2.0f;
    }
    return self;
}

- (void)setScoreValue:(float)scoreValue
{
    [foreView removeFromSuperview];

    foreView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 0, self.bounds.size.height);
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        foreView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, scoreValue*self.bounds.size.width/5, self.bounds.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
    [self addSubview:foreView];
    
}

@end

@implementation BQTicketCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *greateMarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(11, 10, 81, 30)];
        greateMarkLabel.text = @"好评度";
        greateMarkLabel.font = defFont15;
        greateMarkLabel.textColor = [UIColor convertHexToRGB:@"383838"];
        [self addSubview:greateMarkLabel];
        
        [UICommon Common_line:CGRectMake(0, 51, self.bounds.size.width, 1) targetView:self backColor:color_ededed];
        

        UILabel *professionLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 77.5 - 7, 76, 14)];
        professionLabel.text = @"专 业 度 :";
        professionLabel.font = defFont14;
        professionLabel.textColor = [UIColor convertHexToRGB:@"989898"];
        
//        professionLabel.layer.borderColor = [UIColor blackColor].CGColor;
//        professionLabel.layer.borderWidth = 1;
        [self addSubview:professionLabel];
        
        UILabel *envLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 111 -7, 76, 14)];
        envLabel.text = @"服务环境:";
        envLabel.font = defFont14;
        envLabel.textColor = [UIColor convertHexToRGB:@"989898"];
        
//        envLabel.layer.borderColor = [UIColor blackColor].CGColor;
//        envLabel.layer.borderWidth = 1;
        [self addSubview:envLabel];
        
        UILabel *attiLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 144.5 - 7, 76, 14)];
        attiLabel.text = @"服务态度:";
        attiLabel.font = defFont14;
        attiLabel.textColor = [UIColor convertHexToRGB:@"989898"];
        
//        attiLabel.layer.borderColor = [UIColor blackColor].CGColor;
//        attiLabel.layer.borderWidth = 1;
        [self addSubview:attiLabel];
        
        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(9, 178 - 7, 76, 14)];
        priceLabel.text = @"价格满意:";
        priceLabel.font = defFont14;
        priceLabel.textColor = [UIColor convertHexToRGB:@"989898"];
        
//        priceLabel.layer.borderColor = [UIColor blackColor].CGColor;
//        priceLabel.layer.borderWidth = 1;
        [self addSubview:priceLabel];
        
        
        //
        
        self.professionScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(269 , 77.5 - 7  , 42, 14)];
        self.professionScoreLabel.font = defFont14;
        self.professionScoreLabel.textColor = [UIColor convertHexToRGB:@"989898"];
        [self addSubview:self.professionScoreLabel];
        
        self.envScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(269 , 111 - 7, 35, 14)];
        self.envScoreLabel.font = defFont14;
        self.envScoreLabel.textColor = [UIColor convertHexToRGB:@"989898"];
         [self addSubview:self.envScoreLabel];
        
        self.attiScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(269 , 144.5 - 7, 35, 14)];
        self.attiScoreLabel.font = defFont14;
        self.attiScoreLabel.textColor = [UIColor convertHexToRGB:@"989898"];
         [self addSubview:self.attiScoreLabel];
        

        self.priceScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(269 , 178 - 7, 35, 14)];
        self.priceScoreLabel.font = defFont14;
        self.priceScoreLabel.textColor = [UIColor convertHexToRGB:@"989898"];
         [self addSubview:self.priceScoreLabel];
        
        //
        self.professionScoreIndicator = [[BQIndicator alloc]initWithFrame:CGRectMake(87 ,77.5 - 7, 174, 14)];
        [self addSubview: self.professionScoreIndicator];
        
        self.envScoreIndicator = [[BQIndicator alloc]initWithFrame:CGRectMake(87 , 111 - 7, 174, 14)];
        [self addSubview:self.envScoreIndicator];
        
        self.attiScoreIndicator = [[BQIndicator alloc]initWithFrame:CGRectMake(87 , 144.5 - 7, 174, 14)];
        [self addSubview:self.attiScoreIndicator];
        
        self.priceScoreIndicator = [[BQIndicator alloc]initWithFrame:CGRectMake(87 , 178 - 7, 174, 14)];
        [self addSubview:self.priceScoreIndicator];
        
//        [UICommon Common_line:CGRectMake(0, 225.5, 320, 1) targetView:self backColor:color_ededed];
        
        [UICommon Common_line:CGRectMake(0, 204.5, 320, 1) targetView:self backColor:color_ededed];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
