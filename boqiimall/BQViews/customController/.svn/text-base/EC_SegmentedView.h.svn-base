//
//  EC_SegmentedView.h
//  BoqiiLife
//
//  Created by YSW on 14-5-15.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  EC_SegmentedViewDelegate<NSObject>

@optional
- (void) onSegmentedClick:(int) selectIndex;

@end

@interface EC_SegmentedView : UIView{
    UIButton * btn_1;
    UIButton * btn_2;
    
    NSString * btnTitle1;
    NSString * btnTitle2;
    
    NSString * img1_nomal;
    NSString * img2_nomal;
    
    NSString * img1_press;
    NSString * img2_press;
}


@property (nonatomic,assign) id<EC_SegmentedViewDelegate> segmentDelegate;

- (id)initWithFrame:(CGRect)frame
          btntitle1:(NSString *) _title1 btn1Img:(NSString *) _img1
          btntitle2:(NSString *) _title2 btn2Img:(NSString *) _img2
          img1Press:(NSString *) _img1Press img2press:(NSString *) _img2press;

//  -- 选中
- (void) setButtonIndex:(int) i_idx;

@end
