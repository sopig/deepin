//
//  TableCell_Common.h
//  BoqiiLife
//
//  Created by YSW on 14-5-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

//  --  生活馆 ：通用cell样式1
@interface TableCell_Common1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ProductImg;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_salePrice;
@property (weak, nonatomic) IBOutlet UILabel *lbl_marketPrice;
@property (strong, nonatomic) UILabel *lbl_delLine;
@property (weak, nonatomic) IBOutlet UILabel *lbl_awayFrom;
@property (weak, nonatomic) IBOutlet UILabel *lbl_roadName;
//@property (strong, nonatomic) UILabel *lblLine;

- (void)setTitleFrame:(NSString *) _titletxt;
@end


//  --  生活馆 ：通用cell样式2
@interface TableCell_Common2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ProductImg;
@property (weak, nonatomic) IBOutlet UILabel *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel *lbl_perPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbl_viewTimes;
@property (weak, nonatomic) IBOutlet UILabel *lbl_awayFrom;
@property (weak, nonatomic) IBOutlet UILabel *lbl_roadName;

@property (strong, nonatomic) UIImageView * icon_quan;
@property (strong, nonatomic) UIImageView * icon_renzhen;
@property (strong, nonatomic) UIImageView * icon_minxing;
//@property (strong, nonatomic) UILabel *lblLine;


- (void) setIconFrame_QuanYi:(NSString *) _lbltitle Characteristic:(NSString*) _characteristic;
@end


//  --  商城 ：列表通用cell样式1
@interface TableCell_MallProductList1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mallProductImg;
@property (weak, nonatomic) IBOutlet UILabel *lbl_mallTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbl_mallPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbl_mallMarketPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbl_mallSoldNum;

@property (strong, nonatomic) UILabel * lbl_priceDelLine;
@property (strong, nonatomic) UILabel * lbl_cellSpaceLine;
@property (strong, nonatomic) UIView  * viewActivity;

- (void)setTitleFrame:(NSString *) _titletxt;
- (void)setActivityTag:(NSString *) activitytags colorAndNames:(NSMutableDictionary*) _dic;
@end