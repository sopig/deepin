//
//  MallSecondClassification.m
//  BoqiiLife
//
//  Created by YSW on 14-6-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MallSecondClassification.h"
#import "FileController.h"

#define widthSecondCate     130
#define widththirdCate     __MainScreen_Width-130
#define rowHeight_second    96/2
#define rowHeight_third     96/2

@implementation MallSecondClassification

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        iSel2thID = 0;
        iSel2thRow = 0;
        iSel3thRow = -1;
        arr2thClass = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadNavBarView];
    
    [self setTitle:(class1thInfo?[NSString stringWithFormat:@"%@商品分类",class1thInfo.TypeName]:@"商品分类")];
    
    
    class1thInfo = [self.receivedParams objectForKey:@"param_2th3thClass"];
    
  //  [self loadNavBarView:(class1thInfo?[NSString stringWithFormat:@"%@商品分类",class1thInfo.TypeName]:@"商品分类")];
    isFromIndex = [[self.receivedParams objectForKey:@"param_FromIndex"] isEqualToString:@"100"] ? YES : NO;
    if (isFromIndex) {
        Param_Class1thID = [[self.receivedParams objectForKey:@"param_1thClassID"] intValue];

        [self goApiRequest_MallClassification];
    }
    else{
        [self loadContentView];
    }
        
}


//- (void)loadNavBarView:(NSString *)title
//{
//    
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, __MainScreen_Width, 44)];
//    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 7, 30, 30)];
//    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//    [backBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [backBtn setBackgroundImage:[UIImage imageNamed:self.backImgName] forState:UIControlStateNormal];
//    [bgView addSubview:backBtn];
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 2, 230, 40)];
//    titleLabel.font = [UIFont boldSystemFontOfSize:18];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = title;
//    [bgView addSubview:titleLabel];
//    [self.navBarView addSubview:bgView];
//}



- (void) loadContentView{
    if (class1thInfo!=nil) {
        
        arr2thClass = class1thInfo.TypeList;
        sel2thInfo  = class1thInfo.TypeList[iSel2thRow];
        
        [self setTitle:[NSString stringWithFormat:@"%@商品分类",class1thInfo.TypeName]];
        
        //----------------------        二...
        tableview_secondCates = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tableview_secondCates setFrame:CGRectMake(0, kNavBarViewHeight, widthSecondCate, kMainScreenHeight - kNavBarViewHeight)];
        tableview_secondCates.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableview_secondCates setBackgroundColor:color_body];
        tableview_secondCates.delegate = self;
        tableview_secondCates.dataSource = self;
        [tableview_secondCates setShowsVerticalScrollIndicator:NO];
        [tableview_secondCates setShowsHorizontalScrollIndicator:NO];
        [self.view addSubview:tableview_secondCates];
        
        //----------------------        三...
        tableview_thirdCates = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [tableview_thirdCates setFrame:CGRectMake(widthSecondCate, kNavBarViewHeight, widththirdCate, kMainScreenHeight - kNavBarViewHeight)];
        tableview_thirdCates.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableview_thirdCates setBackgroundColor:[UIColor whiteColor]];
        tableview_thirdCates.delegate = self;
        tableview_thirdCates.dataSource = self;
        [tableview_thirdCates setShowsVerticalScrollIndicator:NO];
        [tableview_thirdCates setShowsHorizontalScrollIndicator:YES];
        [self.view addSubview:tableview_thirdCates];
    }
}

