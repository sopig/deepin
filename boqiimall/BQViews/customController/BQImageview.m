//
//  BQImageview.m
//  boqiimall
//
//  Created by 张正超 on 14-7-31.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQImageview.h"

@implementation BQImageview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // Initialization code
        
    }
    return self;
}

//- (void)setPickStatus:(UIImageView *)pickStatus  //选中图片状态
//{
//    if (pickStatus == nil) return;
//    if (_pickStatus != pickStatus) {
//#if ! __has_feature(objc_arc)
//        [_pickStatus release];
//        _pickStatus = [pickStatus retain];
//        [pickStatus release];
//#else
//        _pickStatus = pickStatus;
//#endif
//        float width = self.frame.size.width;
//        float height = self.frame.size.height;
//        float x = self.frame.origin.x + width - self.pickFlagSize.width;
//        float y = self.frame.origin.y + height - self.pickFlagSize.height;
//
//        _pickStatus.frame = CGRectMake(x, y, self.pickFlagSize.width, self.pickFlagSize.height);
//        [self addSubview:_pickStatus];
//    }
//    
//}


#if ! __has_feature(objc_arc)

#endif


#if 0 //测试用
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *curTouch = [touches anyObject];
    CGPoint pt = [curTouch locationInView:self];
    
//    NSLog(@"pt.x = %f , pt.y = %f ",pt.x,pt.y);
}
#endif


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
//    UITouch *curTouch = [touches anyObject];
//    CGPoint pt = [curTouch locationInView:self];
    
//    NSLog(@"pt.x = %f , pt.y = %f ",pt.x,pt.y);
    
//    if (Iphone5_OrLater) {
//        if (pt.x >= 91.0f && pt.x <= 231.0f && pt.y >= 506.0f && pt.y <= 536.0f) {
//            if ([self.delegate respondsToSelector:self.selector]) {
//                [self.delegate performSelector:self.selector withObject:self.object];
//            }
//        }
//    }
//    else{
//        if (pt.x >= 91.0f && pt.x <= 231.0f && pt.y >= 425.0f && pt.y <= 460.0f) {
//            if ([self.delegate respondsToSelector:self.selector]) {
//                [self.delegate performSelector:self.selector withObject:self.object];
//            }
//        }
//    }
  
    if (_delegate && [_delegate respondsToSelector:self.selector]) {
        [self.delegate performSelector:self.selector withObject:self.object];
    }
    
}

#pragma clang diagnostic pop
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
