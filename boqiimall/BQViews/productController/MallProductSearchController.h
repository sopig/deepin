//
//  MallProductSearchController.h
//  BoqiiLife
//
//  Created by YSW on 14-6-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "BQISegmentedControl.h"

@interface MallProductSearchController : BQIBaseViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,BQISegmentedControlDelegate>{
    
    UITableView * rootTableView;
    
    UIView * dropDownView;
    UITextField * searchText;
    
    UIButton * btnSelClassfy;
    
    NSMutableArray * arrCategoryType;
    NSArray * arrHistory;
    NSMutableDictionary * dicParams;
    
    int selCateID;
    
    
    UIView *segmentedControlBgView;
    NSMutableArray *searchKeyWordsArray;
    NSMutableArray *showSearchKeyWordsArray;
    NSMutableArray *alreadyShowedKeyWordsArray;
    UITableView *searchTableView;
    NSInteger segmentedSelectedIndex;
    BQISegmentedControl *mySegementController ;
    
    NSMutableArray *searchResponseKeyWordsArray;
    
    
    
}
@property (strong,nonatomic) NSString * sHistory;
@property (strong,nonatomic) NSString * selCateName;
@end
