//
//  BQGrouponSegmentedView.m
//  boqiimall
//
//  Created by iXiaobo on 14-9-23.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQGrouponSegmentedView.h"
#import "UIColor+ColorUtility.h"

@implementation BQGrouponSegmentedView
@synthesize delegate;
@synthesize isEnable;


- (id)initWithFrame:(CGRect)frame withItems:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        itemsArray = items;
        
        CGFloat frameWidth = frame.size.width;
        CGFloat frameHeigth = frame.size.height;
        NSInteger count = items.count;
        CGFloat itemFrameWidth = (frameWidth - (count - 1)*0.5)/count;
        UIView *upBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, 0.5)];
        [upBarView setBackgroundColor:[UIColor whiteColor]];
        upBarView.layer.shadowColor = [UIColor blackColor].CGColor;
        upBarView.layer.shadowOffset = CGSizeMake(0, 1);
        upBarView.layer.shadowOpacity = 0.1;
        upBarView.layer.shadowRadius = 0.5;
        [self addSubview:upBarView];
        
        UIView *downBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, frameHeigth-1)];
        [downBarView setBackgroundColor:[UIColor whiteColor]];
        downBarView.layer.shadowColor = [UIColor blackColor].CGColor;
        downBarView.layer.shadowOffset = CGSizeMake(0, 0.5);
        downBarView.layer.shadowOpacity = 0.3;
        downBarView.layer.shadowRadius = 1;
        
        [self addSubview:downBarView];
        for (int i = 0; i < count; i++)
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((itemFrameWidth+0.5)*i, 1, itemFrameWidth, (frameHeigth - 4))];
            [btn setTitle:[items objectAtIndex:i] forState:UIControlStateNormal];
            btn.tag = i;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            if (i == 0)
            {
                [btn setTitleColor:color_fc4a00 forState:UIControlStateNormal];
            }
            else
            {
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i != 0)
            {
                UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(itemFrameWidth*i, frameHeigth/3.0, 0.5, frameHeigth/3.0)];
                [separatorLineView setBackgroundColor:color_d1d1d1];
                [self addSubview:separatorLineView];
            }
          
            isEnable = YES;
        }
        
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.layer.shadowOffset = CGSizeMake(0,0.4);
//        self.layer.shadowRadius = 1.0f;
//        self.layer.shadowOpacity = 0.2f;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setSelectedIndex:(NSInteger)index
{

    
    for (UIView *view in [self subviews])
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *myBtn = (UIButton *)view;
            if (view.tag == index)
            {
                [myBtn setTitleColor:color_fc4a00 forState:UIControlStateNormal];
            }
            else
            {
                [myBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
        }
    }
    
}



- (void)onBtnClick:(id)sender
{
    if (!isEnable)
    {
        return;
    }
    UIButton *selectedBtn = (UIButton *)sender;
    for (UIView *view in [self subviews])
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *myBtn = (UIButton *)view;
            if (view.tag == selectedBtn.tag)
            {
                [selectedBtn setTitleColor:color_fc4a00 forState:UIControlStateNormal];
            }
            else
            {
                [myBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            
        }
    }
    if ([delegate respondsToSelector:@selector(onBQGrouponSegmentedViewSelected:)])
    {
        [delegate onBQGrouponSegmentedViewSelected:[itemsArray objectAtIndex:selectedBtn.tag]];
    }
}




@end
