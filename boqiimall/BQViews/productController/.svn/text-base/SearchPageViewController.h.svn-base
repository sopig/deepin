//
//  SearchPageViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-14.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "BQISegmentedControl.h"


@interface SearchPageViewController : BQIBaseViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,BQISegmentedControlDelegate>{
    
    UILabel * lbl_NoData;
    UITableView * rootTableView;
    
    UITextField * searchText;
    
    NSArray * arrHistory;
    NSUserDefaults *userDefaults;
    NSMutableDictionary * dicParams;
    
    
    
    UIView *segmentedControlBgView;
    NSMutableArray *searchKeyWordsArray;
    NSMutableArray *showSearchKeyWordsArray;
    NSMutableArray *alreadyShowedKeyWordsArray;
    UITableView *searchTableView;
    NSInteger segmentedSelectedIndex;
    BQISegmentedControl *mySegementController ;
    
    
    NSString *checkedCityID;
    
  
}
@property(strong,nonatomic) NSString *checkedCityID;

@property (strong,nonatomic) NSString * sHistory;


- (void)goApiRequest_getSearchKeyWordsList;

@end
