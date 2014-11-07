//
//  PullToRefreshHeaderView.m
//  FrameTest
//
//  Created by iXiaobo on 14-9-23.
//  Copyright (c) 2014年 iXiaobo. All rights reserved.
//

#import "PullToRefreshHeaderView.h"

#define kFirstImageWidth 50
#define kFirstImageHeight 50

#define kSecondImageWidth 90
#define kSecondImageHeight 65

#define kContentOffsetY -50

@implementation PullToRefreshHeaderView
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        
        _firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,frame.size.height-kFirstImageHeight, kFirstImageWidth,kFirstImageHeight)];
        CGPoint center = _firstImageView.center;
        center.x = self.center.x;
        [_firstImageView setCenter:center];
       // [_firstImageView setImage:[UIImage imageNamed:@"loding_pic2.png"]];
        _firstImageView.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"loding_pic2.png"],
                                           [UIImage imageNamed:@"loding_pic3.png"],
                                           [UIImage imageNamed:@"loding_pic4.png"],
                                           nil];
        
         _firstImageView.animationDuration = 1.5;
         _firstImageView.animationRepeatCount = 0;
        [self addSubview:_firstImageView];
        _secondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (frame.size.height - kFirstImageHeight - kSecondImageHeight) , kSecondImageWidth,kSecondImageHeight)];
        center = _secondImageView.center;
        center.x = self.center.x;
        [_secondImageView setCenter:center];
        [_secondImageView setImage:[UIImage imageNamed:@"loadingTopBG.png"]];
        [self addSubview:_secondImageView];
    }
    return self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([_firstImageView isAnimating])
    {
        
    }
    else
    {
        [_firstImageView stopAnimating];
        [_firstImageView setImage:[UIImage imageNamed:@"loding_pic1.png"]];
        
    }
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
{
    if (![_firstImageView isAnimating])
    {
       
        if (scrollView.contentOffset.y < kContentOffsetY)
        {
            [_firstImageView startAnimating];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.1];
            [scrollView setContentInset:UIEdgeInsetsMake(kContentOffsetY*-1, 0.0f, 0.0f, 0.0f)];
            [UIView commitAnimations];
            if ([delegate respondsToSelector:@selector(onPullToRefreshHeaderViewDidTriggerRefresh:)])
            {
                [delegate onPullToRefreshHeaderViewDidTriggerRefresh:self];
            }
        }

    }
    else
    {
       
//            if (scrollView.contentOffset.y < kContentOffsetY)
//            {
//                [UIView beginAnimations:nil context:NULL];
//                [UIView setAnimationDuration:.1];
//                scrollView.contentInset = UIEdgeInsetsMake(kContentOffsetY*-1, 0.0f, 0.0f, 0.0f);
//                [UIView commitAnimations];
//            }
//            else
//            {
//                scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, 0.0f, 0.0f);
//                
//            }
    }
    
}
- (void)scrollViewDidLoadingFinished:(UIScrollView *)scrollView
{
    [_firstImageView stopAnimating];
//    [UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:0.1];
//	[scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
//	[UIView commitAnimations];
    [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
}

- (void)dealloc
{
    [_firstImageView stopAnimating];
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
