//
//  SearchPageViewController.m
//  BoqiiLife
//
//  Created by YSW on 14-5-14.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "SearchPageViewController.h"
#import "resMod_GetKeyWords.h"

#define heightCell  45
#define searchHistoryKey    @"kSearchPageHistory"
#define spaceTag    @"||boqiii||"
#define pkeyword     @"params_keyword"

#define SegmentedControlBgViewHeight  56
#define SegmentedControlHeight 30
#define SegmentedControlWidth 280
#define marginWidth 12
#define btnMarginWidth 20
#define nextBtnWidth 80
#define minHeight 18
#define intervalWidth 12



@implementation SearchPageViewController
@synthesize sHistory;
@synthesize checkedCityID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        userDefaults = [NSUserDefaults standardUserDefaults];
        dicParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"",pkeyword, nil];
        arrHistory = [[NSArray alloc] init];
        searchKeyWordsArray = [[NSMutableArray alloc] init];
        showSearchKeyWordsArray = [[NSMutableArray alloc] init];
        alreadyShowedKeyWordsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) goBack:(id)sender{
    [searchText resignFirstResponder];
    [super goBack:sender];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self tabBar_Hidden:self.tabBarController];
    
    // -- 客户端缓存历史
 

    
    if (segmentedSelectedIndex == 0)
    {
    
        [searchTableView setHidden:YES];
        arrHistory = nil;
        arrHistory = [[NSUserDefaults standardUserDefaults] arrayForKey:searchHistoryKey];
        if (arrHistory.count>0) {
//            NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:arrHistory];
//            arrHistory = [[tmpArray  reverseObjectEnumerator] allObjects];
            [lbl_NoData setHidden:YES];
            [self.noDataView setHidden:YES];
            [rootTableView setHidden:NO];
            [rootTableView reloadData];
        }
        else{
            [lbl_NoData setHidden:NO];
            [self.noDataView noDataViewIsHidden:NO warnImg:@"" warnMsg:@"搜索记录为空或被清除！"];
            [rootTableView setHidden:YES];
            [rootTableView reloadData];
        }
    }
    else if (segmentedSelectedIndex == 1)
    {
        [rootTableView setHidden:YES];
        NSInteger count = 0;
        for (NSInteger i = 0; i < [showSearchKeyWordsArray count]; i++)
        {
            if ([showSearchKeyWordsArray count] != 0)
            {
                count++;
            }
        }
        
        
        if (count == 0)
        {
            [self.noDataView noDataViewIsHidden:NO warnImg:@"" warnMsg:@"暂无搜索关键字！"];
            [searchTableView setHidden:YES];
            [searchTableView reloadData];
        }
        else
        {
            [self.noDataView setHidden:YES];
            [searchTableView setHidden:NO];
            [searchTableView reloadData];
        }

    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@""];
    [self.view setBackgroundColor: color_bodyededed];
    
   // [self addSearchView];
    
    lbl_NoData = [[UILabel alloc]initWithFrame:CGRectMake(0,kNavBarViewHeight, __MainScreen_Width, 60.0)];
    lbl_NoData.numberOfLines = 0;
    [lbl_NoData setTextAlignment:NSTextAlignmentCenter];
    [lbl_NoData setBackgroundColor:[UIColor clearColor]];
    [lbl_NoData setFont:[UIFont systemFontOfSize:13]];
    [lbl_NoData setTextColor:color_717171];
    [lbl_NoData setHidden:YES];
    [lbl_NoData setText:@"您的搜索记录将出现这里哦！"];
    [self.view addSubview:lbl_NoData];
    
   // [self loadNavBarView];
    
    segmentedControlBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, SegmentedControlBgViewHeight)];
    [segmentedControlBgView setBackgroundColor:color_bodyededed];
    
    
    mySegementController = [[BQISegmentedControl alloc] initWithFrame:CGRectMake(marginWidth, 12, (__MainScreen_Width - marginWidth*2), SegmentedControlHeight) btntitle1:@"搜索历史" btn1Img:@"column_nav_btn_left_nor" btntitle2:@"大家都在搜" btn2Img:@"column_nav_btn_right_nor" img1Press:@"column_nav_btn_left_sel" img2press:@"column_nav_btn_right_sel"];
    [segmentedControlBgView addSubview:mySegementController];
 //   mySegementController.center = segmentedControlBgView.center;
    [mySegementController setDelegate:self];
    [self.view addSubview:segmentedControlBgView];
    
    
    searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SegmentedControlBgViewHeight+kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight-kNavBarViewHeight - SegmentedControlBgViewHeight) style:UITableViewStylePlain];
    [searchTableView setHidden:YES];
    [searchTableView setBackgroundColor: color_bodyededed];
    searchTableView.delegate = self;
    searchTableView.dataSource = self;
    searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [searchTableView setShowsVerticalScrollIndicator: NO];
    [self.view addSubview:searchTableView];

    rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SegmentedControlBgViewHeight+kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight-kNavBarViewHeight - SegmentedControlBgViewHeight) style:UITableViewStylePlain];
    [rootTableView setHidden:YES];
    [rootTableView setBackgroundColor: color_body];
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [rootTableView setShowsVerticalScrollIndicator: NO];
    [self.view addSubview:rootTableView];
    
    NSDictionary * checkedcity = [[PMGlobal shared] location_GetUserCheckedCity];
    self.checkedCityID = [checkedcity objectForKey:@"CityId"];

    [self goApiRequest_getSearchKeyWordsList];
}


