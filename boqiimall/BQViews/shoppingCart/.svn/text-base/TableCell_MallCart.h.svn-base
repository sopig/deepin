//
//  TableCell_MallCart.h
//  BoqiiLife
//
//  Created by YSW on 14-6-24.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TableCell_CartDelegate <NSObject>
@optional
- (void) onDelegateCellRowProductChecked:(id) cell ischecked:(BOOL) _ischeck;
- (void) onDelegateChangeProNumClick:(id) cell;
- (void) onDelegateShowOrHideGiftClick:(id) cell;
- (void) onDelegateGiftClick:(NSString*) giftid;
@end



@interface TableCell_MallCart : UITableViewCell<UIScrollViewDelegate>{
    BOOL  IsCheckedRow;
    int   heightGiftArea;
}

@property (assign, nonatomic) id<TableCell_CartDelegate> cartDelegate;
@property (weak, nonatomic) IBOutlet UIImageView    *productIMG;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_title;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_salePrice;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_proSpec;
@property (weak, nonatomic) IBOutlet UILabel        *lbl_prono;

@property (weak, nonatomic) IBOutlet UIButton       *btn_check;
@property (weak, nonatomic) IBOutlet UIButton       *btn_proNum;


@property (strong, nonatomic) UIView        * viewGift;
@property (strong, nonatomic) UIView        * viewProductList;
@property (strong, nonatomic) UIButton      * btnGiftHead;
@property (strong, nonatomic) UIImageView   * IconBtnRight;
@property (strong, nonatomic) UIScrollView  * scrollViewGift;
@property (strong, nonatomic) NSMutableArray    *  arrGifts;

@property (assign, nonatomic) BOOL  IsOpenGiftView;

- (void) setTitleFrame:(NSString *) _titletxt;
- (void) setGiftData:(NSMutableArray *) _arrData;

- (void)setCellRowCheckStatus:(BOOL) _bool;
@end
