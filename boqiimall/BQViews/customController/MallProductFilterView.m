//
//  MallProductFilterView.m
//  boqiimall
//
//  Created by YSW on 14-6-26.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "MallProductFilterView.h"
#import "resMod_GetFilterCategory.h"
#import <POP/POP.h>

#define heightTopFilter 44
#define heightForRow    50

#define sectionGroups   @"分类:干粮,湿粮,零食,香波,玩具,保健,医疗药用,美容器材,环境清洁,食具牵引,服饰笼窝|品牌:皇家,比瑞吉,冠能,宝路,诺瑞,康多乐,怡亲,牛油果,咖比,雪山"

@implementation EC_ButtonForMallProFilter
@synthesize btnSection;
@synthesize isOpen;
@synthesize rightIconImg;

- (void) setRightIcon:(NSString *) iconName{
    rightIconImg = [[UIImageView alloc] init];
    [rightIconImg setFrame:CGRectMake(self.frame.size.width-25, (heightForRow-15)/2, 15, 15)];
    [rightIconImg setTag:3335];
    [rightIconImg setImage:[UIImage imageNamed:iconName]];
    [self addSubview:rightIconImg];
}

- (void) setBtnRightIcon{
    [rightIconImg setImage:[UIImage imageNamed: self.isOpen ? @"info_icon_open.png":@"right_icon.png"]];
}
@end

@implementation MallProductFilterView
@synthesize MPFDelegate;
@synthesize dicFilterData;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //  --  data
        dicFilterData = [[NSMutableDictionary alloc] initWithCapacity:0];
        dicSectionRows = [[NSMutableDictionary alloc]initWithCapacity:0];

        
        //  --  view
        
        topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightTopFilter)];
        [topView setBackgroundColor:[UIColor clearColor]];
        UIView * filterShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 4, __MainScreen_Width, heightTopFilter-5)];
        [filterShadow setBackgroundColor:[UIColor whiteColor]];
        filterShadow.layer.shadowColor = [UIColor blackColor].CGColor;
        filterShadow.layer.shadowOffset = CGSizeMake(0, 0.6);
        filterShadow.layer.shadowOpacity = 0.3;
        filterShadow.layer.shadowRadius = 0.6;
        [topView addSubview:filterShadow];
        
        
        UILabel * lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, __MainScreen_Width, 20)];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setText:@"筛选"];
        [lblTitle setFont:defFont(YES, 16)];
        [lblTitle setTextColor:color_333333];
        [topView addSubview:lblTitle];
        
        UIButton * btnCancle = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCancle setFrame:CGRectMake(__MainScreen_Width-60, 2, 50, 40)];
        [btnCancle setBackgroundColor:[UIColor clearColor]];
        [btnCancle setTitle:@"取消" forState:UIControlStateNormal];
        [btnCancle setTitleColor:color_fc4a00 forState:UIControlStateNormal];
        [btnCancle.titleLabel setFont:defFont15];
        [btnCancle addTarget:self action:@selector(onCancleClick:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:btnCancle];
        [self addSubview:topView];
        
        //  --  ........
        filterTableview = [[UITableView alloc] initWithFrame:CGRectMake(0,heightTopFilter-2,__MainScreen_Width,__ContentHeight_noTab-heightTopFilter) style:UITableViewStylePlain];
        [filterTableview setTag:11111];
        filterTableview.backgroundColor = color_bodyededed;
        filterTableview.delegate = self;
        filterTableview.dataSource = self;
        filterTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        filterTableview.showsHorizontalScrollIndicator= NO;
        filterTableview.showsVerticalScrollIndicator  = YES;
        [self addSubview:filterTableview];
        [self bringSubviewToFront:topView];
    }
    return self;
}

