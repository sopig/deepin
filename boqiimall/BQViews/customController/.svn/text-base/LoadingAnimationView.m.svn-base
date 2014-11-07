//
//  LoadingAnimationView.m
//  boqiimall
//
//  Created by YSW on 14-8-13.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "LoadingAnimationView.h"

@implementation LoadingAnimationView
@synthesize hasDisplayed;
@synthesize loadingAnimal;
@synthesize AnimalImages;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setHidden:YES];
        [self setBackgroundColor:[UIColor whiteColor]];
        hasDisplayed = NO;

        //  -- 加载时，屏幕中间的动画
        CGRect selfViewFrame = frame;
        
        loadingAnimal  = [[UIView alloc] initWithFrame:selfViewFrame];
        [loadingAnimal setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:loadingAnimal];
        
        UIImageView *fishbg = [[UIImageView alloc] initWithFrame:CGRectMake(selfViewFrame.size.width/2-260/4, selfViewFrame.size.height/4, 260/2, 131/2)];
        [fishbg setBackgroundColor:[UIColor clearColor]];
        [fishbg setImage:[UIImage imageNamed:@"loadingTopBG.png"]];
        [loadingAnimal addSubview:fishbg];
        
        AnimalImages = [[UIImageView alloc] initWithFrame:CGRectMake(selfViewFrame.size.width/2-100/4, CGRectGetMaxY(fishbg.frame)+20, 50, 50)];
        [AnimalImages setTag:6238238];
        [AnimalImages setBackgroundColor:[UIColor clearColor]];
        [loadingAnimal addSubview:AnimalImages];
    }
    return self;
}

- (void)stopLoadingAnimal{
    
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         hasDisplayed = YES;
                         [AnimalImages stopAnimating];
                         [self setHidden:YES];
                     }];
}

- (void) startLoadingAnimal{
    if (hasDisplayed) {
        return;
    }
    [self.superview bringSubviewToFront:self];
    [self setHidden:NO];
    NSArray *myImages = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"loding_pic2.png"],
                         [UIImage imageNamed:@"loding_pic3.png"],
                         [UIImage imageNamed:@"loding_pic4.png"],
                         [UIImage imageNamed:@"loding_pic3.png"], nil];
    AnimalImages.animationImages = myImages;
    AnimalImages.animationDuration = 1;
    AnimalImages.animationRepeatCount = 0;
    [AnimalImages startAnimating];
}
@end