- (void)loadNavBarView
{

    [super loadNavBarView];
    
    [self addSearchView];
}

#pragma --mark goApiRequest 

- (void)goApiRequest_getSearchKeyWordsList
{
    [[APIMethodHandle shareAPIMethodHandle] goApiRequestGetKeyWords:nil ModelClass:@"resMod_CallBack_GetKeyWords" showLoadingAnimal:NO hudContent:@"" delegate:self];
    
}

//-- 请求成功
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    
    
    if ([ApiName isEqualToString:kApiMethod_GetKeyWords]) {
       
        resMod_CallBack_GetKeyWords * backObj = [[resMod_CallBack_GetKeyWords alloc] initWithDic:retObj];
   
        for (NSInteger i = 0; i < [backObj ResponseData].count ; i++) {
            resMod_GetKeyWords *item = [[backObj ResponseData] objectAtIndex:i];
            
       
            if ([item.cityID isEqualToString:self.checkedCityID])
            {
                for (NSInteger j = 0; j < [item keyWordsArray].count; j++)
                {
                    [searchKeyWordsArray addObject:[[item keyWordsArray] objectAtIndex:j]];
                }
            }
        }
        
        [self updateSearchTableView];
    }
}


//-- 请求出错时
-(void)interfaceExcuteError:(NSError *)error apiName:(NSString *)ApiName {
    
    [super interfaceExcuteError:error apiName:ApiName];
}


#pragma --mark 打乱关键字数据

