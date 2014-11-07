//
//  MallProductCommentController.h
//  boqiimall
//
//  Created by YSW on 14-7-15.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "resMod_Mall_OrderComment.h"
#import "TableCell_MallComment.h"

@interface MallProductCommentController : BQIBaseViewController<TableCellMallCommentDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    UITableView * rootTableView;
    resMod_Mall_OrderCommentInfo * orderCommentInfo;
}

@property (nonatomic,strong)  NSString * param_OrderID;
@end
