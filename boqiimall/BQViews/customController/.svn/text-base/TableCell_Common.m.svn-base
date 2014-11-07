//
//  TableCell_Common.m
//  BoqiiLife
//
//  Created by YSW on 14-5-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "TableCell_Common.h"

@implementation TableCell_Common1
@synthesize ProductImg;
@synthesize lbl_title;
@synthesize lbl_awayFrom;
@synthesize lbl_salePrice;
@synthesize lbl_marketPrice;
@synthesize lbl_delLine;
@synthesize lbl_roadName;

- (void)awakeFromNib
{
    [self.lbl_title setTextColor: color_333333];
    [self.lbl_title setFont: defFont14];
    
    [self.lbl_salePrice     setTextColor:color_fc4a00];
    [self.lbl_marketPrice   setTextColor:color_b3b3b3];
    [self.lbl_awayFrom      setTextColor:color_717171];
    [self.lbl_roadName      setTextColor:color_717171];
    
    [self.ProductImg setFrame:CGRectMake(10, 10, 100, 70)];
    [self.ProductImg setBackgroundColor:[UIColor whiteColor]];
    self.ProductImg.layer.borderColor = color_d1d1d1.CGColor;
    self.ProductImg.layer.borderWidth = 0.5;

    
    lbl_delLine = [[UILabel alloc] init];
    [lbl_delLine setFrame:CGRectMake(lbl_marketPrice.frame.origin.x-2, lbl_marketPrice.frame.origin.y+10,50, 1)];
    [lbl_delLine setBackgroundColor:color_b3b3b3];
    [lbl_delLine setHidden:self.lbl_marketPrice.hidden];
    [self addSubview:lbl_delLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setTitleFrame:(NSString *) _titletxt{
    CGSize tSize = [_titletxt sizeWithFont:defFont14 constrainedToSize:CGSizeMake(self.lbl_title.frame.size.width, MAXFLOAT)];
    [self.lbl_title setFrame:CGRectMake(self.lbl_title.frame.origin.x,
                                        self.lbl_title.frame.origin.y+2,
                                        self.lbl_title.frame.size.width,
                                        tSize.height>40 ? 40:tSize.height)];
}

@end


@implementation TableCell_Common2
@synthesize ProductImg;
@synthesize lbl_title;
@synthesize lbl_perPrice;
@synthesize lbl_viewTimes;
@synthesize lbl_awayFrom;
@synthesize lbl_roadName;
//@synthesize lblLine;

- (void)awakeFromNib {

    [self.lbl_title setBackgroundColor:[UIColor clearColor]];
    [self.lbl_title setTextColor: color_333333];
    [self.lbl_title setFont: defFont14];
    
    [self.lbl_perPrice      setTextColor:color_fc4a00];
    [self.lbl_viewTimes     setTextColor:color_717171];
    [self.lbl_awayFrom      setTextColor:color_717171];
    [self.lbl_roadName      setTextColor:color_717171];
    

    [self.ProductImg setFrame:CGRectMake(10, 10, 100, 70)];
    [self.ProductImg setBackgroundColor:[UIColor whiteColor]];
    self.ProductImg.layer.borderColor = color_d1d1d1.CGColor;
    self.ProductImg.layer.borderWidth = 0.5;
    
    //  -- 有券
    self.icon_quan = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.icon_quan setBackgroundColor:[UIColor clearColor]];
    [self.icon_quan setImage:[UIImage imageNamed:@"icon_ticket1"]];
    [self addSubview:self.icon_quan];
    //  -- 认证商户
    self.icon_renzhen = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.icon_renzhen setBackgroundColor:[UIColor clearColor]];
    [self.icon_renzhen setImage:[UIImage imageNamed:@"icon_ticket3"]];
    [self addSubview:self.icon_renzhen];
    //  -- 明星店铺
    self.icon_minxing = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.icon_minxing setBackgroundColor:[UIColor clearColor]];
    [self.icon_minxing setImage:[UIImage imageNamed:@"icon_ticket4"]];
    [self addSubview:self.icon_minxing];

