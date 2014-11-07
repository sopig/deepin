//
//  ChangeBuyOrActionView.h
//  boqiimall
//
//  Created by ysw on 14-10-21.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "resMod_Mall_ShoppingCart.h"

typedef NS_ENUM(NSUInteger, CHANGETYPE) {
    CHANGEBUYPRODUCT,
    CHANGEACTION
};

//  -- cell delegate
@protocol ChangeBuyOrActionViewDelegate <NSObject>
- (void) onDelegateChangeActionDidChecked:(NSMutableDictionary*) apiParams;
@end


@interface ChangeBuyOrActionView : UIView<UITableViewDelegate,UITableViewDataSource>{
    
    UIView * headview;
    UIButton * backMaskView;
    UITableView * rootTableView;
}
@property (assign, nonatomic) CHANGETYPE changetype;
@property (assign, nonatomic) id<ChangeBuyOrActionViewDelegate> delegateChangeBuy;
@property (nonatomic, strong) resMod_Mall_CartChangeBuyList * ChangeData;

@property (nonatomic) int   pGoodsId;
@property (nonatomic) int   pGoodsType;
@property (nonatomic) float pGroupPrice;
@property (strong,nonatomic)  NSString * pGoodsSpecId;

@property (nonatomic) int pActionId;
@property (nonatomic) int pChangeBuyId;

- (void) tabReloadData:(resMod_Mall_CartChangeBuyList *) p_changedata;
- (void) resetFrame:(CGRect) frame;
@end