- (void)shuffle
{
    if (searchKeyWordsArray)
    {
        int count = [searchKeyWordsArray count];
        for (int i = 0; i < count; ++i) {
            int n = (arc4random() % (count - i)) + i;
            [searchKeyWordsArray exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
    }
}





-(void)updateSearchTableView
{
    
    [showSearchKeyWordsArray removeAllObjects];
    [alreadyShowedKeyWordsArray removeAllObjects];
    /*
    if (alreadyShowedKeyWordsArray.count == searchKeyWordsArray.count)
    {
        [alreadyShowedKeyWordsArray removeAllObjects];
    }
     */
    [self shuffle];
    

    
    for (NSInteger index = 0; index < 4; index++)
    {
        float totalTextLength = 0;
        float maxLength = (__MainScreen_Width - marginWidth*2);
        float minWidth = (maxLength - intervalWidth*3)/4.0;
        NSMutableArray *unitArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < [searchKeyWordsArray count]; i++)
        {
            NSString *keyword = [searchKeyWordsArray objectAtIndex:i];
            if ([alreadyShowedKeyWordsArray containsObject:keyword])
            {
                continue;
            }
            
            CGSize size = [keyword sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake((__MainScreen_Width - marginWidth*2                                                                                                             ), heightCell)];
            
            if (size.width+ btnMarginWidth <minWidth)
            {
                size.width = minWidth ;
            }
            else if (size.width >= (__MainScreen_Width - marginWidth*2))
            {
                size.width = __MainScreen_Width - marginWidth*2;
            }
            else if (size.width >= (__MainScreen_Width - marginWidth*2 - intervalWidth))
            {
                size.width = size.width;
            }
            else
            {
                size.width = size.width + btnMarginWidth;
                
            }
            
            if ((totalTextLength+ size.width  + intervalWidth*unitArray.count) > maxLength)
            {
                continue;
            }
            
            [unitArray addObject:keyword];
            totalTextLength = totalTextLength + size.width;
            [alreadyShowedKeyWordsArray addObject:keyword];
        }
        if ([unitArray count] != 0)
        {
            [showSearchKeyWordsArray addObject:unitArray];
        }
        unitArray = nil;
    }
    
    [searchTableView reloadData];
    
}



#pragma --mark button click
- (void) addSearchView{
    UIView * sView = [[UIView alloc] initWithFrame:CGRectMake(45, kStatusBarHeight+6, 260, 34)];
    [sView setBackgroundColor:color_dedede];
    sView.layer.cornerRadius = 3;
    
    UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake(8, 7, 20, 20)];
    [imgicon setImage:[UIImage imageNamed:@"icon_search"]];
    [sView addSubview:imgicon];
    
    searchText = [[UITextField alloc] initWithFrame:CGRectMake(32, 2, sView.frame.size.width-40, 30)];
    searchText.delegate = self;
    [searchText setBackgroundColor:[UIColor clearColor]];
    [searchText setPlaceholder:@"请输入搜索关键字"];
    [searchText setFont: defFont14];
    [searchText setReturnKeyType:UIReturnKeySearch];
    [searchText setTextAlignment:NSTextAlignmentLeft];
    [searchText setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    searchText.clearButtonMode=UITextFieldViewModeWhileEditing;
    [sView addSubview:searchText];
   // self.navigationItem.titleView = sView;
    [self.navBarView addSubview:sView];
    [searchText becomeFirstResponder];
    if (IOS7_OR_LATER) {    //--很奇葩的问题，ios7后光标没有了，所以加个这。。。。。。
        [searchText setTintColor:[UIColor blueColor]];
    }
}

//  --清除历史浏览记录
- (void)onClearButtonClick:(id) sender{
    [searchText resignFirstResponder];
    [userDefaults removeObjectForKey:searchHistoryKey];
    [userDefaults synchronize];
    arrHistory = nil;
    
    [self HUDShow:@"清除成功" delay:1.5];
    [lbl_NoData setHidden:NO];
    [rootTableView setHidden:YES];
    [rootTableView reloadData];
}

- (void)onNextButtonClick:(id)sender
{
    
    [self updateSearchTableView];
}

- (void)searchBtnAction:(UIButton *)sender
{
    [dicParams setValue:sender.titleLabel.text forKey:pkeyword];
    [self pushNewViewController:@"SMHomeListViewController"
                      isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:dicParams];
}


- (BOOL)allKeyWordsShowedOnce
{
    NSInteger count = 0;
    for (NSInteger i = 0; i < showSearchKeyWordsArray.count;i++)
    {
        NSArray *tempArray = [showSearchKeyWordsArray objectAtIndex:i];
        count += tempArray.count;
    }
    
    if (count == searchKeyWordsArray.count)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual: rootTableView])
    {
        return 1;
    }
    else
    {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:rootTableView])
    {
         return arrHistory.count;
    }
    else
    {
        
        
        NSInteger count = 0;
        
        for (NSInteger i = 0; i < [showSearchKeyWordsArray count]; i++)
        {
            if ([showSearchKeyWordsArray count] != 0)
            {
                count++;
            }
        }
        return count;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:rootTableView])
    {
        return heightCell;
        
    }
    else
    {
        return heightCell;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([tableView isEqual:rootTableView])
    {
         return heightCell;
    }
    else
    {
        NSInteger count = 0;
        for (NSInteger i = 0; i < [showSearchKeyWordsArray count]; i++)
        {
            if ([showSearchKeyWordsArray count] != 0)
            {
                count++;
            }
        }
        
        

            if ([self allKeyWordsShowedOnce])
            {
                return 0;
            }
            return  heightCell;
            
     
    }
   
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if ([tableView isEqual:rootTableView])
    {
        UIButton * btnClear = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnClear setFrame:CGRectMake(0, 0, __MainScreen_Width, heightCell)];
        [btnClear setBackgroundColor:[UIColor clearColor]];
        [btnClear setTitle:@"  清除搜索记录" forState:UIControlStateNormal];
        [btnClear.titleLabel setFont:defFont14];
        [btnClear setTitleColor:color_333333 forState:UIControlStateNormal];
        [btnClear setImage:[UIImage imageNamed:@"close_btn.png"] forState:UIControlStateNormal];
        [btnClear addTarget:self action:@selector(onClearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        return btnClear;
    }
    else
    {
        
        NSInteger count = 0;
        for (NSInteger i = 0; i < [showSearchKeyWordsArray count]; i++)
        {
            if ([showSearchKeyWordsArray count] != 0)
            {
                count++;
            }
        }
        
     
            if ([self allKeyWordsShowedOnce])
            {
                return nil;
            }
            
            
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightCell)];
            UIButton * btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
            [btnNext setFrame:CGRectMake((__MainScreen_Width - nextBtnWidth), 0, nextBtnWidth , heightCell)];
            [btnNext setBackgroundColor:[UIColor clearColor]];
            [btnNext setTitle:@"换一批" forState:UIControlStateNormal];
            [btnNext.titleLabel setFont:defFont14];
            btnNext.titleLabel.textAlignment = NSTextAlignmentRight;
            [btnNext setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btnNext addTarget:self action:@selector(onNextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [bgView addSubview:btnNext];
            return bgView;
  
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSString * cellIdentifier = @"identifiercell";
    if ([tableView isEqual:rootTableView])
    {
        
        UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if (cell==nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            UILabel * lbl_keyWord = [[UILabel alloc] initWithFrame:CGRectMake(15, 6, __MainScreen_Width, 30)];
            [lbl_keyWord setTag:1000];
            [lbl_keyWord setText:@"狗粮A"];
            [lbl_keyWord setBackgroundColor:[UIColor clearColor]];
            [lbl_keyWord setFont: defFont14];
            [lbl_keyWord setTextColor:color_333333];
            [cell.contentView addSubview:lbl_keyWord];
            
            //[cell setBackgroundColor:color_bodyededed];
            
            [UICommon Common_line:CGRectMake(0, heightCell-1, __MainScreen_Width, 1) targetView:cell.contentView backColor:color_body];
        }
        
        if (arrHistory.count>0) {
            UILabel * lbl_1000 = (UILabel*)[cell.contentView viewWithTag:1000];
            [lbl_1000 setText:arrHistory[indexPath.row]];
        }
        
        [cell setBackgroundColor: color_bodyededed];
        [cell.contentView setBackgroundColor:color_bodyededed];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }
    else {
        UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if (cell==nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
          
        }
        
        for (UIView *subView in cell.contentView.subviews) {
            [subView removeFromSuperview];
        }
        
        NSArray *arr = [showSearchKeyWordsArray objectAtIndex:indexPath.row];
        CGFloat pox = marginWidth;
        float maxLength = (__MainScreen_Width - marginWidth*2);
        float minWidth = (maxLength - intervalWidth*3)/4.0;
        for (NSInteger i = 0; i < [arr count]; i++) {
            NSString *keyword = [arr objectAtIndex:i];
            CGSize size = [keyword sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake((__MainScreen_Width - marginWidth*2), heightCell)];
            CGFloat width =((size.width + btnMarginWidth)< minWidth)?(minWidth - marginWidth):size.width;
            if (width >= __MainScreen_Width - marginWidth*2)
            {
                width = __MainScreen_Width - marginWidth*2;
                
            }
            else if(width >= __MainScreen_Width - marginWidth*2 - intervalWidth)
            {
                
            }
            else
            {
                width = width+marginWidth;
            }

            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(pox, 0, width, minHeight+14)];
            pox = pox + width+intervalWidth;
            [btn setTitle:keyword forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn.layer setBorderWidth:1.0];
            [btn.layer setMasksToBounds:YES];
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.3, 0.3, 0.3, 0.2});
            [btn.layer setBorderColor:colorref];
            CGColorRelease(colorref);
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
        }
        [cell setBackgroundColor: color_bodyededed];
        [cell.contentView setBackgroundColor:color_bodyededed];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:rootTableView]) {
        [searchText resignFirstResponder];
        [dicParams setValue:arrHistory[indexPath.row] forKey:pkeyword];
        [self pushNewViewController:@"SMHomeListViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:dicParams];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     [searchText resignFirstResponder];
}


#pragma mark - TextField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    if (searchText.text.length>0) {
        // -- 缓存
//        if (self.sHistory.length==0)
//            [userDefaults setObject:[NSString stringWithFormat:@"%@",searchText.text] forKey:searchHistoryKey];
//        else {
//            NSRange range = [self.sHistory rangeOfString: searchText.text];
//            if (range.length == 0) {
//                [userDefaults setObject:[NSString stringWithFormat:@"%@%@%@",self.sHistory,spaceTag,searchText.text] forKey:searchHistoryKey];
//            }
//        }
        NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:arrHistory];
        if ([tmpArray containsObject:searchText.text])
        {
            [tmpArray removeObject:searchText.text];
        }
        [tmpArray insertObject:searchText.text atIndex:0];
      //  [tmpArray addObject:searchText.text];
        [[NSUserDefaults standardUserDefaults] setObject:tmpArray forKey:searchHistoryKey];
        [dicParams setValue:searchText.text forKey:pkeyword];
        [self pushNewViewController:@"SMHomeListViewController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:dicParams];
    }
    return YES;
}

