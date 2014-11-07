//
//  BQISegmentedControl.m
//  boqiimall
//
//  Created by 波奇-xiaobo on 14-8-28.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQISegmentedControl.h"

@implementation BQISegmentedControl
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
          btntitle1:(NSString *) _title1 btn1Img:(NSString *) _img1
          btntitle2:(NSString *) _title2 btn2Img:(NSString *) _img2
          img1Press:(NSString *) _img1Press img2press:(NSString *) _img2press
{
    self = [super initWithFrame:frame];
    if (self)
    {
        img1_nomal = _img1;
        img1_press = _img1Press;
        
        img2_nomal = _img2;
        img2_press = _img2press;
        
        btn_1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        [btn_1 setTitle:[NSString stringWithFormat:@" %@",_title1] forState:UIControlStateNormal];
        [btn_1.titleLabel setFont:defFont14];
        [btn_1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn_1 setBackgroundImage:def_ImgStretchable(img1_press, 6, 6)forState:UIControlStateNormal];
        [self addSubview:btn_1];
        
        btn_2 = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height)];
        [btn_2 setTitle:[NSString stringWithFormat:@" %@",_title2] forState:UIControlStateNormal];
        [btn_2.titleLabel setFont:defFont14];
        [btn_2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn_2 setBackgroundImage:def_ImgStretchable(img2_nomal, 6, 6)forState:UIControlStateNormal];
       [self addSubview:btn_2];
        
        [btn_1 addTarget:self action:@selector(segmentedDidSelected:) forControlEvents:UIControlEventTouchUpInside];
        [btn_2 addTarget:self action:@selector(segmentedDidSelected:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
    
    
}




- (void)segmentedDidSelected:(UIButton *)sender
{
    NSInteger index = 0;
    
    if ([sender isEqual:btn_1])
    {
        index = 0;
    }
    else if ([sender isEqual:btn_2])
    {
        index = 1;
    }
    
    [self setBtnIndex:index];
    
    if ([delegate respondsToSelector:@selector(onBQISegmentedControlSelected:)])
    {
        [delegate onBQISegmentedControlSelected:index];
    }
}


- (void)setBtnIndex:(NSInteger)index
{
   
    if (index==0) {
        
        //  -- 设置按钮样式
        
        [btn_1 setBackgroundImage:def_ImgStretchable(img1_press, 6, 6)forState:UIControlStateNormal];
 
        [btn_1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [btn_2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn_2 setBackgroundImage:def_ImgStretchable(img2_nomal, 6, 6)forState:UIControlStateNormal];
    }
    else if (index == 1){
        //  -- 设置按钮样式
       // [btn_1 setBackgroundColor:[UIColor clearColor]];
        
        [btn_1 setBackgroundImage:def_ImgStretchable(img1_nomal, 6, 6)forState:UIControlStateNormal];

        [btn_1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        
        [btn_2 setBackgroundImage:def_ImgStretchable(img2_press, 6, 6)forState:UIControlStateNormal];
        [btn_2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
