//
//  FirstOpenApp_CheckMallCategory.m
//  boqiimall
//
//  Created by YSW on 14-7-24.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "FirstOpenApp_CheckMallCategory.h"
#import <POP/POP.h>

#define txtWelcome  @"欢迎来到波奇宠物"
#define txtSelectAnimal @"宠物选择"

#define btnTag      68727
#define btnWidth    80
#define btnHeight   80

@implementation FirstOpenApp_CheckMallCategory
@synthesize firstSelCategoryDelegate;
@synthesize ypointSuperView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
        dicColor = [[NSDictionary alloc] initWithObjectsAndKeys:
                    @"F53876|else_sel"  ,@"其它",
                    @"FF4F4F|dog_sel"   ,@"狗狗",
                    @"FEB22F|cat_sel"   ,@"猫猫",
                    @"25A9FF|mouse_sel" ,@"小宠",
                    @"8FC31F|fish_sel"  ,@"水族",nil];
    }
    return self;
}


- (void) loadContent:(NSArray*) parr{
    
    arrCategorys = parr;
    
    UILabel * lbl_welcome = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, __MainScreen_Width, 60)];
    [lbl_welcome setBackgroundColor:[UIColor clearColor]];
    [lbl_welcome setText:txtWelcome];
    [lbl_welcome setTextColor:[UIColor whiteColor]];
    [lbl_welcome setTextAlignment:NSTextAlignmentCenter];
    [lbl_welcome setFont:defFont(YES, 20)];
    [self addSubview:lbl_welcome];
    
    UILabel * lbl_selanimal = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, __MainScreen_Width, 30)];
    [lbl_selanimal setBackgroundColor:[UIColor clearColor]];
    [lbl_selanimal setText:txtSelectAnimal];
    [lbl_selanimal setTextColor:[UIColor whiteColor]];
    [lbl_selanimal setTextAlignment:NSTextAlignmentCenter];
    [lbl_selanimal setFont:defFont(YES, 18)];
    [self addSubview:lbl_selanimal];
    
    CGSize tsize = [txtSelectAnimal sizeWithFont:defFont(YES, 18) constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    float fwidth = (__MainScreen_Width-tsize.width-20-80)/2;
    [UICommon Common_line:CGRectMake(40, lbl_selanimal.frame.origin.y+15, fwidth, 1) targetView:self backColor:[UIColor whiteColor]];
    [UICommon Common_line:CGRectMake((__MainScreen_Width+tsize.width)/2+10, lbl_selanimal.frame.origin.y+15, fwidth, 1) targetView:self backColor:[UIColor whiteColor]];
    
    int xpoint = 0;
    int ypoint = 0;
    for (int i=0; i<arrCategorys.count && i<4; i++) {
        
        NSString * btnColorAndImg = [dicColor objectForKey:arrCategorys[i]];
        NSArray * arrs = [btnColorAndImg componentsSeparatedByString:@"|"];

        xpoint = i==0||i==2 ? (__MainScreen_Width/2-btnWidth-6) : __MainScreen_Width/2+6;
        ypoint = lbl_selanimal.frame.origin.y + 60 + (i==0||i==1 ? 0 : btnHeight+12);
        UIButton * btnCategory = [[UIButton alloc] initWithFrame:CGRectMake(xpoint, ypoint, btnWidth, btnHeight)];
        [btnCategory setTag:btnTag+i];
        [btnCategory setTitle:arrCategorys[i] forState:UIControlStateNormal];
        [btnCategory setBackgroundColor:[UIColor convertHexToRGB:arrs[0]]];
        [btnCategory.titleLabel setFont:defFont(YES, 16)];
        [btnCategory setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnCategory setTitleEdgeInsets:UIEdgeInsetsMake(35, 0, 0, 0)];
        btnCategory.layer.cornerRadius = 3.0f;
        btnCategory.layer.borderColor = [UIColor whiteColor].CGColor;
        [btnCategory addTarget:self action:@selector(onBtnCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnCategory];
        
        UIImageView * iconcat = [[UIImageView alloc] initWithFrame:CGRectMake((btnWidth-40)/2, 10, 40, 40)];
        [iconcat setTag:2002];
        [iconcat setBackgroundColor:[UIColor clearColor]];
        [iconcat setImage:[UIImage imageNamed:arrs[1]]];
        [btnCategory addSubview:iconcat];
        
//        UIView * viewAlpath = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnCategory.frame.size.width, btnCategory.frame.size.height)];
//        [viewAlpath setTag:6568];
//        [viewAlpath setBackgroundColor:[UIColor blackColor]];
//        [viewAlpath setAlpha:0.0f];
//        [viewAlpath setHidden:YES];
//        [btnCategory addSubview:viewAlpath];
//        [btnCategory bringSubviewToFront:viewAlpath];
    }
    
    btnok = [[UIButton alloc] initWithFrame:CGRectMake((__MainScreen_Width-160)/2, ypoint+btnHeight+28, 160, 40)];
    [btnok setHidden:YES];
    [btnok setTitle:@"开始体验" forState:UIControlStateNormal];
    [btnok setBackgroundColor:[UIColor clearColor]];
    [btnok.titleLabel setFont:defFont16];
    [btnok setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnok.layer.cornerRadius = 3.0f;
    btnok.layer.borderColor = [UIColor whiteColor].CGColor;
    btnok.layer.borderWidth = 1.0f;
    [btnok addTarget:selectedButton action:@selector(onOkClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnok];
}


- (void)onBtnCategoryClick:(id) sender{
    UIButton * btntmp = (UIButton*) sender;
    [btnok setHidden:NO];
    
    for (int i=0;i<4;i++) {
        UIButton * btn= (UIButton*)[self viewWithTag:btnTag+i];
        btn.alpha = 0.9f;
    }

    if (selectedButton.tag!=btntmp.tag) {
        selectedButton.layer.borderWidth = 0.0f;
    }
    
    btntmp.alpha = 1.0f;
    btntmp.layer.borderWidth = 1.0f;
    selectedButton = btntmp;
    if ([selectedButton.titleLabel.text isEqualToString:@"狗狗"])
    {
        [MobClick endEvent:@"wlcmPage_dog"];
    }
    else if ([selectedButton.titleLabel.text isEqualToString:@"猫猫"])
    {
        [MobClick endEvent:@"wlcmPage_cat"];
    }
    else if ([selectedButton.titleLabel.text isEqualToString:@"小宠"])
    {
        [MobClick endEvent:@"wlcmPage_smallPet"];
    }
    else if ([selectedButton.titleLabel.text isEqualToString:@"水族"])
    {
        [MobClick endEvent:@"wlcmpage_aquaticAnimals"];
    }
}

- (void)onOkClick:(id) sender{
    
    UIButton * btn_1 = (UIButton*)[self viewWithTag:btnTag];
    UIButton * btn_2 = (UIButton*)[self viewWithTag:btnTag+1];
    UIButton * btn_3 = (UIButton*)[self viewWithTag:btnTag+2];
    UIButton * btn_4 = (UIButton*)[self viewWithTag:btnTag+3];
    
    UIImageView * icon_1= (UIImageView*)[btn_1 viewWithTag:2002];
    UIImageView * icon_2= (UIImageView*)[btn_2 viewWithTag:2002];
    UIImageView * icon_3= (UIImageView*)[btn_3 viewWithTag:2002];
    UIImageView * icon_4= (UIImageView*)[btn_4 viewWithTag:2002];
    
    ypointSuperView = ypointSuperView==0 ? 190:ypointSuperView;
    float fbtnwidth = __MainScreen_Width/4;
    float fbtnheight = 39;
    
    [icon_1 setFrame:CGRectMake((fbtnwidth-40)/2, 0, 39, 39)];
    [icon_2 setFrame:CGRectMake((fbtnwidth-40)/2, 0, 39, 39)];
    [icon_3 setFrame:CGRectMake((fbtnwidth-40)/2, 0, 39, 39)];
    [icon_4 setFrame:CGRectMake((fbtnwidth-40)/2, 0, 39, 39)];
    
    [btn_1 setTitle:@"" forState:UIControlStateNormal];
    [btn_2 setTitle:@"" forState:UIControlStateNormal];
    [btn_3 setTitle:@"" forState:UIControlStateNormal];
    [btn_4 setTitle:@"" forState:UIControlStateNormal];
    
    CGRect cgframe1 = CGRectMake(0, ypointSuperView, fbtnwidth, fbtnheight);
    POPSpringAnimation *frameAnimation1 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    frameAnimation1.toValue = [NSValue valueWithCGRect:cgframe1];
    frameAnimation1.springBounciness = 3.f;
    frameAnimation1.springSpeed = 3.5f;
    [btn_1 pop_addAnimation:frameAnimation1 forKey:@"changeframe"];
    
    CGRect cgframe2 = CGRectMake(fbtnwidth, ypointSuperView, fbtnwidth, fbtnheight);
    POPSpringAnimation *frameAnimation2 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    frameAnimation2.toValue = [NSValue valueWithCGRect:cgframe2];
    frameAnimation2.springBounciness = 3.f;
    frameAnimation2.springSpeed = 3.5f;
    [btn_2 pop_addAnimation:frameAnimation2 forKey:@"changeframe"];
    
    CGRect cgframe3 = CGRectMake(fbtnwidth*2, ypointSuperView, fbtnwidth, fbtnheight);
    POPSpringAnimation *frameAnimation3 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    frameAnimation3.toValue = [NSValue valueWithCGRect:cgframe3];
    frameAnimation3.springBounciness = 3.f;
    frameAnimation3.springSpeed = 3.5f;
    [btn_3 pop_addAnimation:frameAnimation3 forKey:@"changeframe"];
    
    CGRect cgframe4 = CGRectMake(fbtnwidth*3, ypointSuperView, fbtnwidth, fbtnheight);
    POPSpringAnimation *frameAnimation4 = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    frameAnimation4.toValue = [NSValue valueWithCGRect:cgframe4];
    frameAnimation4.springBounciness = 3.f;
    frameAnimation4.springSpeed = 3.5f;
    [btn_4 pop_addAnimation:frameAnimation4 forKey:@"changeframe"];
    
//    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
//    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    alphaAnimation.toValue  = @(0.3);
//    [self pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
    
    if ([firstSelCategoryDelegate respondsToSelector:@selector(setCheckedAnimalClass:)]) {
        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self setAlpha:0.3];
                         }
                         completion:^(BOOL finished){
                             [self removeFromSuperview];
                             [firstSelCategoryDelegate setCheckedAnimalClass: selectedButton.tag-btnTag];
                         }];
    }
}

@end