//    lblLine = [[UILabel alloc] initWithFrame:CGRectMake(6, self.frame.size.height-1, __MainScreen_Width-6, 1)];
//    [lblLine setBackgroundColor:color_ededed];
//    [self addSubview:lblLine];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) setIconFrame_QuanYi:(NSString *) _lbltitle Characteristic:(NSString*) _characteristic{
    
    [self.icon_quan setHidden:YES];
    [self.icon_renzhen setHidden:YES];
    [self.icon_minxing setHidden:YES];
    
    //  -- 0,无，1,券，2,疫，3,认，4,明星店铺
    if (_characteristic || _characteristic.length>0){
        
        NSArray * arrCha = [_characteristic componentsSeparatedByString:@","];
        CGSize tSize = [_lbltitle sizeWithFont:defFont14 constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        BOOL b_haveQuan=NO;
        
        float crrWidth = __MainScreen_Width-20-102-8-22*arrCha.count;
        crrWidth = tSize.width > crrWidth ? crrWidth :tSize.width;
        if (tSize.width>crrWidth) {
            [self.lbl_title setFrame:CGRectMake(self.lbl_title.frame.origin.x,
                                                self.lbl_title.frame.origin.y,
                                                crrWidth,
                                                tSize.height>40 ? 40:tSize.height)];
        }
        float xpoint = self.lbl_title.frame.origin.x+crrWidth+ 5;
        for (NSString * svalue in arrCha) {
            if ([svalue isEqualToString:@"1"]) {
                b_haveQuan = YES;
                [self.icon_quan setHidden:NO];
                [self.icon_quan setFrame:CGRectMake(xpoint, self.lbl_title.frame.origin.y+(self.lbl_title.frame.size.height/2-8), 16, 16)];
            }
            if ([svalue isEqualToString:@"3"]) {
                [self.icon_renzhen setHidden:NO];
                xpoint = b_haveQuan ? xpoint+16+5 : xpoint;
                [self.icon_renzhen setFrame:CGRectMake(xpoint, self.lbl_title.frame.origin.y+(self.lbl_title.frame.size.height/2-8), 16, 16)];

            }
            if ([svalue isEqualToString:@"4"]) {
                [self.icon_minxing setHidden:NO];
                if (!self.icon_quan.hidden) {
                    xpoint += (self.icon_quan.hidden ? 0:CGRectGetWidth(self.icon_quan.frame)+5);
                }
                else{
                    xpoint += (self.icon_renzhen.hidden ? 0:CGRectGetWidth(self.icon_renzhen.frame)+5);
                }
                [self.icon_minxing setFrame:CGRectMake(xpoint, self.lbl_title.frame.origin.y+(self.lbl_title.frame.size.height/2-8), 16, 16)];
                
            }
        }
    }
}

@end



//  --  商城列表通用cell样式1
@implementation TableCell_MallProductList1
@synthesize mallProductImg,lbl_mallTitle,lbl_mallPrice,lbl_mallMarketPrice,lbl_mallSoldNum;
@synthesize lbl_priceDelLine,lbl_cellSpaceLine;
@synthesize viewActivity;

- (void)awakeFromNib {
    
    [self.mallProductImg setFrame:CGRectMake(12, 12, 75, 75)];
    [self.mallProductImg setBackgroundColor:[UIColor whiteColor]];
    self.mallProductImg.layer.borderWidth = 1;
    self.mallProductImg.layer.borderColor = color_dedede.CGColor;
    
    [self.lbl_mallTitle setTextColor:color_333333];
    
    [self.lbl_mallPrice setFont:defFont(YES, 15)];
    [self.lbl_mallPrice setTextColor:color_fc4a00];
    
    [self.lbl_mallMarketPrice setHidden:YES];
    [self.lbl_mallMarketPrice setFont:defFont13];
    [self.lbl_mallMarketPrice setTextColor:color_b3b3b3];
    
    lbl_priceDelLine = [[UILabel alloc] init];
    [lbl_priceDelLine setFrame:CGRectMake(lbl_mallMarketPrice.frame.origin.x-2,lbl_mallMarketPrice.frame.origin.y+10, 100, 1)];
    [lbl_priceDelLine setBackgroundColor:color_b3b3b3];
    [lbl_priceDelLine setHidden:self.lbl_mallMarketPrice.hidden];
    [self addSubview:lbl_priceDelLine];
    
    lbl_cellSpaceLine = [[UILabel alloc] init];
    [lbl_cellSpaceLine setFrame:CGRectMake(0, 0.5, self.frame.size.width, 0.5)];
    [lbl_cellSpaceLine setBackgroundColor:color_d1d1d1];
    [self addSubview:lbl_cellSpaceLine];
    
    self.viewActivity = [[UIView alloc] initWithFrame:CGRectMake(97, 50, __MainScreen_Width-97, 18)];
    [self.viewActivity setBackgroundColor:[UIColor clearColor]];
    [self.viewActivity setHidden:YES];
    [self addSubview:viewActivity];
}

