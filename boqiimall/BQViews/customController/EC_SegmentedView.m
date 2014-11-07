//
//  EC_SegmentedView.m
//  BoqiiLife
//
//  Created by YSW on 14-5-15.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "EC_SegmentedView.h"

@implementation EC_SegmentedView
@synthesize segmentDelegate;

- (id)initWithFrame:(CGRect)frame
          btntitle1:(NSString *) _title1 btn1Img:(NSString *) _img1
          btntitle2:(NSString *) _title2 btn2Img:(NSString *) _img2
          img1Press:(NSString *) _img1Press img2press:(NSString *) _img2press
{
    self = [super initWithFrame:frame];
    if (self) {
        
        btnTitle1 = _title1;
        btnTitle2 = _title2;
        
        img1_nomal = _img1;
        img1_press = _img1Press;
        
        img2_nomal = _img2;
        img2_press = _img2press;
        
        
        btn_1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        [btn_1 setTag:9090];
        [btn_1 setBackgroundColor:[UIColor clearColor]];
        if (img1_press.length>0) {
            [btn_1 setImage:[UIImage imageNamed: img1_press] forState:UIControlStateNormal];
        }
        [btn_1 setTitle:[NSString stringWithFormat:@" %@",btnTitle1] forState:UIControlStateNormal];
        [btn_1.titleLabel setFont:defFont14];
        [btn_1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_1 setBackgroundImage:def_ImgStretchable(@"btn_banyuan_left", 6, 6)forState:UIControlStateNormal];
        [self addSubview:btn_1];
        
        btn_2 = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height)];
        [btn_2 setTag:9091];
        [btn_2 setBackgroundColor:[UIColor clearColor]];
        if (img2_nomal.length>0) {
            [btn_2 setImage:[UIImage imageNamed: img2_nomal] forState:UIControlStateNormal];
        }
        [btn_2 setTitle:[NSString stringWithFormat:@" %@",_title2] forState:UIControlStateNormal];
        [btn_2.titleLabel setFont:defFont14];
        [btn_2 setTitleColor:color_fc4a00 forState:UIControlStateNormal];
        [btn_2 setBackgroundImage:def_ImgStretchable(@"btn_banyuan_white_right", 6, 6)forState:UIControlStateNormal];
        [self addSubview:btn_2];
        
        [btn_1 addTarget:self action:@selector(segmanetDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [btn_2 addTarget:self action:@selector(segmanetDidSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void) segmanetDidSelected:(UIButton*) sender{
    
    int idx = sender.tag==9090 ? 0 :1;
//    if (sender.tag==9090) {
//        
//        //  -- 设置按钮样式
//        [btn_1 setBackgroundImage:def_ImgStretchable(@"btn_banyuan_white_left", 6, 6)forState:UIControlStateNormal];
//        [btn_1 setImage:[UIImage imageNamed: img1_press] forState:UIControlStateNormal];
//        [btn_1 setTitleColor:color_fc4a00 forState:UIControlStateNormal];
//        
//        [btn_2 setImage:[UIImage imageNamed: img2_nomal] forState:UIControlStateNormal];
//        [btn_2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btn_2 setBackgroundImage:def_ImgStretchable(@"btn_banyuan_right", 6, 6)forState:UIControlStateNormal];
//    }
//    else if (sender.tag == 9091){
//        
//        idx = 1;
//        //  -- 设置按钮样式
//        [btn_1 setBackgroundImage:def_ImgStretchable(@"btn_banyuan_left", 10, 8)forState:UIControlStateNormal];
//        [btn_1 setImage:[UIImage imageNamed: img1_nomal] forState:UIControlStateNormal];
//        [btn_1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        
//        [btn_2 setImage:[UIImage imageNamed: img2_press] forState:UIControlStateNormal];
//        [btn_2 setTitleColor:color_fc4a00 forState:UIControlStateNormal];
//        [btn_2 setBackgroundImage:def_ImgStretchable(@"btn_banyuan_white_right", 6, 6)forState:UIControlStateNormal];
//
//    }
    
    [self setButtonIndex:idx];
    
    if([segmentDelegate respondsToSelector:@selector(onSegmentedClick:)]){
        [segmentDelegate onSegmentedClick:idx];
    }
}


- (void) setButtonIndex:(int) i_idx{
    
    if (i_idx==0) {
        
        //  -- 设置按钮样式
        [btn_1 setBackgroundImage:def_ImgStretchable(@"btn_banyuan_left", 6, 6)forState:UIControlStateNormal];
        if (img1_press.length>0) {
            [btn_1 setImage:[UIImage imageNamed: img1_press] forState:UIControlStateNormal];
        }
        [btn_1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        if (img2_nomal.length>0) {
            [btn_2 setImage:[UIImage imageNamed: img2_nomal] forState:UIControlStateNormal];
        }
        [btn_2 setTitleColor:color_fc4a00 forState:UIControlStateNormal];
        [btn_2 setBackgroundImage:def_ImgStretchable(@"btn_banyuan_white_right.png", 6, 6)forState:UIControlStateNormal];
    }
    else if (i_idx == 1){
        //  -- 设置按钮样式
        [btn_1 setBackgroundImage:def_ImgStretchable(@"btn_banyuan_white_left.png", 10, 8)forState:UIControlStateNormal];
        if (img1_nomal.length>0) {
            [btn_1 setImage:[UIImage imageNamed: img1_nomal] forState:UIControlStateNormal];
        }
        [btn_1 setTitleColor:color_fc4a00 forState:UIControlStateNormal];
        
        if (img2_press.length>0) {
            [btn_2 setImage:[UIImage imageNamed: img2_press] forState:UIControlStateNormal];
        }
        [btn_2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_2 setBackgroundImage:def_ImgStretchable(@"btn_banyuan_right.png", 6, 6)forState:UIControlStateNormal];
        
    }
}

@end









