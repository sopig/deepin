//
//  DropDownFilterView.m
//  BoqiiLife
//
//  Created by YSW on 14-5-7.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "DropDownFilterView.h"

//  --.................................................
@implementation EC_FilterButton
@synthesize lbl_TitleKey;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        lbl_TitleKey = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [lbl_TitleKey setBackgroundColor:[UIColor clearColor]];
        [lbl_TitleKey setHidden:YES];
        [lbl_TitleKey setTextColor:color_4e4e4e];
        [self addSubview:lbl_TitleKey];
        
        img_icon = [[UIImageView alloc]initWithFrame:CGRectZero];
        [img_icon setBackgroundColor:[UIColor clearColor]];
        [img_icon setImage:[UIImage imageNamed:@"info_icon_open"]];
        [self addSubview:img_icon];
    }
    return self;
}

- (void) setTitleKey:(NSString *) value{
    self.lbl_TitleKey.text = value;
}

- (void) setTitleAndIconFrame:(NSString *) _title{
    
    if (_title.length>5) {
        _title = [NSString stringWithFormat:@"%@...",[_title substringToIndex:4]] ;
    }
    [self setTitle:_title.length==0?@"全部":_title forState:UIControlStateNormal];
    
    CGSize tSize = [self.titleLabel.text sizeWithFont:defFont14 constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    [img_icon setFrame:CGRectMake(self.frame.size.width/2+tSize.width/2 + 3, 12, 11, 11)];
}

- (void) setTitleIcon:(BOOL) isHightle {
    [img_icon setImage:[UIImage imageNamed:isHightle ? @"icon_down_ora" : @"info_icon_open"]];//▼
}
@end


#define rowHeight   38
//  --.................................................
@implementation DropDownFilterView
@synthesize arrFilterTitle,filterDelegate,dic_SelectValue;

- (id)initWithFrame:(CGRect)frame addViewRef:(UIView*) targetView
       filterHeight:(int) fheight filterTitle:(NSArray *) titles dicSelect:(NSMutableDictionary *) dicselects
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        heightTop = fheight;
        HeightTable = 229;
        widthParentTable = __MainScreen_Width/3;
        widthSubTable = __MainScreen_Width -widthParentTable;
        
        arrDataSource = [[NSMutableArray alloc] initWithCapacity:0];
        arrDataSourceSub = [[resMod_CategoryList alloc] init];
        arrFilterTitle= titles;
        dic_SelectValue = dicselects ? [dicselects mutableCopy]:[[NSMutableDictionary alloc] initWithCapacity:0];
        filterWhere = [[resMod_filterWhere alloc] init];
        
        dicSubRowIndex = [[NSMutableArray alloc] initWithCapacity:0];
        
        viewTopFilter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __MainScreen_Width, heightTop)];
        [viewTopFilter setBackgroundColor:[UIColor clearColor]];
        [self addSubview:viewTopFilter];
    
        btnTransparent = [[UIButton alloc] initWithFrame:CGRectMake(0, heightTop, __MainScreen_Width, 0)];
        [btnTransparent setBackgroundColor:[UIColor blackColor]];
        [btnTransparent setAlpha:0.5];
        [btnTransparent addTarget:self action:@selector(onTransparentClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnTransparent];
        
        [self loadTopFilter];
        [self loadTableView];
        [self addObserver:self forKeyPath:@"arrFilterTitle" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        
        //  -- 下面的阴影
        lbl_bottomshadow = [[UIView alloc] initWithFrame:CGRectMake(0, heightTop-2, __MainScreen_Width, 2)];
        [lbl_bottomshadow setBackgroundColor:[UIColor whiteColor]];
        lbl_bottomshadow.layer.shadowColor = [UIColor blackColor].CGColor;
        lbl_bottomshadow.layer.shadowOffset = CGSizeMake(0, 1);
        lbl_bottomshadow.layer.shadowOpacity = 0.1;
        lbl_bottomshadow.layer.shadowRadius = 0.5;
        [self addSubview:lbl_bottomshadow];
        
        //  --  add
        selfParentView = targetView;
        [targetView addSubview:self];
    }
    return self;
}
#pragma mark    --  load UI
//  --  上面的筛选按钮 区
- (void) loadTopFilter{
    
    for (UIButton * tmpBtn in viewTopFilter.subviews) {
        [tmpBtn removeFromSuperview];
    }
    
    int i=0;
    float btnWidth = __MainScreen_Width/arrFilterTitle.count;
    for (NSString * stmp in arrFilterTitle) {
        
        int btnTag = (arc4random()%9999) + 500 ; //必需随机生成，不然通过currentselbutton.tag对比时就有问题
        
        EC_FilterButton * btnTitle = [[EC_FilterButton alloc] init];
        [btnTitle setTag:  btnTag];
        [btnTitle setBackgroundColor:[UIColor clearColor]];
        [btnTitle setFrame:CGRectMake( btnWidth*i + (i>0 ? 1:0), 1, btnWidth - (i>0 ? 1:0), heightTop-2)];
        NSString * strTitle = stmp;
        for (NSString * sKey in dic_SelectValue.allKeys) {  // -- 显示上次筛选值
            if ([sKey isEqualToString:stmp]) {
                resMod_filterWhere * tmpwhere = [dic_SelectValue objectForKey:sKey];
                strTitle = tmpwhere.subTableVlaue.length==0 ? tmpwhere.parentTableValue : tmpwhere.subTableVlaue;
            }
        }
        [btnTitle setTitleKey:stmp];
        [btnTitle setTitleAndIconFrame:strTitle];
        [btnTitle setTitleColor: color_333333 forState:UIControlStateNormal];
        [btnTitle.titleLabel setFont: defFont14];
        [btnTitle addTarget:self action:@selector(onFilterClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewTopFilter addSubview:btnTitle];
        
        if (i<arrFilterTitle.count-1) {
            [UICommon Common_line:CGRectMake(btnWidth*(i+1), 9, 0.5, heightTop-18) targetView:viewTopFilter backColor:color_b3b3b3];
        }
        i++;
    }
    [self bringSubviewToFront: lbl_bottomshadow];
}

- (void) loadTableView{
    parentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, heightTop, widthParentTable,0) style:UITableViewStylePlain];
    parentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [parentTableView setBackgroundColor: color_ededed];
    parentTableView.delegate = self;
    parentTableView.dataSource = self;
    [parentTableView setShowsVerticalScrollIndicator:YES];
    [self addSubview:parentTableView];
    
    subTableview = [[UITableView alloc] initWithFrame:CGRectMake(widthParentTable, heightTop, widthParentTable, 0) style:UITableViewStylePlain];
    subTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [subTableview setBackgroundColor:[UIColor whiteColor]];
    subTableview.delegate = self;
    subTableview.dataSource = self;
    [subTableview setShowsVerticalScrollIndicator:YES];
    [self addSubview:subTableview];
    [self bringSubviewToFront:viewTopFilter];
}

