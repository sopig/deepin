//
//  MallProductFilterView.h
//  boqiimall
//
//  Created by YSW on 14-6-26.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EC_ButtonForMallProFilter : UIButton
@property (assign,nonatomic) int btnSection;
@property (assign,nonatomic) BOOL isOpen;
@property (strong,nonatomic) UIImageView * rightIconImg;
- (void) setRightIcon:(NSString *) iconName;
- (void) setBtnRightIcon;
@end


@protocol MallProductFilterViewDelegate <NSObject>

@optional
- (void) ShowMPFilterView:(BOOL) _isShow;
- (void) onDelegateProductFilter;

@end



@interface MallProductFilterView : UIView<UITableViewDelegate,UITableViewDataSource>{
    UIView * topView;
    UITableView * filterTableview;
    
    NSMutableDictionary * dicSectionRows;
}

@property (assign,nonatomic) id<MallProductFilterViewDelegate> MPFDelegate;

@property (strong,nonatomic) NSMutableDictionary * dicFilterData;

- (void)isExpansionMpFilterView:(BOOL) _bool;
@end
