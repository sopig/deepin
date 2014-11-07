//
//  EC_UISwitch.m
//  BoqiiLife
//
//  Created by YSW on 14-5-10.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "EC_UISwitch.h"

@implementation EC_UISwitch
@synthesize on=_on;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.on = NO;
    }
    return self;
}

-(void)setOn:(BOOL)on
{
    _on = on;
    if(on)
    {
        [self setBackgroundImage:[UIImage imageNamed:@"switch_on_green.png"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"switch_on_green.png"] forState:UIControlStateHighlighted];
    }
    else
    {
        [self setBackgroundImage:[UIImage imageNamed:@"switch_off_green.png"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"switch_off_green.png"] forState:UIControlStateHighlighted];
    }
    [self sizeToFit];
}

-(BOOL)on
{
    return _on;
}

@end