#pragma mark    --  api 请 求 & 回 调.
-(void)goApiRequest_MallClassification{
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_Classification class:@"resMod_CallBackMall_Classification"
//              params:nil  isShowLoadingAnimal:NO hudShow:@"正在加载"];
//    GetShoppingMallCategoryType
    
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingMallCategoryType:nil ModelClass:@"resMod_CallBackMall_Classification" showLoadingAnimal:NO hudContent:@"正在加载" delegate:self];
    
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_Mall_Classification]) {
        resMod_CallBackMall_Classification * backObj = [[resMod_CallBackMall_Classification alloc] initWithDic:retObj];
        
        if(backObj.ResponseData.count>0){
            for (resMod_Mall_Class1th * clstmp in backObj.ResponseData) {
                if (clstmp.TypeId == Param_Class1thID) {
                    class1thInfo = clstmp;
                    
                    [self loadContentView];
                    continue;
                }
            }
        }
        
        if (class1thInfo==nil) {
            [self HUDShow:@"暂无该分类信息" delay:2];
        }
        
        [self hudWasHidden:HUD];
    }
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return tableView==tableview_secondCates ? arr2thClass.count : sel2thInfo.SubTypeList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView==tableview_secondCates ? rowHeight_second : rowHeight_third;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int irow = indexPath.row;
    if (tableView == tableview_secondCates) {
        NSString * cellIdentifier = @"SecondClassificationCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake(8, rowHeight_second/2-15, 30, 30)];
            [imgicon setTag:200];
            [imgicon setBackgroundColor:[UIColor clearColor]];
            [imgicon setImage:[UIImage imageNamed:@"icon_2th_class.png"]];
            [cell.contentView addSubview:imgicon];
            
            [UICommon Common_UILabel_Add:CGRectMake(40, 0, widthSecondCate-10, rowHeight_second)
                              targetView:cell.contentView bgColor:[UIColor clearColor] tag:222
                                    text:@"狗狗用品" align:-1 isBold:NO fontSize:14 tColor:color_4e4e4e];
            
            UILabel * lblLeftSel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3, rowHeight_second)];
            [lblLeftSel setTag:223];
            [lblLeftSel setBackgroundColor:color_fc4a00];
            [cell.contentView addSubview:lblLeftSel];
            
            UILabel * rightLine = [[UILabel alloc] initWithFrame:CGRectMake(widthSecondCate-0.5,0, 0.5, rowHeight_second)];
            [rightLine setTag:224];
            [rightLine setBackgroundColor:color_d1d1d1];
            [cell.contentView addSubview:rightLine];
            
            [UICommon Common_line:CGRectMake(0, rowHeight_second-0.5, widthSecondCate, 0.5)
                       targetView:cell.contentView backColor:color_d1d1d1];
        }
        
        if (arr2thClass.count>0) {
            
            resMod_Mall_Class2th * class2th = arr2thClass[irow];
            
            UIImageView * img_200 = (UIImageView*)[cell viewWithTag:200];
            UILabel * lbl_222 = (UILabel*)[cell viewWithTag:222];
            UILabel * lbl_223 = (UILabel*)[cell viewWithTag:223];
            UILabel * lbl_224 = (UILabel*)[cell viewWithTag:224];
            
            [img_200 sd_setImageWithURL:[NSURL URLWithString:class2th.SubTypeImg]
                       placeholderImage:[UIImage imageNamed:@"icon_2th_class.png"]];
            [lbl_222 setText:class2th.SubTypeName];
            
            if (iSel2thRow==indexPath.row) {
                [lbl_222 setTextColor:color_fc4a00];
                [lbl_222 setFont:defFont15];
                [lbl_223 setHidden:NO];
                [lbl_224 setHidden:YES];
            } else{
                [lbl_222 setTextColor:color_4e4e4e];
                [lbl_222 setFont:defFont14];
                [lbl_223 setHidden:YES];
                [lbl_224 setHidden:NO];
            }
        }
        [cell.contentView setBackgroundColor: iSel2thRow==indexPath.row ? [UIColor whiteColor]:[UIColor clearColor]];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else{
        NSString * cellIdentifier = @"ThirdClassificationCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            [UICommon Common_UILabel_Add:CGRectMake(25, 0, __MainScreen_Width-100, rowHeight_third)
                              targetView:cell.contentView bgColor:[UIColor clearColor] tag:333
                                    text:@"干粮系列" align:-1 isBold:NO fontSize:14 tColor:color_989898];
            
            [UICommon Common_line:CGRectMake(25, rowHeight_third-1, widththirdCate-50, 0.5)
                       targetView:cell.contentView backColor:color_d1d1d1];
        }
        
        if (sel2thInfo.SubTypeList.count>0) {
            resMod_Mall_Class3th * class3th = sel2thInfo.SubTypeList[irow];
            
            UILabel * lbl_333 = (UILabel*)[cell viewWithTag:333];
            [lbl_333 setText:class3th.ThirdTypeName];
            
            if (iSel2thID ==sel2thInfo.SubTypeId && iSel3thRow==indexPath.row) {
                [lbl_333 setTextColor:color_4e4e4e];
            } else{
                [lbl_333 setTextColor:color_989898];
            }
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tableview_secondCates) {
        iSel2thRow = indexPath.row;
        sel2thInfo = class1thInfo.TypeList[iSel2thRow];
        
        [tableview_thirdCates reloadData];
        [tableview_secondCates reloadData];
    }
    if (tableView == tableview_thirdCates) {
        iSel2thID = sel2thInfo.SubTypeId;
        iSel3thRow = indexPath.row;
        [tableview_thirdCates reloadData];
        
        resMod_Mall_Class3th * class3th = sel2thInfo.SubTypeList[indexPath.row];
        
        NSMutableDictionary * dicParam = [[NSMutableDictionary alloc] init];
        [dicParam setValue:[NSString stringWithFormat:@"%d",class1thInfo.TypeId]forKey:@"param1thClass"];
        [dicParam setValue:[NSString stringWithFormat:@"%d",iSel2thID] forKey:@"param2thClass"];
        [dicParam setValue:[NSString stringWithFormat:@"%d",class3th.ThirdTypeId] forKey:@"param3thClass"];
        [dicParam setValue:class1thInfo.TypeName forKey:@"paramSelClassName"];
        [self pushNewViewController:@"MallProductListVController"
                          isNibPage:NO hideTabBar:YES setDelegate:NO setPushParams:dicParam];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
