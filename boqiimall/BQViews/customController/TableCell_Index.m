//
//  TableCell_Index.m
//  BoqiiLife
//
//  Created by YSW on 14-5-4.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "TableCell_Index.h"

@implementation TableCell_Index
@synthesize btn_1678;
@synthesize btn_1679;
@synthesize btn_1680;
@synthesize btn_1681;
@synthesize delegate;
@synthesize btn_CategoryName;
@synthesize imgBg;

#define tagNum  1678

- (void)awakeFromNib {
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];   //  设置背景色为透明，否则ios7
    self.contentView.backgroundColor = [UIColor clearColor];    //  设置背景色为透明，否则ios7
    
    
    [arrBtn removeAllObjects];
    arrBtn = [[NSMutableArray alloc] initWithObjects:self.btn_1678,self.btn_1679,self.btn_1680,self.btn_1681, nil];
    for (UIButton * tmBtn in arrBtn) {
        [tmBtn setTitle:@"" forState:UIControlStateNormal];
        [tmBtn setBackgroundColor:[UIColor whiteColor]];
        [tmBtn.titleLabel setFont: defFont16];
        [tmBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }

    UIImageView * bgTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.btn_CategoryName.frame.size.width, 5)];
    [bgTop setBackgroundColor:[UIColor clearColor]];
    [bgTop setImage:[UIImage imageNamed:@"bg_dingpeng"]];
    [self.btn_CategoryName addSubview:bgTop];
    
    imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(3, 33, 146/2, 88/2)];
    [imgBg setBackgroundColor:[UIColor clearColor]];
    [imgBg setImage:[UIImage imageNamed:@"title_dog"]];
    [self.btn_CategoryName addSubview:imgBg];
    UIImageView *imgMore = [[UIImageView alloc] initWithFrame:CGRectMake(self.btn_CategoryName.frame.size.width-22, 80, 16, 16)];
    [imgMore setBackgroundColor:[UIColor clearColor]];
    [imgMore setImage:[UIImage imageNamed:@"icon_more"]];
    [self.btn_CategoryName addSubview:imgMore];
    
    //  -- more分类背影色：ff8a04
    [self.btn_CategoryName setTag:79309324];
    [self.btn_CategoryName setBackgroundColor:[UIColor convertHexToRGB:@"ff8a04"]];
    [self.btn_CategoryName addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

    [arrBtn addObject:self.btn_CategoryName];
}

- (void)bindDataCates:(NSString *) _title dicData:(NSMutableArray*) _dic{

    arrData = nil;
    arrData = [_dic mutableCopy];
    int i=0;
    for (NSString * sValue in arrData) {
        NSArray * arrTmp = [sValue componentsSeparatedByString:@"|"];
        [arrBtn[i] setTag: tagNum + i];
        if (i==4) {
            [self.imgBg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",arrTmp[1]]]];
        }
        else{
            [arrBtn[i] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",arrTmp[1]]] forState:UIControlStateNormal];
            [arrBtn[i] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlight",arrTmp[1]]] forState:UIControlStateHighlighted];
        }
        i++;
    }
}

//  --  action
- (void)btnAction:(id) sender{
    
    UIButton * tmpBtn = (UIButton*)sender;
    if (arrData) {
        NSArray * arrinfo = [arrData[tmpBtn.tag-tagNum] componentsSeparatedByString:@"|"];
        if ([self.delegate respondsToSelector:@selector(onServiceCategoryClick:CatesID:)]) {
            [self.delegate onServiceCategoryClick:arrinfo[3]
                                          CatesID:arrinfo[2]];
        }
    }
}
@end






@implementation TableCell_Hot
@synthesize img_Logo;
@synthesize lbl_Title;
@synthesize lbl_SalePrice;
@synthesize lbl_MarketPrice;
@synthesize lbl_delLine;
@synthesize lbl_buyTimes;
@synthesize lblLine;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}

- (void)awakeFromNib {
    self.accessoryType = UITableViewCellAccessoryNone;
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];   //  设置背景色为透明，否则ios7
    self.contentView.backgroundColor = [UIColor clearColor];    //  设置背景色为透明，否则ios7
    
    img_Logo.layer.borderColor = color_d1d1d1.CGColor;
    img_Logo.layer.borderWidth = 0.5;
    [img_Logo setBackgroundColor:[UIColor whiteColor]];

    [self.lbl_Title setTextColor: color_333333];
    [self.lbl_Title setFont: defFont14];
    
    [self.lbl_SalePrice     setTextColor:color_fc4a00];
    [self.lbl_MarketPrice   setTextColor:color_b3b3b3];
    [self.lbl_buyTimes      setTextColor:color_717171];
    [self.lbl_buyTimes  setTextAlignment:NSTextAlignmentRight];
    [self.lbl_delLine   setBackgroundColor:color_b3b3b3];
    
    lblLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, __MainScreen_Width, 0.5)];
    [lblLine setBackgroundColor:color_d1d1d1];
    [self addSubview:lblLine];
}