//  --  数 据 加 载.
- (void) loadFilterDataSoure:(NSString *)filterKey tableSouce:(NSMutableArray*)_arrData FilterType:(DDFilterType)_fType
{
    //  -- 重置
    arrDataSource = _arrData;
    arrDataSourceSub = nil;
    filterWhere = nil;
    filterWhere = [[resMod_filterWhere alloc] init];
    
    int maxNum = arrDataSource.count;
    float allowMaxHeight = __ContentHeight_noNavTab-rowHeight*2;    //允许下拉table的最大高度
    
    //  --加载数据时指定类型
    ddFType = _fType;
    if (_fType==ComplexFilter) {
        widthParentTable = __MainScreen_Width/3;
        widthSubTable    = (__MainScreen_Width/3)*2;
        
        int iSel=0;
        for (int i=0;i<arrDataSource.count;i++) {
            if ([arrDataSource[i] isSelect_parent]) {
                iSel = i;
                continue;
            }
        }
        
        arrDataSourceSub = [arrDataSource objectAtIndex:iSel];
        for (resMod_CategoryList * cinfo in arrDataSource) {    //取最大行
            maxNum  = maxNum>cinfo.TypeList.count ? maxNum:cinfo.TypeList.count;
        }
        HeightTable = maxNum*rowHeight < allowMaxHeight ? maxNum*rowHeight : allowMaxHeight;
        [self addIndexForSubTableView];
    }else {
        widthParentTable = __MainScreen_Width;
        widthSubTable = 0;
        HeightTable = maxNum*rowHeight < allowMaxHeight ? maxNum*rowHeight : allowMaxHeight;
    }
    
    //  --  刷 新 table .
    [parentTableView reloadData];
    [subTableview reloadData];
}

