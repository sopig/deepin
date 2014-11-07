//
//  FirstOpenApp_CheckMallCategory.h
//  boqiimall
//
//  Created by YSW on 14-7-24.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheckMallCategoryDelegate <NSObject>
@optional
- (void) setCheckedAnimalClass:(int) selIndex;
@end



@interface FirstOpenApp_CheckMallCategory : UIView{
    
    NSDictionary * dicColor;
    UIButton * btnok;
    UIButton * selectedButton;
    
    NSArray  * arrCategorys;
}

@property (assign,nonatomic) id<CheckMallCategoryDelegate> firstSelCategoryDelegate;
@property (assign,nonatomic) float ypointSuperView;

- (void) loadContent:(NSArray*) parr;
@end
