//
//  MallProductSearchController.m
//  BoqiiLife
//
//  Created by YSW on 14-6-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MallProductSearchController.h"
#import "resMod_Mall_IndexData.h"
#import "BQISegmentedControl.h"
#import "resMod_GetShoppingMallKeyWords.h"

#define heightCell  45
#define searchMallHistoryKey    @"kSearchMallProductHistory"
#define spaceTag    @"||boqiii||"
#define pkeyword     @"paramKeyword"

#define SegmentedControlBgViewHeight  56
#define SegmentedControlHeight 30
#define marginWidth 12
#define btnMarginWidth 20
#define nextBtnWidth 80
#define minHeight 18
#define intervalWidth 12


@implementation MallProductSearchController
@synthesize sHistory;
@synthesize selCateName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dicParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"",pkeyword, nil];
        arrCategoryType = [[NSMutableArray alloc]initWithCapacity:0];
        searchKeyWordsArray = [[NSMutableArray alloc] init];
        showSearchKeyWordsArray = [[NSMutableArray alloc] init];
        alreadyShowedKeyWordsArray = [[NSMutableArray alloc] init];
        searchResponseKeyWordsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) goBack:(id)sender{
    [searchText resignFirstResponder];
    [dropDownView removeFromSuperview];
    [MobClick event:@"mallIndex_serchIndex_return"];
    [super goBack:sender];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    if (segmentedSelectedIndex == 0)
    {
        [searchTableView setHidden:YES];
        arrHistory = nil;
        arrHistory = [[NSUserDefaults standardUserDefaults] arrayForKey:searchMallHistoryKey];
        if (arrHistory.count>0) {
//            NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:arrHistory];
//            arrHistory = [[tmpArray  reverseObjectEnumerator] allObjects];
            [self.noDataView setHidden:YES];
            [rootTableView setHidden:NO];
            [rootTableView reloadData];
            
        }
        else{
            [self.noDataView noDataViewIsHidden:NO warnImg:@"" warnMsg:@"搜索记录为空或被清除！"];
            [rootTableView setHidden:YES];
            [rootTableView reloadData];
        }
    }
    else if(segmentedSelectedIndex == 1)
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
    
    // -- 客户端缓存历史
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"商城搜索"];
    [self.view setBackgroundColor: color_bodyededed];
    
    resMod_Mall_IndexResponseData * cateinfo = [[PMGlobal shared] GetDataFromPlist_MallIndex];
    if (cateinfo) {
        resMod_Mall_IndexMain * addAllClass = [[resMod_Mall_IndexMain alloc] init];
        addAllClass.TabId = 0;
        addAllClass.TabName = @"全部";
        [arrCategoryType addObject:addAllClass];
        [arrCategoryType addObjectsFromArray: [cateinfo MainData]];
    }
    
    //  --
    [self loadView_nav];
    
    //  -- ....
    segmentedControlBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarViewHeight+0, __MainScreen_Width, SegmentedControlBgViewHeight)];
    [segmentedControlBgView setBackgroundColor:color_bodyededed];
     [self.view addSubview:segmentedControlBgView];
   
    mySegementController = [[BQISegmentedControl alloc] initWithFrame:CGRectMake(marginWidth, 12, (__MainScreen_Width - marginWidth*2), SegmentedControlHeight) btntitle1:@"搜索历史" btn1Img:@"column_nav_btn_left_nor" btntitle2:@"大家都在搜" btn2Img:@"column_nav_btn_right_nor" img1Press:@"column_nav_btn_left_sel" img2press:@"column_nav_btn_right_sel"];
    [segmentedControlBgView addSubview:mySegementController];
    [mySegementController setDelegate:self];

    
    //  -- ....
    searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SegmentedControlBgViewHeight+kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight-12) style:UITableViewStylePlain];
    [searchTableView setHidden:YES];
    [searchTableView setBackgroundColor: color_bodyededed];
    searchTableView.delegate = self;
    searchTableView.dataSource = self;
    searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [searchTableView setShowsVerticalScrollIndicator: NO];
    [self.view addSubview:searchTableView];
    
    
    //  --  ...
    rootTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SegmentedControlBgViewHeight+kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight) style:UITableViewStylePlain];
    [rootTableView setHidden:YES];
    [rootTableView setBackgroundColor: color_bodyededed];
    rootTableView.delegate = self;
    rootTableView.dataSource = self;
    rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [rootTableView setShowsVerticalScrollIndicator: NO];
    [self.view addSubview:rootTableView];
    
    [self goApiRequest_getSearchKeyWordsList];
}