#pragma mark    --  响应事件
- (void) onFilterClick:(id) sender{
    EC_FilterButton * btnTmp = (EC_FilterButton*)sender;
    [selfParentView bringSubviewToFront:self];
    
    HeightTable = 229;
    [viewTabIndex removeFromSuperview];
    
    //  --  如果点击筛选按钮时 有操作
    if ([self.filterDelegate respondsToSelector:@selector(onFilterButtonForDelegateClick:)]) {
        [self.filterDelegate onFilterButtonForDelegateClick:btnTmp.lbl_TitleKey.text];
    }
    
    if (currentSelButton.tag != btnTmp.tag) {
        currentSelButton = btnTmp;
        [self OpenOrCloseFilter:YES];
    }
    else{
        [self OpenOrCloseFilter:isClose];
    }
}

- (void) onTransparentClick:(id) sender{
    [self OpenOrCloseFilter:NO];
}

- (void) OpenOrCloseFilter:(BOOL) isExpansion{
    isClose = !isExpansion;
    [UIView animateWithDuration:0.3
                     animations:^{
                         [parentTableView setFrame:CGRectMake(0, heightTop, widthParentTable, 0)];
                         [subTableview setFrame:CGRectMake(widthParentTable, heightTop, widthSubTable, 0)];
                         //  -- 后面的黑透明层
                         [btnTransparent setHidden:YES];
                         [btnTransparent setAlpha:0];
                         [btnTransparent setFrame:CGRectMake(0, heightTop, __MainScreen_Width, kMainScreenHeight-heightTop - kNavBarViewHeight)];
                         
                         [self setFrame:CGRectMake(0, self.frame.origin.y, self.frame.size.width, heightTop)];
                         if (isExpansion) {
                             [btnTransparent setHidden:NO];
                             [btnTransparent setAlpha:0.5];
                             [self setFrame:CGRectMake(0, self.frame.origin.y, self.frame.size.width, kMainScreenHeight-heightTop - kNavBarViewHeight)];
                             [parentTableView setFrame:CGRectMake(0, heightTop, widthParentTable, HeightTable)];
                             [subTableview setFrame:CGRectMake(widthParentTable, heightTop, widthSubTable, ddFType==SimpleFilter ?0: HeightTable)];
                         }
                     }];
    
    if (!isExpansion) {
        [viewTabIndex removeFromSuperview];
    }
}