- (void)bindData:(resMod_IndexHotInfo *) dataInfo {
    
    NSString * productImg = [BQ_global convertImageUrlString:kImageUrlType_100x70 withurl:dataInfo.TicketImg];
    [self.img_Logo sd_setImageWithURL:[NSURL URLWithString:productImg]
                     placeholderImage:[UIImage imageNamed:@"placeHold_100x70.png"]];
    


    NSString * strMarketPrice = [NSString stringWithFormat:@"%.2f元",dataInfo.TicketOriPrice];
    
    [self.lbl_Title setText: dataInfo.TicketTitle];
    CGSize fSize = [dataInfo.TicketTitle sizeWithFont:defFont14 constrainedToSize:CGSizeMake(self.lbl_Title.frame.size.width, MAXFLOAT)];
    [self.lbl_Title setFrame:CGRectMake(self.lbl_Title.frame.origin.x,
                                        self.lbl_Title.frame.origin.y,
                                        self.lbl_Title.frame.size.width,
                                        fSize.height>40 ? 40:fSize.height)];
    
    [self.lbl_SalePrice   setText: [NSString stringWithFormat:@"%.2f元",dataInfo.TicketPrice]];
    [self.lbl_MarketPrice setText: strMarketPrice];
    [self.lbl_buyTimes setText:[NSString stringWithFormat:@"%d人购买",dataInfo.TicketBuyed]];
    
    //  -- 删除线
    CGSize tSizeSalePrice = [lbl_SalePrice.text sizeWithFont:defFont14 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    CGSize tSize = [strMarketPrice sizeWithFont:defFont12 constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    [lbl_MarketPrice setFrame:CGRectMake(lbl_SalePrice.frame.origin.x+tSizeSalePrice.width+15, lbl_MarketPrice.frame.origin.y, tSize.width, 20)];
    [lbl_delLine setFrame:CGRectMake(lbl_MarketPrice.frame.origin.x-2, lbl_MarketPrice.frame.origin.y+10, tSize.width+4, 1)];
}

- (void)resetSubViewFrame:(float) _offset {
    [self.img_Logo setFrame:
     CGRectMake(self.img_Logo.frame.origin.x, self.img_Logo.frame.origin.y+_offset, self.img_Logo.frame.size.width, self.img_Logo.frame.size.height-_offset)];
    
    [self.lbl_Title setFrame:
     CGRectMake(self.lbl_Title.frame.origin.x, self.lbl_Title.frame.origin.y+_offset, self.lbl_Title.frame.size.width, self.lbl_Title.frame.size.height)];
    
    [self.lbl_SalePrice setFrame:
     CGRectMake(self.lbl_SalePrice.frame.origin.x, self.lbl_SalePrice.frame.origin.y+_offset, self.lbl_SalePrice.frame.size.width, self.lbl_SalePrice.frame.size.height)];
    
    [self.lbl_MarketPrice setFrame:
     CGRectMake(self.lbl_MarketPrice.frame.origin.x, self.lbl_MarketPrice.frame.origin.y+_offset, self.lbl_MarketPrice.frame.size.width, self.lbl_MarketPrice.frame.size.height)];
    
    [self.lbl_delLine setFrame:
     CGRectMake(self.lbl_delLine.frame.origin.x, self.lbl_delLine.frame.origin.y+_offset, self.lbl_delLine.frame.size.width, self.lbl_delLine.frame.size.height)];
    
    [self.lbl_buyTimes setFrame:
     CGRectMake(self.lbl_buyTimes.frame.origin.x, self.lbl_buyTimes.frame.origin.y+_offset, self.lbl_buyTimes.frame.size.width, self.lbl_buyTimes.frame.size.height)];
    
    [self.lblLine setFrame:
     CGRectMake(self.lblLine.frame.origin.x, self.lblLine.frame.origin.y+_offset, self.lblLine.frame.size.width, self.lblLine.frame.size.height)];
}

@end