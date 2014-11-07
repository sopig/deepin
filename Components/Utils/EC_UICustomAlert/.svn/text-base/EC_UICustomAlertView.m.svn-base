//
//  HK_UICustomAlertView.m
//  Ule
//
//  Created by yakun cheng on 12-12-28.
//  Copyright (c) 2012年 Ule. All rights reserved.
//

#import "EC_UICustomAlertView.h"
#import <QuartzCore/QuartzCore.h>
#define kSelfWidth      284

//#define kHeadHeight     42
////#define kHeadHeight     (460-44-49-msgHeight - 42 -54)/2
//#define kCenterHeight   61
//#define kFootHeight     66

@interface EC_UICustomAlertView (PrivateMethods)

- (void)initCompent;

@end




@implementation EC_UICustomAlertView
@synthesize delegate1;

@synthesize title=_title;
@synthesize message=_message;
@synthesize okButtonMsg=_okButtonMsg;
@synthesize cancelButtonMsg=_cancelButtonMsg;

@synthesize autoHide=_autoHide;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
//1、第一个参数不为nil，第二个参数也不为nil   =====有两个按钮，需要调用回掉方法处理按钮时间
//1、第一个参数为nil，第二个参数不为nil      =====只有一个按钮，这个需要回掉方法处理按钮时间
//1、第一个参数不为nil，第二个参数为nil      =====只有一个按钮，点击确定直接隐藏，可以不处理按钮事件
//1、第一个参数为nil，第二个参数也为nil      =====没有任何按钮

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonMsg okButtonTitle:(NSString *)okButtonMsg
{
    self = [super initWithFrame:CGRectMake((__MainScreen_Width -kSelfWidth)/2, (__MainScreen_Height-170)/2, kSelfWidth, 170)];
    //    [self setWindowLevel:UIWindowLevelAlert];
    if(self) {
        
        self.title=(title.length > 0 ? title : @"温馨提示");
        self.message=message;
        self.okButtonMsg = okButtonMsg;
        self.cancelButtonMsg = cancelButtonMsg;
        self.autoHide=YES;
        
        [self initCompent];
    }
    return self;
}


- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super initWithFrame:CGRectMake((__MainScreen_Width-kSelfWidth)/2, (__MainScreen_Height-170)/2, kSelfWidth, 170)];
  
    if(self) {
        
        self.title=(title.length > 0 ? title : @"温馨提示");
        self.message=message;
        self.okButtonMsg = @"关闭";
        self.cancelButtonMsg = nil;
        self.autoHide=YES;
        
        [self initCompent];
    }
    return self;
}


- (void)initCompent
{
    _maskView=[[UIView alloc] initWithFrame:CGRectZero];
    _maskView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    //计算message的高度
    CGSize size = [self.message sizeWithFont:[UIFont systemFontOfSize:15]
                           constrainedToSize:CGSizeMake(284, CGFLOAT_MAX)
                               lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat msgHeight = size.height;
    
    CGFloat selfViewHeight = 42+msgHeight+60;//head+center+foot
    CGFloat headY = (460-44-49-selfViewHeight)/2+44;
    if(selfViewHeight > 400){
        selfViewHeight = 400;
        headY = 30;
    }
    
    [self setFrame:CGRectMake((320-kSelfWidth)/2, headY, kSelfWidth, selfViewHeight+40)];
    
    //  --  head
    _headView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kSelfWidth, 42)];//高42
    [_headView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_headView];
#if ! __has_feature(objc_arc)
    [_headView release];
#endif

    UIImageView * headBg = [[UIImageView alloc] init];
    [headBg setFrame:CGRectMake(0, 0, _headView.frame.size.width, _headView.frame.size.height)];
    [headBg setBackgroundColor:[UIColor clearColor]];
    headBg.image=[[UIImage imageNamed:@"ts_top"] stretchableImageWithLeftCapWidth:12 topCapHeight:12];
    [_headView addSubview:headBg];
#if ! __has_feature(objc_arc)
    [headBg release];