#pragma mark    --  Table view
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableView==parentTableView ? arrDataSource.count : arrDataSourceSub.TypeList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * Identifier1 = @"tab1_Cell";
    NSString * Identifier2 = @"tab2_Cell";
    
    int irow = indexPath.row;
    if (tableView==parentTableView) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier1];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell.contentView setBackgroundColor:[UIColor clearColor]];
            
            UILabel * lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, cell.frame.size.width, rowHeight)];
            [lblTitle setTag:10000];
            [lblTitle setBackgroundColor:[UIColor clearColor]];
            [lblTitle setTextColor:color_333333];
            [lblTitle setText:@"狗狗服务"];
            [lblTitle setFont:defFont13];
            [cell.contentView addSubview:lblTitle];
            
            UILabel * lbl_line = [[UILabel alloc] initWithFrame:CGRectMake(0, rowHeight-0.5, widthParentTable, 0.5)];
            [lbl_line setBackgroundColor:[UIColor convertHexToRGB:@"dbdbdb"]];
            [lbl_line setTag:898];
            [cell.contentView addSubview:lbl_line];
        }
        
        UILabel * lbl_10000 = (UILabel*)[cell.contentView viewWithTag:10000];
        UILabel * lbl_898   = (UILabel*)[cell.contentView viewWithTag:898];
        
        if (arrDataSource.count>0) {
            resMod_CategoryList * tmpList = [arrDataSource objectAtIndex:irow];
            [lbl_10000 setText:tmpList.TypeName];
            [lbl_898 setFrame:CGRectMake(0, rowHeight-0.5, widthParentTable, 0.5)];
            
            if (tmpList.isSelect_parent) {
                [lbl_10000 setTextColor: color_fc4a00];
                [cell setBackgroundColor:[UIColor whiteColor]];
                [cell.contentView setBackgroundColor:[UIColor whiteColor]];
            }
            else{
                [lbl_10000 setTextColor: color_333333];
                [cell setBackgroundColor:[UIColor clearColor]];
                [cell.contentView setBackgroundColor:[UIColor clearColor]];
            }
        }

        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier2];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier2];
            
            UILabel * lblTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, cell.frame.size.width, rowHeight)];
            [lblTitle2 setTag:20000];
            [lblTitle2 setBackgroundColor:[UIColor clearColor]];
            [lblTitle2 setText:@"洗澡造型"];
            [lblTitle2 setFont:defFont13];
            [cell.contentView addSubview:lblTitle2];
            
            //  -- 线
            [UICommon Common_line:CGRectMake(0, rowHeight-0.5, widthSubTable, 0.5) targetView:cell.contentView backColor:[UIColor convertHexToRGB:@"e7e7e7"]];
        }
        
        if (arrDataSourceSub!=nil) {
            resMod_CategoryInfo *tmpInfo = [arrDataSourceSub.TypeList objectAtIndex:irow];
            UILabel * lbl_20000 = (UILabel*)[cell.contentView viewWithTag:20000];
            [lbl_20000 setText:tmpInfo.SubTypeName];
            
            if (tmpInfo.isChecked)
                [lbl_20000 setTextColor:color_fc4a00];
            else
                [lbl_20000 setTextColor:[UIColor blackColor]];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    int irow = indexPath.row;
    
    if (tableView == parentTableView) {
        
        if (ddFType == ComplexFilter) {
            //  --更新 subDataSouce.
            arrDataSourceSub = arrDataSource[irow];
            [self addIndexForSubTableView];
            [subTableview reloadData];
        }
        
        filterWhere.parentTableId    = [[arrDataSource objectAtIndex:irow] CategoryId];
        filterWhere.parentTableValue = [[arrDataSource objectAtIndex:irow] TypeName];
        
        //  --选中
        for (int i=0 ;i<arrDataSource.count;i++) {
            [arrDataSource[i] setIsSelect_parent: i==irow ? YES : NO];
        }
        [parentTableView reloadData];
    }
    else if(tableView == subTableview){
        
        //  --如果是上面的a,b,c...索引
        if ([arrDataSourceSub.TypeList[irow] SubTypeName].length==1) {
            return;
        }

        //  --选中
        for (int i=0 ;i<arrDataSourceSub.TypeList.count;i++) {
            [arrDataSourceSub.TypeList[i] setIsChecked: i==irow ? YES : NO];
        }
        
        if (arrDataSourceSub!=nil && arrDataSourceSub.TypeList.count>0) {
            resMod_CategoryInfo * tmpinfo = arrDataSourceSub.TypeList[irow];
            filterWhere.subTableId =[NSString stringWithFormat:@"%d",tmpinfo.SubTypeId];
            filterWhere.subTableVlaue = tmpinfo.SubTypeName;
            filterWhere.subTableProperty1 = tmpinfo.Type;
        }
    }
    
    [dic_SelectValue setObject:filterWhere forKey: currentSelButton.lbl_TitleKey.text];
    
    
    //  --  回调 功能查找.
    if(tableView == subTableview || ddFType == SimpleFilter){
        
        //  -- ParentTable
        UILabel * lbl_10000 = (UILabel*)[cell.contentView viewWithTag:10000];
        //  -- SubTable
        UILabel * lbl_20000 = (UILabel*)[cell.contentView viewWithTag:20000];
        
        //  -- 显示选定值
        EC_FilterButton * fbtn = (EC_FilterButton*)[viewTopFilter viewWithTag:currentSelButton.tag];
        [fbtn setTitleAndIconFrame:(ddFType==SimpleFilter ? lbl_10000.text:lbl_20000.text)];
        
        if ([self.filterDelegate respondsToSelector: @selector(onDelegateForSearch)]) {
            [self.filterDelegate onDelegateForSearch];
        }
    }
    
    //  --  收起.
    if (ddFType == ComplexFilter) {
        if (tableView == subTableview) [self OpenOrCloseFilter:NO];
    }else{
        [self OpenOrCloseFilter:NO];
    }
}