//- (void)loadNavBarView
//{
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    [self.navBarView addSubview:bgView];
//    [self loadView_nav];
//}

#pragma mark -- goApiRequest

- (void)goApiRequest_getSearchKeyWordsList {
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingMallKeyWords:nil ModelClass:@"resMod_CallBackMall_SearchKeyWordsList" showLoadingAnimal:NO hudContent:@"" delegate:self];
}


//-- 请求成功
-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    
    if ([ApiName isEqualToString:kApiMethod_Mall_GetShoppingMallKeyWords])
    {
         resMod_CallBackMall_SearchKeyWordsList *backObj = [[resMod_CallBackMall_SearchKeyWordsList alloc] initWithDic:retObj];
         searchResponseKeyWordsArray = backObj.ResponseData;
         
         if (selCateID == 0)
         {
             for (NSInteger i = 0; i < [searchResponseKeyWordsArray count]; i++)
             {
                 resMod_GetShoppingMallKeyWords *item = [searchResponseKeyWordsArray objectAtIndex:i];
                 for (NSInteger j = 0; j < [item keyWordsArray].count; j++)
                 {
                     [searchKeyWordsArray addObject:[[item keyWordsArray] objectAtIndex:j]];
                 }
             }
         }
         else
         {
             for (NSInteger i = 0; i < [searchResponseKeyWordsArray count]; i++)
             {
                 resMod_GetShoppingMallKeyWords *item = [searchResponseKeyWordsArray objectAtIndex:i];
                 if ([item.TypeId integerValue] == selCateID)
                 {
                     for (NSInteger j = 0; j < [item keyWordsArray].count; j++)
                     {
                         [searchKeyWordsArray addObject:[[item keyWordsArray] objectAtIndex:j]];
                     }
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


- (void)onNextButtonClick:(id)sender
{
    [self updateSearchTableView];
}

-(void)updateSearchTableView{
    
    
    
    [showSearchKeyWordsArray removeAllObjects];
     [alreadyShowedKeyWordsArray removeAllObjects];
    /*
    if (alreadyShowedKeyWordsArray.count == searchKeyWordsArray.count)
    {
       
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

- (BOOL)allKeyWordsShowedOnce {
    NSInteger count = 0;
    for (NSInteger i = 0; i < showSearchKeyWordsArray.count;i++)
    {
        NSArray *tempArray = [showSearchKeyWordsArray objectAtIndex:i];
        count += tempArray.count;
    }
    
    if (count == searchKeyWordsArray.count) {
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark    --打乱关键字顺序

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



#pragma mark    --  event

- (void)HotKeyWordBtnClick:(UIButton *)sender
{
    [self goSearchResultPage:sender.titleLabel.text];
}

- (void)onSearchClick:(id) sender{
    
    [searchText resignFirstResponder];
    if (searchText.text.length>0) {
        // -- 缓存
        
        NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:arrHistory];
        if ([tmpArray containsObject:searchText.text])
        {
            [tmpArray removeObject:searchText.text];
        }
        [tmpArray insertObject:searchText.text atIndex:0];
       // [tmpArray addObject:searchText.text];
        [[NSUserDefaults standardUserDefaults] setObject:tmpArray forKey:searchMallHistoryKey];
        [self goSearchResultPage:searchText.text];
    }
    else{
        [self HUDShow:@"请输入搜索内容" delay:2];
    }
}

- (void)onCategoryOpen:(id) sender{
    [MobClick event:@"mallIndex_serchIndex_classification"];
    [dropDownView removeFromSuperview];
    
    UIWindow *currWindow = [[UIApplication sharedApplication] keyWindow];
    dropDownView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, __MainScreenFrame.size.height)];
    [dropDownView setBackgroundColor:[UIColor clearColor]];
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCancleSelCates)];
    [dropDownView addGestureRecognizer:singleTap];
    dropDownView.userInteractionEnabled =YES;
    [currWindow addSubview:dropDownView];
    
    UIImageView * ddBg = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20+40, 173/2, 4+heightCell*arrCategoryType.count)];
    [ddBg setImage:def_ImgStretchable(@"dropDown_box.png", 0, 12)];
    [ddBg setBackgroundColor:[UIColor clearColor]];
    [dropDownView addSubview:ddBg];
    
    int i=0;
    for (resMod_Mall_IndexMain * category in arrCategoryType) {
        
        UIButton * btnCategroy = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCategroy setTag:[category.TabId intValue]];
        [btnCategroy setBackgroundColor:[UIColor clearColor]];
        [btnCategroy setFrame:CGRectMake(40, 20+44+heightCell*i, 173/2, heightCell)];
        [btnCategroy setTitle:category.TabName forState:UIControlStateNormal];
        [btnCategroy setTitleColor:color_989898 forState:UIControlStateHighlighted];
        [btnCategroy.titleLabel setFont:defFont(YES, 15)];
        [btnCategroy addTarget:self action:@selector(onCategorySelect:) forControlEvents:UIControlEventTouchUpInside];
        [dropDownView addSubview:btnCategroy];
        
        [UICommon Common_line:CGRectMake(0, btnCategroy.frame.size.height-0.5, btnCategroy.frame.size.width, 0.5) targetView:btnCategroy backColor:color_4e4e4e];
        i++;
    }
}

- (void)onCategorySelect:(id) sender{
    
    UIButton * btnTmp = (UIButton*)sender;
    selCateID = btnTmp.tag;
    self.selCateName = btnTmp.titleLabel.text;
    
    [btnSelClassfy setTitle:btnTmp.titleLabel.text forState:UIControlStateNormal];
    
    [dropDownView removeFromSuperview];
    [showSearchKeyWordsArray removeAllObjects];
    [alreadyShowedKeyWordsArray removeAllObjects];
    [searchKeyWordsArray removeAllObjects];
    
    if (selCateID == 0)
    {
        for (NSInteger i = 0; i < [searchResponseKeyWordsArray count]; i++)
        {
            resMod_GetShoppingMallKeyWords *item = [searchResponseKeyWordsArray objectAtIndex:i];
            for (NSInteger j = 0; j < [item keyWordsArray].count; j++)
            {
                [searchKeyWordsArray addObject:[[item keyWordsArray] objectAtIndex:j]];
            }
        }
    }
    else
    {
        for (NSInteger i = 0; i < [searchResponseKeyWordsArray count]; i++)
        {
            resMod_GetShoppingMallKeyWords *item = [searchResponseKeyWordsArray objectAtIndex:i];
            if ([item.TypeId integerValue] == selCateID)
            {
                for (NSInteger j = 0; j < [item keyWordsArray].count; j++)
                {
                    [searchKeyWordsArray addObject:[[item keyWordsArray] objectAtIndex:j]];
                }
            }
        }

    }
    
    [self updateSearchTableView];
}

- (void)onCancleSelCates{
    [dropDownView removeFromSuperview];
}

#pragma mark    --  load ui : 导航
- (void) loadView_nav{
    
    UIView * viewTitle = [[UIView alloc] initWithFrame:CGRectMake(45, kStatusBarHeight+6, __MainScreen_Width - 45 - 10, 32)];
    [viewTitle setBackgroundColor:color_dedede];
    viewTitle.layer.cornerRadius = 3.0f;
    
    int idx = [[PMGlobal shared] overAllIdxForClassify]+1;
    self.selCateName = arrCategoryType&&arrCategoryType.count>0 ? [arrCategoryType[idx] TabName]: @"狗狗" ;
    selCateID        = arrCategoryType&&arrCategoryType.count>0 ? [[arrCategoryType[idx] TabId] intValue]: 0;

    btnSelClassfy = [[UIButton alloc] initWithFrame:CGRectMake(2, 1, 50, 30)];
    [btnSelClassfy setTag:1111];
    [btnSelClassfy setBackgroundColor:[UIColor clearColor]];
    [btnSelClassfy setTitle:self.selCateName forState:UIControlStateNormal];
    [btnSelClassfy setTitleColor:color_333333 forState:UIControlStateNormal];
    [btnSelClassfy.titleLabel setFont:defFont14];
    [btnSelClassfy addTarget:self action:@selector(onCategoryOpen:) forControlEvents:UIControlEventTouchUpInside];
    [viewTitle addSubview:btnSelClassfy];
    
    UIImageView * imgarrow = [[UIImageView alloc] initWithFrame:CGRectMake(btnSelClassfy.frame.size.width-7, 13, 6, 3)];
    [imgarrow setImage:[UIImage imageNamed:@"down_arrow.png"]];
    [btnSelClassfy addSubview:imgarrow];
    
    [UICommon Common_line:CGRectMake(58, 10, 0.5, 12) targetView:viewTitle backColor:color_717171];

    searchText = [[UITextField alloc] initWithFrame:CGRectMake(68, 1, viewTitle.frame.size.width-95, 30)];
    [searchText setBackgroundColor:[UIColor clearColor]];
    [searchText setPlaceholder:@"请输入搜索关键字"];
    [searchText setFont:defFont13];
    [searchText setDelegate:self];
    [searchText setReturnKeyType:UIReturnKeySearch];
    [searchText setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    searchText.layer.cornerRadius = 3.0f;
    [viewTitle addSubview:searchText];
    UIButton * btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(230, 0, 35, 30)];
    [btnSearch setBackgroundColor:[UIColor clearColor]];
    btnSearch.layer.cornerRadius = 3.0f;
    [viewTitle addSubview:btnSearch];
    UIImageView * searchicon =[[UIImageView alloc] initWithFrame:CGRectMake((35-16)/2-2, (30-16)/2, 16, 16)];
    [searchicon setBackgroundColor:[UIColor clearColor]];
    [searchicon setImage:[UIImage imageNamed:@"navbar_search_icon_normal"]];
    [btnSearch addSubview:searchicon];
    [viewTitle addSubview:btnSearch];
    [btnSearch addTarget:self action:@selector(onSearchClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBarView addSubview:viewTitle];
}

//  --清除历史浏览记录
- (void)onClearButtonClick:(id) sender{
    [searchText resignFirstResponder];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:searchMallHistoryKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    arrHistory = nil;
    
    [self HUDShow:@"清除成功" delay:1.5];
    
    [self.noDataView noDataViewIsHidden:NO warnImg:@"" warnMsg:@"搜索记录为空或被清除！"];
    [rootTableView setHidden:YES];
    [rootTableView reloadData];
    [segmentedControlBgView setBackgroundColor:color_bodyededed];
}

//  --去分类页
- (void)onGoClassButtonClick:(id) sender{
    [searchText resignFirstResponder];
    [MobClick event:@"SearchResultPage_returnSerchIndex_allClassification"];
    [self pushNewViewController:@"MallFirstClassification" isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:nil];
}


//  --
- (void)goSearchResultPage:(NSString *) keyword{
    
    [searchText resignFirstResponder];
    [dropDownView removeFromSuperview];
    [dicParams setValue:keyword forKey:pkeyword];
    [dicParams setValue:[NSString stringWithFormat:@"%d",selCateID] forKey:@"param1thClass"];
    [dicParams setValue:self.selCateName forKey:@"paramSelClassName"];
    
    [self pushNewViewController:@"MallProductListVController"
                      isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:dicParams];
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:rootTableView]) {
        return arrHistory.count;
    }
    else {
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
    return heightCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([tableView isEqual:rootTableView])
    {
        return heightCell*4;
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
        UIView * viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightCell*2)];
        [viewFoot setBackgroundColor:[UIColor clearColor]];
        
        UIButton * btnClear = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnClear setFrame:CGRectMake(90, 20, def_WidthArea(90), 36)];
        [btnClear setBackgroundColor:[UIColor clearColor]];
        [btnClear setBackgroundImage:def_ImgStretchable(@"btn_bg_blackline.png", 10, 10) forState:UIControlStateNormal];
        [btnClear setTitle:@"清除搜索记录" forState:UIControlStateNormal];
        [btnClear.titleLabel setFont:defFont15];
        [btnClear setTitleColor:color_333333 forState:UIControlStateNormal];
        [btnClear addTarget:self action:@selector(onClearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewFoot addSubview:btnClear];
        
        UIButton * btnGoClass = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnGoClass setFrame:CGRectMake(0, heightCell+20, __MainScreen_Width, heightCell)];
        [btnGoClass setBackgroundColor:[UIColor clearColor]];
        [btnGoClass setTitle:@"不知道搜索什么？点击查看完整分类" forState:UIControlStateNormal];
        [btnGoClass.titleLabel setFont:defFont15];
        [btnGoClass setTitleColor:color_fc4a00 forState:UIControlStateNormal];
        [btnGoClass addTarget:self action:@selector(onGoClassButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewFoot addSubview:btnGoClass];
        
        return viewFoot;
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
            [lbl_keyWord setFont: defFont15];
            [lbl_keyWord setTextColor:color_989898];
            [cell.contentView addSubview:lbl_keyWord];
            
            [UICommon Common_line:CGRectMake(0, heightCell-0.5, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
        }
        
        if (arrHistory.count>0) {
            UILabel * lbl_1000 = (UILabel*)[cell.contentView viewWithTag:1000];
            [lbl_1000 setText:arrHistory[indexPath.row]];
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.contentView setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }
    else {
        UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if (cell==nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        
        for (UIView *subView in cell.contentView.subviews)
        {
            [subView removeFromSuperview];
        }
        
        NSArray *arr = [showSearchKeyWordsArray objectAtIndex:indexPath.row];
        CGFloat pox = marginWidth;
        float maxLength = (__MainScreen_Width - marginWidth*2);
        float minWidth = (maxLength - intervalWidth*3)/4.0;
        for (NSInteger i = 0; i < [arr count]; i++)
        {
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
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(pox, 0, width, minHeight+14)];
            pox = pox + width + intervalWidth;
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
            [btn addTarget:self action:@selector(HotKeyWordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
        [self goSearchResultPage:arrHistory[indexPath.row]];
    }
    
//    [searchText resignFirstResponder];
//    [dropDownView removeFromSuperview];
//    [dicParams setValue:arrHistory[indexPath.row] forKey:pkeyword];
//    [self pushNewViewController:@"MallProductListVController"
//                      isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:dicParams];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [searchText resignFirstResponder];
}

#pragma mark - TextField delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self onSearchClick:nil];
    return YES;
}


#pragma mark -- segmentedControl delegate
- (void)onBQISegmentedControlSelected:(int)selectIndex
{
    segmentedSelectedIndex = selectIndex;
    if (segmentedSelectedIndex == 0)
    {
        [MobClick event:@"mallIndex_serchIndex_dajiadouzaisou"];
        [searchTableView setHidden:YES];
        arrHistory = nil;
        arrHistory = [[NSUserDefaults standardUserDefaults] arrayForKey:searchMallHistoryKey];
        if (arrHistory.count>0) {
//            NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:arrHistory];
//            arrHistory = [[tmpArray  reverseObjectEnumerator] allObjects];
            [self.noDataView setHidden:YES];
            [rootTableView setHidden:NO];
            [rootTableView reloadData];
           
        }
        else{
            [self.noDataView noDataViewIsHidden:NO warnImg:@"" warnMsg:@"搜索记录为空或被清除！"];
            [rootTableView setHidden:YES];
            [rootTableView reloadData];
          
        }
    }
    else if(segmentedSelectedIndex == 1)
    {
        [MobClick event:@"mallIndex_serchIndex_dajiadouzaisou"];
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
