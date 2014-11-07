//
//  TableCell_Index.h
//  BoqiiLife
//
//  Created by YSW on 14-5-4.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "resMod_IndexData.h"

//--    服务和商户
typedef enum {
    CategoryAnimal,
    CategoryKeyword
} serviceType;

@protocol TableCell_IndexDelegate <NSObject>
@optional
- (void) onServiceCategoryClick:(NSString*) umengEventID CatesID:(NSString*) categroyID;
@end



@interface TableCell_Index : UITableViewCell{
    NSMutableArray * arrBtn;
    NSMutableArray * arrData;
}

@property (assign,nonatomic) id<TableCell_IndexDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *btn_1678;
@property (weak, nonatomic) IBOutlet UIButton *btn_1679;
@property (weak, nonatomic) IBOutlet UIButton *btn_1680;
@property (weak, nonatomic) IBOutlet UIButton *btn_1681;
@property (weak, nonatomic) IBOutlet UIButton *btn_CategoryName;
@property (strong, nonatomic) UIImageView * imgBg;


- (void)bindDataCates:(NSString *) _title dicData:(NSMutableArray*) _dic;
@end







//  --  热门与团购
@interface TableCell_Hot : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView * img_Logo;
@property (weak, nonatomic) IBOutlet UILabel    * lbl_Title;
@property (weak, nonatomic) IBOutlet UILabel    * lbl_SalePrice;
@property (weak, nonatomic) IBOutlet UILabel    * lbl_MarketPrice;
@property (weak, nonatomic) IBOutlet UILabel    * lbl_delLine;
@property (weak, nonatomic) IBOutlet UILabel    * lbl_buyTimes;
@property (strong, nonatomic) UILabel * lblLine;

- (void)bindData:(resMod_IndexHotInfo *) dataInfo;
- (void)resetSubViewFrame:(float) _offset;
@end

