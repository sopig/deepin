//
//  BQStarRatingView.m
//  boqiimall
//
//  Created by 张正超 on 14-7-16.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQStarRatingView.h"

@interface BQStarRatingView ()
{
    BOOL isShow;
    BOOL isAdd;
}
@property (nonatomic, strong) UIView *starBackgroundView;
@property (nonatomic, strong) UIView *starForegroundView;



@end


#define RatingStar 0
#define ShowStar 1


#define SHOW_ALL_STAR 0
#define SHOW_NONE_STAR 1

@implementation BQStarRatingView

- (id)initWithFrame:(CGRect)frame
{
    
   return [self initWithFrame:frame numberOfStar:5 withStatue:RatingStar];
}

- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number withStatue:(NSUInteger)ststueNo
{
    isShow = NO;
    isAdd = NO;
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfStar = number;
        if (ststueNo == RatingStar) {
            self.starBackgroundView = [self buidlStarViewWithImageName:@"like_btn_big_nor.png"];
            self.starForegroundView = [self buidlStarViewWithImageName:@"like_btn_big_sel.png"];
        }
        else if (ststueNo == ShowStar){
            isShow = YES;
            self.starBackgroundView = [self buidlStarViewWithImageName:@"like_btn_nor.png"];
            self.starForegroundView = [self buidlStarViewWithImageName:@"like_btn_sel.png"];
        }
       
        [self addSubview:self.starBackgroundView];
#if SHOW_ALL_STAR
        [self addSubview:self.starForegroundView];
#endif
    }
    return self;


}


//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    if (!isShow) {
//        UITouch *touch = [touches anyObject];
//        CGPoint point = [touch locationInView:self];
//        CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        if(CGRectContainsPoint(rect,point))
//        {
//            [self changeStarForegroundViewWithPoint:point];
//        }
//    }
//}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!isShow) {
#if SHOW_NONE_STAR
        [self addSubview:self.starForegroundView];
#endif
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        __weak BQStarRatingView * weekSelf = self;
        
        [UIView transitionWithView:self.starForegroundView
                          duration:0.1
                           options:UIViewAnimationOptionCurveEaseInOut
                        animations:^
         {
             [weekSelf changeStarForegroundViewWithPoint:point];
         }
                        completion:^(BOOL finished)
         {
             
         }];

    }
    
}

- (UIView *)buidlStarViewWithImageName:(NSString *)imageName
{
    CGRect frame = self.bounds;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.clipsToBounds = YES;
    for (int i = 0; i < self.numberOfStar; i++)
    {
        if (isShow) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar , frame.size.height );
            [view addSubview:imageView];
        }else{
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
            imageView.frame = CGRectMake(i * frame.size.width / self.numberOfStar, 0, frame.size.width / self.numberOfStar - 10 , frame.size.height - 10 );
            [view addSubview:imageView];
        }
       
    }
    return view;
}

- (void)changeStarForegroundViewWithPoint:(CGPoint)point  //
{
    CGPoint p = point;
    
    if (p.x < 0)
    {
        p.x = 0;
    }
    else if (p.x > self.frame.size.width)
    {
        p.x = self.frame.size.width;
    }
    
    NSString * str = [NSString stringWithFormat:@"%.2f",p.x / self.frame.size.width *5];
    float score = [str floatValue];
    p.x = (int)score * self.frame.size.width / self.numberOfStar + 25;
//     p.x = score * self.frame.size.width / self.numberOfStar;
    self.starForegroundView.frame = CGRectMake(0, 0, p.x , self.frame.size.height);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(starRatingView: score:)])
    {
        [self.delegate starRatingView:self score:score];
    }
}

- (void)setScoreVale:(float)scoreVale
{
    self.starForegroundView.frame = CGRectMake(0, 0, scoreVale*self.frame.size.width/self.numberOfStar , self.frame.size.height);
    if (!isAdd) {
        [self addSubview:self.starForegroundView];
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