#endif
    
    _titleLabel=[[UILabel alloc] initWithFrame:_headView.bounds];
    _titleLabel.backgroundColor=[UIColor clearColor];
    _titleLabel.textColor=[UIColor blackColor];
    _titleLabel.font=[UIFont systemFontOfSize:17];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.text=self.title;
    [_headView addSubview:_titleLabel];
#if ! __has_feature(objc_arc)
    [_titleLabel release];
#endif
    
    [UICommon Common_line:CGRectMake(0, 41, _headView.frame.size.width, 0.5) targetView:_headView backColor:color_d1d1d1];
    
    
    //  --  center
    if (self.message.length>0) {
        
        UIScrollView *scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 42, kSelfWidth, selfViewHeight-60-42+30)];
        [scrollerView setBackgroundColor:[UIColor  clearColor]];
        scrollerView.delegate=self;
        scrollerView.contentSize=CGSizeMake(kSelfWidth, msgHeight+30);
        [scrollerView setDecelerationRate:0.8];
        scrollerView.bounces = YES;
        scrollerView.showsHorizontalScrollIndicator=YES;
        scrollerView.showsVerticalScrollIndicator = NO;
        
        _centerView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 42, kSelfWidth, selfViewHeight-60-42+30)];
        _centerView.image=[[UIImage imageNamed:@"ts_center.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [_centerView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_centerView];
#if ! __has_feature(objc_arc)
        [_centerView release];
#endif
        
        _messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(22, 0, _centerView.frame.size.width-30-10, msgHeight+30)];
        _messageLabel.backgroundColor=[UIColor clearColor];
        _messageLabel.textColor=[UIColor blackColor];
        _messageLabel.font=[UIFont systemFontOfSize:15.5];
        _messageLabel.textAlignment= msgHeight >20 ? NSTextAlignmentLeft:NSTextAlignmentCenter; // 一行时居中显示
        [_messageLabel setTextColor:[UIColor convertHexToRGB:@"333333"]];
        _messageLabel.numberOfLines=0;
        _messageLabel.text=self.message;
        [scrollerView addSubview:_messageLabel];
#if ! __has_feature(objc_arc)
        [_messageLabel release];
#endif
            
        [self addSubview:scrollerView];
#if ! __has_feature(objc_arc)
        [scrollerView release];
#endif
    }
    
    //foot
    float centerHeight = self.message.length>0 ? _centerView.frame.size.height : 0;
    _footView=[[UIImageView alloc] initWithFrame:CGRectMake(0, _headView.frame.size.height+centerHeight-1, kSelfWidth, 50)];
    [_footView setBackgroundColor:[UIColor clearColor]];
    _footView.userInteractionEnabled=YES;
    _footView.image=[[UIImage imageNamed:@"ts_foot.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:0];
    [UICommon Common_line:CGRectMake(0, 0, _footView.frame.size.width, 0.5) targetView:_footView backColor:color_d1d1d1];
    [self addSubview:_footView];
    
//    UIImage *okButtonImage = [[UIImage imageNamed:@"an_r.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:0];
//    UIImage *cancelButtonImage = [[UIImage imageNamed:@"an_cf.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:0];
    
    if(self.cancelButtonMsg == nil && self.okButtonMsg != nil){
        _okButton=[[UIButton alloc] initWithFrame:CGRectMake(16, 3, 250, _footView.frame.size.height-6)];
//        [_okButton setBackgroundImage:okButtonImage forState:UIControlStateNormal];
//        [_okButton setBackgroundImage:cancelButtonImage forState:UIControlStateHighlighted];
        [_okButton setTitle:self.okButtonMsg forState:UIControlStateNormal];
        [_okButton setTitleColor: [UIColor convertHexToRGB:@"0007aff"] forState:UIControlStateNormal];//0007aff
        [_okButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:_okButton];
#if ! __has_feature(objc_arc)
        [_okButton release];
#endif
    }else if(self.okButtonMsg == nil && self.cancelButtonMsg != nil){
        _cancelButton=[[UIButton alloc] initWithFrame:CGRectMake(16, 3, 250, _footView.frame.size.height-6)];
//        [_cancelButton setBackgroundImage:okButtonImage  forState:UIControlStateNormal];
//        [_cancelButton setBackgroundImage:cancelButtonImage forState:UIControlStateHighlighted];
        [_cancelButton setTitle:self.cancelButtonMsg forState:UIControlStateNormal];
        [_cancelButton setTitleColor: [UIColor convertHexToRGB:@"0007aff"] forState:UIControlStateNormal];//0007aff
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:_cancelButton];
#if ! __has_feature(objc_arc)
        [_cancelButton release];
#endif
    }else if(self.okButtonMsg == nil && self.cancelButtonMsg == nil){
        [_footView setHidden:YES];
    }else{
        _cancelButton=[[UIButton alloc] initWithFrame:CGRectMake(16, 3, 119, _footView.frame.size.height-6)];
//        [_cancelButton setBackgroundImage:okButtonImage forState:UIControlStateNormal];
//        [_cancelButton setBackgroundImage:cancelButtonImage forState:UIControlStateHighlighted];
        [_cancelButton setTitle:self.cancelButtonMsg forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor convertHexToRGB:@"0007aff"] forState:UIControlStateNormal];//0007aff
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:_cancelButton];
#if ! __has_feature(objc_arc)
        [_cancelButton release];
