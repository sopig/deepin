//
//  UserInfoViewController.h
//  BoqiiLife
//
//  Created by YSW on 14-5-14.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "EC_UIScrollView.h"
#import "IBActionSheet.h"

@interface UserInfoViewController : BQIBaseViewController<UIScrollViewDelegate,UIActionSheetDelegate, IBActionSheetDelegate>{
    EC_UIScrollView * rootScrollView;
    UIButton * btn_QuitCurrent;
    
    int isex;
}
@end