- (void)setTitleFrame:(NSString *) _titletxt{
    CGSize tSize=[_titletxt sizeWithFont:defFont14 constrainedToSize:CGSizeMake(self.lbl_mallTitle.frame.size.width, MAXFLOAT)];
    [self.lbl_mallTitle setFrame:CGRectMake(self.lbl_mallTitle.frame.origin.x,
                                        self.lbl_mallTitle.frame.origin.y,
                                        self.lbl_mallTitle.frame.size.width,
                                        tSize.height>40 ? 40:tSize.height)];
    
    tSize=[self.lbl_mallMarketPrice.text sizeWithFont:defFont13 constrainedToSize:CGSizeMake(self.lbl_mallMarketPrice.frame.size.width, MAXFLOAT)];
    [self.lbl_priceDelLine setFrame:CGRectMake(lbl_mallMarketPrice.frame.origin.x-2,
                                               lbl_mallMarketPrice.frame.origin.y+11, tSize.width+6, 1)];
}

//  -- 活动标签
- (void)setActivityTag:(NSString *) activitytags colorAndNames:(NSMutableDictionary*) _dic{
    
    for (UILabel * lbltmp in self.viewActivity.subviews) { [lbltmp removeFromSuperview]; }
    if (activitytags == nil || activitytags.length==0) {
        return;
    }
    
    //  -- 当是3时表示 满减和折扣
    activitytags = [activitytags stringByReplacingOccurrencesOfString:@"3" withString:@"1,2"];
    NSArray * arrActs = [activitytags componentsSeparatedByString:@","];
    
    if (arrActs.count>0) {
        
        [self.viewActivity setFrame:CGRectMake(self.viewActivity.frame.origin.x, self.lbl_mallTitle.frame.origin.y+self.lbl_mallTitle.frame.size.height+4,self.viewActivity.frame.size.width, self.viewActivity.frame.size.height)];
        [self.viewActivity setHidden:NO];
        
        float xpoint = 0;
        for (int i=0; i<arrActs.count; i++) {
            NSString * s = arrActs[i];
            if (s.length>0) {
                NSString * CNStr = [_dic objectForKey:[NSString stringWithFormat:@"activity%@",arrActs[i]]];
                NSArray * arrCN = [CNStr componentsSeparatedByString:@"|"];
                CGSize tsize = [arrCN[0] sizeWithFont:defFont(NO, 11) constrainedToSize:CGSizeMake(MAXFLOAT, 17)];
                UILabel * lblActivity = [[UILabel alloc] initWithFrame:CGRectMake(xpoint, 0, tsize.width+4, 17)];
                [lblActivity setText:arrCN[0]];
                [lblActivity setBackgroundColor:[UIColor convertHexToRGB:arrCN[1]]];
                [lblActivity setFont:defFont(NO, 11)];
                [lblActivity setTextColor:[UIColor whiteColor]];
                [lblActivity setTextAlignment:NSTextAlignmentCenter];
                [self.viewActivity addSubview:lblActivity];
                
                xpoint += lblActivity.frame.size.width + 6;
            }
            else{
                [self.viewActivity setHidden:YES];
            }
        }
    }
    else{
        [self.viewActivity setHidden:YES];
    }
}
@end




