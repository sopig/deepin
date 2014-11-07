//
//  TableCell_MallComment.h
//  boqiimall
//
//  Created by YSW on 14-7-15.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableCellMallCommentDelegate <NSObject>

@optional
- (void) onDelegateScoreButtonClick:(UITableViewCell *) selCell;
- (void) onDelegateCommentContentChanged:(UITableViewCell*) cell;
@end


@interface TableCell_MallComment : UITableViewCell<UITextViewDelegate>
@property (assign, nonatomic) id<TableCellMallCommentDelegate> commentDelegate;
@property (weak, nonatomic) IBOutlet UIImageView * productIMG;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ProductTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ProductPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbl_ProductMarketPrice;
@property (weak, nonatomic) IBOutlet UITextView * txt_Content;
@property (weak, nonatomic) IBOutlet UILabel *lbl_score;
@property (weak, nonatomic) IBOutlet UILabel *lbl_mjpf;
@property (weak, nonatomic) IBOutlet UILabel *lbl_spms;
@property (weak, nonatomic) IBOutlet UILabel *lbl_fwmyd;
@property (weak, nonatomic) IBOutlet UILabel *lbl_fhsd;

@property (strong, nonatomic) UILabel *lbl_marketLine;
@property (weak, nonatomic) IBOutlet UITextField * txtViewPlaceHold;

@property (assign, nonatomic) int iscore_spms;
@property (assign, nonatomic) int iscore_fwmyd;
@property (assign, nonatomic) int iscore_fhsd;

- (void) setScore:(float) _score;
@end
