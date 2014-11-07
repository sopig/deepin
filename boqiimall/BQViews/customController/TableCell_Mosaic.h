//
//  TableCell_Mosaic.h
//  boqiimall
//
//  Created by YSW on 14-7-2.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableCellMosaicDelegate <NSObject>

@optional
- (void) onMosaicButtonClick:(int) type requestUrl:(NSString*) sUrl;

@end

//  --  EC_MOSAIC Button
@interface EC_MosaicButton : UIButton
@property (assign,nonatomic) int itype;
@property (strong,nonatomic) NSString * apiUrl;
@property (strong,nonatomic) UIImageView * mosaicImg;

- (void) setMosaicImgFrame;
- (void) setMosaicImgURL:(NSString*) _surl;
@end



//  --  mosaic
@interface TableCell_Mosaic : UITableViewCell

@property (strong,nonatomic) NSArray * arrbtns;

@property (assign,nonatomic) id<TableCellMosaicDelegate> cellMosaicDelegate;
@property (assign,nonatomic) int iMosaicType;
@property (strong,nonatomic) NSMutableArray * arrMosaicData;

@property (strong,nonatomic) EC_MosaicButton * BtnImg0;
@property (strong,nonatomic) EC_MosaicButton * BtnImg1;
@property (strong,nonatomic) EC_MosaicButton * BtnImg2;
@property (strong,nonatomic) EC_MosaicButton * BtnImg3;
@property (strong,nonatomic) EC_MosaicButton * BtnImg4;
@property (strong,nonatomic) EC_MosaicButton * BtnImg5;
@property (strong,nonatomic) EC_MosaicButton * BtnImg6;
@property (strong,nonatomic) EC_MosaicButton * BtnImg7;
@property (strong,nonatomic) EC_MosaicButton * BtnImg8;
@property (strong,nonatomic) EC_MosaicButton * BtnImg9;

- (void) bindDataBytype:(int) ptype datainfo:(NSMutableArray *) pmosaicdata;
@end
