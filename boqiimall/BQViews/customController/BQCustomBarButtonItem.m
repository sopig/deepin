//
//  BQCustomBarButtonItem.m
//  boqiimall
//
//  Created by 张正超 on 14-7-28.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQCustomBarButtonItem.h"

@implementation BQCustomBarButtonItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _titleLabel = [[UILabel alloc]initWithFrame:self.titleRect];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [super touchesEnded:touches withEvent:event];
    if (self.delegate && [self.delegate respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.delegate performSelector:self.selector withObject:self.paramObject];
#pragma clang diagnostic pop
    }

}



- (void)setColor:(UIColor *)Color
{
    self.backgroundColor = Color;
    self.titleLabel.backgroundColor = Color;
}

- (void)setRadius:(CGFloat)radius{
     self.layer.cornerRadius = radius;
}

- (void)setTitleRect:(CGRect)titleRect{
    _titleRect = titleRect;
    self.titleLabel.frame = _titleRect;
}

- (void)layoutSubviews{
    self.titleLabel.frame = self.titleRect;
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
