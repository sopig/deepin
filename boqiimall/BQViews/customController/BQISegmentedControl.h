//
//  BQISegmentedControl.h
//  boqiimall
//
//  Created by 波奇-xiaobo on 14-8-28.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  BQISegmentedControlDelegate<NSObject>

@optional
- (void) onBQISegmentedControlSelected:(int) selectIndex;

@end


@interface BQISegmentedControl : UIView
{
    UIButton *btn_1;
    UIButton *btn_2;
    
    
    NSString * img1_nomal;
    NSString * img2_nomal;
    
    NSString * img1_press;
    NSString * img2_press;
 
}

@property(nonatomic,assign)id<BQISegmentedControlDelegate>delegate;

- (id)initWithFrame:(CGRect)frame
          btntitle1:(NSString *) _title1 btn1Img:(NSString *) _img1
          btntitle2:(NSString *) _title2 btn2Img:(NSString *) _img2
          img1Press:(NSString *) _img1Press img2press:(NSString *) _img2press;

//- (void)setSelectedIndex:(NSInteger)index;



@end