//- (void) setFilterData{
//    NSArray * arrFilters = [sectionGroups componentsSeparatedByString:@"|"];
//    int i=0;
//    for (NSString * ss in arrFilters) {
//        
//        NSArray * fInfo = [ss componentsSeparatedByString:@":"];
//        NSArray * ftitles = [fInfo[1] componentsSeparatedByString:@","];
//
//        resMod_CategoryList *catList= [[resMod_CategoryList alloc]init];
//        catList.TypeName = fInfo[0];
//        catList.isSelect_parent = YES;
//        catList.TypeList = [[NSMutableArray alloc]initWithCapacity:0];
//        for (NSString * stxt in ftitles) {
//            resMod_CategoryInfo * catInfo = [[resMod_CategoryInfo alloc] init];
//            catInfo.SubTypeName = stxt;
//            [catList.TypeList addObject:catInfo];
//        }
//
//        [dicFilterData setObject:catList forKey:[NSString stringWithFormat:@"section%d",i]];
//        [dicSectionRows setObject:[NSString stringWithFormat:@"%d",[catList.TypeList count]]
//                           forKey:[NSString stringWithFormat:@"section%d",i]];
//        i++;
//    }
//}

#pragma mark    --  event
- (void)onCancleClick:(id)sender{
    [self isExpansionMpFilterView:NO];
}

- (void)onButtonClick:(id) sender{
    EC_ButtonForMallProFilter * btnTmp = (EC_ButtonForMallProFilter*)sender;
    
    if (btnTmp.tag==1989) {
        btnTmp.isOpen = !btnTmp.isOpen;
        [btnTmp setBtnRightIcon];
        
        NSString * skey = [NSString stringWithFormat:@"section%d",btnTmp.btnSection];
        resMod_CategoryList * clist =[dicFilterData objectForKey:skey];
        clist.isSelect_parent = btnTmp.isOpen;
        
        [dicSectionRows setObject:[NSString stringWithFormat:@"%d",btnTmp.isOpen ? clist.TypeList.count:0] forKey:skey];
        [filterTableview reloadData];
    }
}

- (void)isExpansionMpFilterView:(BOOL) _bool {
    
    CGRect cgframe;
    if (_bool) {
        cgframe =CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }
    else{
        cgframe =CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }
    
    POPSpringAnimation *topAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    topAnimation.toValue=[NSValue valueWithCGRect:cgframe];
    topAnimation.springBounciness = 2.0f;
    topAnimation.springSpeed = 3.5;
    [self pop_addAnimation:topAnimation forKey:@"changeframe"];
    
    if (_bool) {
        [filterTableview reloadData];
    }
}

//  --
- (void) onButtonResetFilterClick:(id) sender{
    for (NSString * key in dicFilterData.allKeys) {
        resMod_CategoryList * category=[dicFilterData objectForKey:key];
        for (resMod_CategoryInfo * cinfo in category.TypeList) {
            cinfo.isChecked = NO;
        }
    }
    [filterTableview reloadData];
}

