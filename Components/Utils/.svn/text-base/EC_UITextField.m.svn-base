//
//  EC_UITextField.m
//  BoqiiLife
//
//  Created by YSW on 14-5-10.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "EC_UITextField.h"
#import "BQ_global.h"

#pragma mark -

@interface EC_UITextField (Private)

- (void)initSelf;
@end

@implementation EC_UITextField
@synthesize nextChain = _nextChain;
@synthesize maxLength = _maxLength;
@synthesize textFieldState = _textFieldState;
@synthesize paddingBottom;
@synthesize paddingRight;
@synthesize paddingTop;
@synthesize paddingLeft;

//+ (EC_UITextField *)spawn{
//    return [[[EC_UITextField alloc]initWithFrame:CGRectZero]autorelease];
//}

- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [self initSelf];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSelf];
    }
    return self;
}

- (void)initSelf
{
    _maxLength  =   0;
    
    self.opaque =   NO;
    self.ContentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.font = [UIFont systemFontOfSize:16];
    
    _textFieldState = ECTextFieldNone;
    
    [self setPaddingLeft:6 right:6 top:0 bottom:0];
}

- (void)setTextFieldState:(ECTextFieldBackgroundState)textFieldState
{
    if (textFieldState == ECTextFieldBorder) {
        self.borderStyle = UITextBorderStyleNone;
        [self setBackground:[[UIImage imageNamed:@"bg_input.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:10]];
    }
    else if (textFieldState == ECTextFieldGary) {
        self.borderStyle = UITextBorderStyleNone;
        [self setBackground:[[UIImage imageNamed:@"bg_search_gray.png"] stretchableImageWithLeftCapWidth:6 topCapHeight:8]];
    }
    else{
        self.borderStyle = UITextBorderStyleNone;
        [self setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)setPaddingLeft:(float)left right:(float)right top:(float)top bottom:(float)bottom
{
    paddingLeft = left;
    paddingRight = right;
    paddingTop = top;
    paddingBottom = bottom;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + paddingLeft,
                      bounds.origin.y + paddingTop,
                      bounds.size.width - paddingRight - paddingLeft,
                      bounds.size.height - paddingBottom);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}


- (BOOL)active
{
    return [self isFirstResponder];
}

- (void)setActive:(BOOL)flag
{
    if (flag) {
        [self becomeFirstResponder];
    }
    else
    {
        [self resignFirstResponder];
    }
}


#if ! __has_feature(objc_arc)
- (void)dealloc
{
    [super dealloc];
}
#endif

@end
