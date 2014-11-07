//
//  MallFirstClassification.m
//  BoqiiLife
//
//  Created by YSW on 14-6-19.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "MallFirstClassification.h"
#import "resMod_Mall_Classification.h"
#import "FileController.h"

#define rowHeight  200/2

@implementation MallFirstClassification
@synthesize arrClassification;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.arrClassification = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self loadNavBarView];
    [self setTitle:@"商品分类"];
    //[self loadNavBarView];
    //----------------------        ...
    tableview_root = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [tableview_root setFrame:CGRectMake(0, kNavBarViewHeight, __MainScreen_Width, kMainScreenHeight - kNavBarViewHeight)];
    tableview_root.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableview_root setBackgroundColor:color_body];
    tableview_root.delegate = self;
    tableview_root.dataSource = self;
    [tableview_root setShowsVerticalScrollIndicator:NO];
    [tableview_root setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:tableview_root];
    [self goApiRequest_MallClassification];
}


//- (void)loadNavBarView
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
//    titleLabel.text = @"商品分类";
//    [bgView addSubview:titleLabel];
//    [self.navBarView addSubview:bgView];
//}


#pragma mark    --  api 请 求 & 回 调.
-(void)goApiRequest_MallClassification{
    
//    [self ApiRequest:api_BOQIIMALL method:kApiMethod_Mall_Classification class:@"resMod_CallBackMall_Classification"
//              params:nil  isShowLoadingAnimal:YES hudShow:@"正在加载"];
    [[APIMethodHandle shareAPIMethodHandle]goApiRequestGetShoppingMallCategoryType:nil ModelClass:@"resMod_CallBackMall_Classification" showLoadingAnimal:YES hudContent:@"正在加载" delegate:self];
    
}

-(void) interfaceExcuteSuccess:(id)retObj apiName:(NSString*)ApiName{
    [super interfaceExcuteSuccess:retObj apiName:ApiName];
    if ([ApiName isEqualToString:kApiMethod_Mall_Classification]) {
        resMod_CallBackMall_Classification * backObj = [[resMod_CallBackMall_Classification alloc] initWithDic:retObj];
        self.arrClassification = backObj.ResponseData;
        
        [tableview_root reloadData];
        [self hudWasHidden:HUD];
        [self.lodingAnimationView stopLoadingAnimal];
    }
}


#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrClassification.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = @"SecondCellSection";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        UIImageView * imgicon = [[UIImageView alloc] initWithFrame:CGRectMake(10, rowHeight/2-25, 50, 50)];
        [imgicon setTag:100];
        [imgicon setBackgroundColor:[UIColor clearColor]];
        [imgicon setImage:[UIImage imageNamed:@"cat_pic.png"]];
        [cell.contentView addSubview:imgicon];
        
        [UICommon Common_UILabel_Add:CGRectMake(70, rowHeight/2-25, __MainScreen_Width-100, 30)
                          targetView:cell.contentView bgColor:[UIColor clearColor] tag:111
                                text:@"狗狗用品" align:-1 isBold:YES fontSize:18 tColor:color_4e4e4e];
        
        UILabel * lbl_hotword = [[UILabel alloc] initWithFrame:CGRectMake(60, rowHeight/2+3, __MainScreen_Width-110, 20)];
        [lbl_hotword setTag:112];
        [lbl_hotword setBackgroundColor:[UIColor clearColor]];
        [lbl_hotword setTextColor:color_717171];
        [lbl_hotword setFont:defFont13];
        [lbl_hotword setTextAlignment:NSTextAlignmentLeft];
        [lbl_hotword setText:@"干湿粮 零食 玩具 医疗药用"];
        [cell.contentView addSubview:lbl_hotword];
        
        UIImageView * icondetail = [[UIImageView alloc]initWithFrame:CGRectMake(__MainScreen_Width-25, rowHeight/2-7,15,15)];
        [icondetail setBackgroundColor:[UIColor clearColor]];
        [icondetail setImage:[UIImage imageNamed:@"right_icon.png"]];
        [cell.contentView addSubview:icondetail];
        
        [UICommon Common_line:CGRectMake(0, rowHeight-1, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
    }
    
    int irow = indexPath.row;
    if (self.arrClassification.count>0) {
        
        resMod_Mall_Class1th * class1thInfo = self.arrClassification[irow];
        
        UIImageView * img_100 = (UIImageView*)[cell viewWithTag:100];
        UILabel * lbl_111   = (UILabel*)[cell viewWithTag:111];
        UILabel * lbl_112   = (UILabel*)[cell viewWithTag:112];
        
        [img_100 sd_setImageWithURL:[NSURL URLWithString:class1thInfo.TypeImg]
                   placeholderImage:[UIImage imageNamed:@"cat_pic.png"]];
        [lbl_111 setText:class1thInfo.TypeName];
        
        NSString * sKeyWord = @"";
        for (int i=0;i<class1thInfo.TypeList.count && i<5;i++) {
            resMod_Mall_Class2th * class2thInfo = class1thInfo.TypeList[i];
            sKeyWord = [NSString stringWithFormat:@"%@   %@",sKeyWord,class2thInfo.SubTypeName];
        }
        [lbl_112 setText:sKeyWord];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int irow = indexPath.row;
    
    switch (irow) {
        case 0:
            [MobClick event:@"mallIndex_AllClassification_1"];
            break;
        case 1:
            [MobClick event:@"mallIndex_AllClassification_2"];
            break;
        case 2:
            [MobClick event:@"mallIndex_AllClassification_3"];
            break;
        case 3:
            [MobClick event:@"mallIndex_AllClassification_4"];
            break;
            
        default:
            break;
    }
    
    [[PMGlobal shared] SaveOverAllIdxForClassify:irow];
    [self pushNewViewController:@"MallSecondClassification" isNibPage:NO hideTabBar:YES setDelegate:NO
                  setPushParams:[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.arrClassification[irow],@"param_2th3thClass", nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
