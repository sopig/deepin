//
//  PullToRefreshFooterView.m
//  FrameTest
//
//  Created by iXiaobo on 14-9-23.
//  Copyright (c) 2014年 iXiaobo. All rights reserved.
//

#import "PullToRefreshFooterView.h"
#define kImageWidth 50
#define kImageHeight 50
#define kHeight 65

@implementation PullToRefreshFooterView
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, kImageWidth,kImageWidth)];
        CGPoint center = _imageView.center;
        center.x = self.center.x;
        [_imageView setCenter:center];
        
        _imageView.animationImages = [NSArray arrayWithObjects:
                                           [UIImage imageNamed:@"loding_pic2.png"],
                                           [UIImage imageNamed:@"loding_pic3.png"],
                                           [UIImage imageNamed:@"loding_pic4.png"],
                                           nil];
        _imageView.animationDuration = 1.5;
        _imageView.animationRepeatCount = 0;
        [self addSubview:_imageView];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([_imageView isAnimating])
    {
        
    }
    else
    {
        [_imageView stopAnimating];
        [_imageView setImage:[UIImage imageNamed:@"loding_pic1.png"]];
        
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
{
    /*
    if (![_firstImageView isAnimating])
    {
        if (scrollView.contentOffset.y < kContentOffsetY)
        {
            [_firstImageView startAnimating];
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.3];
            scrollView.contentInset = UIEdgeInsetsMake(kContentOffsetY*-1, 0.0f, 0.0f, 0.0f);
            [UIView commitAnimations];
            if ([delegate respondsToSelector:@selector(onPullToRefreshHeaderViewDidTriggerRefresh:)])
            {
                [delegate onPullToRefreshHeaderViewDidTriggerRefresh:self];
            }
        }
        
    }
     */
    
    
    
    if (![_imageView isAnimating])
    {
        if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.bounds.size.height + kHeight))
        {
            [_imageView startAnimating];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.1];
            scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, kHeight, 0.0f);
            [UIView commitAnimations];
         //   scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, kHeight, 0.0f);
            if ([delegate respondsToSelector:@selector(onPullToRefreshFooterViewDidTriggerRefresh:)])
            {
                [delegate onPullToRefreshFooterViewDidTriggerRefresh:self];
            }
        }
        else
        {
            scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, 0.0f, 0.0f);
        }
       
    }
    else
    {
        if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.bounds.size.height + kHeight))
        {
        
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.1];
            scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, kHeight, 0.0f);
            [UIView commitAnimations];
          //  scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, kHeight, 0.0f);
        }
        else
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:.3];
            scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, 0.0f, 0.0f);
            [UIView commitAnimations];
           // scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, 0.0f, 0.0f);
            
        }

        
    }
}

- (void)scrollViewDidLoadingFinished:(UIScrollView *)scrollView
{
    [_imageView stopAnimating];
   
    [UIView commitAnimations];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.1];
    scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, 0.0f, 0.0f);
    [UIView commitAnimations];
    
    
}


@end