#pragma mark    --  键值检测
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"arrFilterTitle"]) {
        //        NSArray * newObj = [change objectForKey:NSKeyValueChangeNewKey];
        //        NSArray * oldObj = [change objectForKey:NSKeyValueChangeOldKey];
        
        [self OpenOrCloseFilter:NO];
        [self loadTopFilter];
    }
}

#pragma mark    --  添加右边索引
- (void) addIndexForSubTableView{
    
    for (UILabel * lbl in viewTabIndex.subviews) {
        [lbl removeFromSuperview];
    }
    [viewTabIndex removeFromSuperview];
    
    if ([arrDataSourceSub.TypeName isEqualToString:@"全部地区"]) {
        if (dicSubRowIndex.count==0) {
            int irow=0;
            for (resMod_CategoryInfo * cinfo in arrDataSourceSub.TypeList) {
                if (cinfo.SubTypeId==0 && cinfo.SubTypeName.length==1) {
                    cinfo.SubTypeId = irow;     //反正subtypeid是0, 在这里就当行来用 ：表示在原数据源里是第几行
                    [dicSubRowIndex addObject:cinfo];
                }
                irow++;
            }
        }
    }
    else{
        return;
    }
    
    if (!viewTabIndex) {
        viewTabIndex = [[UIView alloc]initWithFrame:CGRectZero];
        [viewTabIndex setTag:24023];
        [viewTabIndex setBackgroundColor:[UIColor clearColor]];
    }
    
    int itag=0;
    widthParentTable = __MainScreen_Width/3;
    widthSubTable    = widthParentTable*2;
    [viewTabIndex setFrame:CGRectMake(__MainScreen_Width-25, heightTop, 25,HeightTable)];
    int fheight = viewTabIndex.frame.size.height/dicSubRowIndex.count;
    for (resMod_CategoryInfo * skey in dicSubRowIndex) {
        UILabel * lblidx = [[UILabel alloc] init];
        [lblidx setBackgroundColor:[UIColor clearColor]];
        [lblidx setFrame:CGRectMake(0, fheight*itag, viewTabIndex.frame.size.width, fheight)];
        [lblidx setText:skey.SubTypeName];
        [lblidx setTextAlignment:NSTextAlignmentCenter];
        [lblidx setTextColor:color_8fc31f];//[UIColor convertHexToRGB:@"07a0e8"]];
        [lblidx setFont:defFont(YES, 10)];
        [viewTabIndex addSubview:lblidx];
        itag++;
    }
    [self addSubview:viewTabIndex];
    [self bringSubviewToFront:viewTabIndex];
}

- (void)scrollToSubTableRow:(NSSet *) touches{
    UITouch *touch = [touches anyObject];
    UIView * viewTmp = touch.view;
    if (viewTmp.tag==24023) {
        
        CGPoint currentPosition = [touch locationInView:viewTabIndex];
        int fheight = viewTabIndex.frame.size.height/dicSubRowIndex.count;
        int idx = currentPosition.y/fheight;//ceil(currentPosition.y/fheight);
        if (dicSubRowIndex.count>idx) {
            int inTableRow = [dicSubRowIndex[idx] SubTypeId];   //  -- 因为SubTypeId在上面已处理为在原数据行索引
            NSIndexPath * indexpath = [subTableview indexPathForRowAtPoint:CGPointMake(0, inTableRow*rowHeight)];
            [subTableview scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self scrollToSubTableRow:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self scrollToSubTableRow:touches];
}
@end