#pragma mark -- segmentedContolDelegate
- (void)onBQISegmentedControlSelected:(int)selectIndex
{
    segmentedSelectedIndex = selectIndex;
    
    if (segmentedSelectedIndex == 0)
    {
        [searchText becomeFirstResponder];
        [searchTableView setHidden:YES];
        arrHistory = nil;
        arrHistory = [[NSUserDefaults standardUserDefaults] arrayForKey:searchHistoryKey];
        if (arrHistory.count>0) {
//            NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:arrHistory];
//            arrHistory = [[tmpArray  reverseObjectEnumerator] allObjects];
            [lbl_NoData setHidden:YES];
            [self.noDataView setHidden:YES];
            [rootTableView setHidden:NO];
            [rootTableView reloadData];
        }
        else{
            [self.noDataView noDataViewIsHidden:NO warnImg:@"" warnMsg:@"搜索记录为空或被清除！"];
            [lbl_NoData setHidden:NO];
            [rootTableView setHidden:YES];
            [rootTableView reloadData];
        }
    }
    else if (segmentedSelectedIndex == 1)
    {
        [searchText resignFirstResponder];
        [rootTableView setHidden:YES];
        NSInteger count = 0;
        for (NSInteger i = 0; i < [showSearchKeyWordsArray count]; i++)
        {
            if ([showSearchKeyWordsArray count] != 0)
            {
                count++;
            }
        }
        
        if (count == 0)
        {
            [self.noDataView noDataViewIsHidden:NO warnImg:@"" warnMsg:@"暂无关键字！"];
            [searchTableView setHidden:YES];
            [searchTableView reloadData];
        }
        else
        {
            [self.noDataView setHidden:YES];
            [searchTableView setHidden:NO];
            [searchTableView reloadData];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