#endif

        _okButton=[[UIButton alloc] initWithFrame:CGRectMake(147,3, 119, _footView.frame.size.height-6)];
//        [_okButton setBackgroundImage:okButtonImage forState:UIControlStateNormal];
//        [_okButton setBackgroundImage:cancelButtonImage forState:UIControlStateHighlighted];
        [_okButton setTitle:self.okButtonMsg forState:UIControlStateNormal];
        [_okButton setTitleColor:[UIColor convertHexToRGB:@"0007aff"] forState:UIControlStateNormal];//0007aff
        [_okButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:_okButton];
#if ! __has_feature(objc_arc)
        [_okButton release];
#endif
        

        UILabel * lbl_line = [[UILabel alloc] init];
        [lbl_line setFrame:CGRectMake(_footView.frame.size.width/2, 6, 0.5, _footView.frame.size.height-15)];
        [lbl_line setBackgroundColor:color_d1d1d1];
        [_footView addSubview:lbl_line];
#if ! __has_feature(objc_arc)
        [lbl_line release];
#endif
    }
#if ! __has_feature(objc_arc)
    [_footView release];
#endif
}

- (void)cancelButtonAction:(id)sender {
    if(_cancelButtonMsg == nil && _okButtonMsg != nil){
        [self hide];
        return ;
    }
    if (self.delegate1) {
        if ([self.delegate1 respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
            [self.delegate1 alertView:self clickedButtonAtIndex:0];
        }
    }
    
    if (_autoHide) {
        [self hide];
    }
}

- (void)okButtonAction:(id)sender {
    if(self.cancelButtonMsg == nil && self.okButtonMsg != nil){
        [self hide];
        return ;
    }
    if (self.delegate1) {
        if ([self.delegate1 respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
            [self.delegate1 alertView:self clickedButtonAtIndex:1];
        }
    }
    
    if (_autoHide) {
        [self hide];
    }
}


- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    [self showInView:window];
}


- (void)showInView:(UIView *)containerView
{
    _maskView.frame=containerView.bounds;
    [containerView addSubview:_maskView];
    [containerView addSubview:self];
    
//        containerView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            containerView.alpha = 1;
        }];
        
        self.alpha = 0;
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        } completion:^(BOOL finished) {
            //  -- UIViewAnimationCurveEaseOut
            [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.alpha = 1;
                self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            } completion:^(BOOL finished2) {
                self.layer.shouldRasterize = NO;
            }];
        }];
    
}


- (void)hide {
//    [UIView animateWithDuration:0.3 animations:^{
//        self.viewController.styleView.alpha = 0;
//    }];
    
    self.layer.shouldRasterize = YES;
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 0;
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
        } completion:^(BOOL finished2){
            [_maskView removeFromSuperview];
            [self removeFromSuperview];
        }];
    }];
    
}

#if ! __has_feature(objc_arc)
- (void)dealloc
{
    [_title release];
    [_message release];
    [_okButtonMsg release];
    [_cancelButtonMsg release];
    [super dealloc];
}
#endif

@end