//  -- 确定
- (void) onButtonOkFilterClick:(id) sender{
    if ([MPFDelegate respondsToSelector:@selector(onDelegateProductFilter)]) {
        [MPFDelegate onDelegateProductFilter];
    }
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dicFilterData.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==dicFilterData.count) {
        return 0;
    }
    else{
        NSString * svalue = [dicSectionRows objectForKey:[NSString stringWithFormat:@"section%d",section]];
        return svalue.length>0 ? [svalue intValue] : 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return heightForRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return heightForRow;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightForRow)];
    [headview setBackgroundColor:[UIColor convertHexToRGB:@"efefef"]];
    if (section==dicFilterData.count) {
        UIButton * btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnReset setFrame:CGRectMake(20, 10, __MainScreen_Width/2-30, 35)];
        [btnReset setTitle:@"全部重置" forState:UIControlStateNormal];
        [btnReset setBackgroundImage:def_ImgStretchable(@"btn_bg_blackline.png", 10, 10) forState:UIControlStateNormal];
        [btnReset.titleLabel setFont:defFont15];
        [btnReset setTitleColor:color_333333 forState:UIControlStateNormal];
        [btnReset addTarget:self action:@selector(onButtonResetFilterClick:) forControlEvents:UIControlEventTouchUpInside];
        [headview addSubview:btnReset];
        
        UIButton * btnok = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnok setFrame:CGRectMake(__MainScreen_Width/2+10, 10, __MainScreen_Width/2-30, 35)];
        [btnok setTitle:@"确认" forState:UIControlStateNormal];
        [btnok setBackgroundImage:def_ImgStretchable(@"btn_bg_blackline.png", 10, 10) forState:UIControlStateNormal];
        [btnok.titleLabel setFont:defFont15];
        [btnok setTitleColor:color_333333 forState:UIControlStateNormal];
        [btnok addTarget:self action:@selector(onButtonOkFilterClick:) forControlEvents:UIControlEventTouchUpInside];
        [headview addSubview:btnok];
    }
    else{
        resMod_CategoryList * clist = [dicFilterData objectForKey:[NSString stringWithFormat:@"section%d",section]];
        UILabel * lblTypeName = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, heightForRow)];
        [lblTypeName setBackgroundColor:[UIColor clearColor]];
        [lblTypeName setText: clist.TypeName];
        [lblTypeName setTextColor:color_717171];
        [lblTypeName setFont:defFont15];
        [headview addSubview:lblTypeName];
        
        EC_ButtonForMallProFilter * btnOpen = [EC_ButtonForMallProFilter buttonWithType:UIButtonTypeCustom];
        btnOpen.tag = 1989;
        btnOpen.isOpen = clist.isSelect_parent;
        [btnOpen setFrame:CGRectMake(__MainScreen_Width-95, 0, 90, heightForRow)];
        btnOpen.btnSection = section;
        [btnOpen setRightIcon: clist.isSelect_parent ? @"info_icon_open.png" : @"right_icon.png"];
        [btnOpen setBackgroundColor:[UIColor clearColor]];
        [btnOpen setTitle:@"全部" forState:UIControlStateNormal];
        [btnOpen setTitleColor:color_989898 forState:UIControlStateNormal];
        [btnOpen.titleLabel setFont:defFont15];
        [btnOpen addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [headview addSubview:btnOpen];

        [UICommon Common_line:CGRectMake(0, heightForRow-0.5, __MainScreen_Width, 0.5) targetView:headview backColor:color_d1d1d1];
    }
    return headview;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * IdentifierCell = @"MallProductFilterCell";
    
    int irow = indexPath.row;
    int isection = indexPath.section;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: IdentifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IdentifierCell];
        
        [UICommon Common_UILabel_Add:CGRectMake(15, 0, def_WidthArea(15), heightForRow) targetView:cell.contentView bgColor:[UIColor clearColor] tag:1010 text:@"离乳期幼犬粮" align:-1 isBold:NO fontSize:15 tColor:color_717171];
        
        UIImageView * imgSelIcon = [[UIImageView alloc]initWithFrame:CGRectMake(__MainScreen_Width-50, (heightForRow-30)/2, 30, 30)];
        [imgSelIcon setTag:1019];
        [imgSelIcon setHidden:YES];
        [imgSelIcon setBackgroundColor:[UIColor clearColor]];
        [imgSelIcon setImage:[UIImage imageNamed:@"icon_right_ora"]];
        [cell.contentView addSubview:imgSelIcon];
        
        [UICommon Common_line:CGRectMake(0, 0, __MainScreen_Width, 0.5) targetView:cell.contentView backColor:color_d1d1d1];
    }
    
    if (dicFilterData.count>0) {
        resMod_CategoryList * clist = [dicFilterData objectForKey:[NSString stringWithFormat:@"section%d",isection]];
        UILabel * lbl_1010 = (UILabel*)[cell viewWithTag:1010];
        [lbl_1010 setText:[clist.TypeList[irow] SubTypeName]];
        [lbl_1010 setTextColor:[clist.TypeList[irow] isChecked]?color_fc4a00:color_717171];
        
        UIImageView * icon_1019=(UIImageView*)[cell.contentView viewWithTag:1019];
        [icon_1019 setHidden: [clist.TypeList[irow] isChecked] ? NO:YES];
    }
    
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.contentView setBackgroundColor:color_dedede];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int isection = indexPath.section;
    int irow = indexPath.row;
    
    resMod_CategoryList * clist = [dicFilterData objectForKey:[NSString stringWithFormat:@"section%d",isection]];
    for (int i=0; i<clist.TypeList.count; i++) {
        resMod_CategoryInfo * cinfo = clist.TypeList[i];
        cinfo.isChecked = i==irow ? YES : NO;
    }
    [filterTableview reloadData];
}

@end





