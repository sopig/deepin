//
//  UICommon.m
//  BoqiiLife
//
//  Created by YSW on 14-5-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "UICommon.h"

@implementation UICommon
// -- Label ui
/* 调用方法
 [self CreateLabel:CGRectMake(10, 6, 100/2, 36/2) targetView:_cell bgColor:[UIColor convertHexToRGB:@"13B3FD"]
 tag:666 text:@"待付款" align:NSTextAlignmentCenter fontSize:12 tColor:[UIColor whiteColor]];
 */
+ (void)Common_UILabel_Add:(CGRect) _cgrect targetView:(UIView *) _targetView bgColor:(UIColor *) _bgcolor
                       tag:(int) _tag text:(NSString *) _lbltitle align:(int) _align
                    isBold:(BOOL) _isbold fontSize:(int) _fsize tColor:(UIColor *) _tcolor
{
    UILabel * lbl_common = [[UILabel alloc] initWithFrame:_cgrect];
    
    lbl_common.userInteractionEnabled = YES;
//    lbl_common.layer.borderColor = [UIColor blackColor].CGColor;
//    lbl_common.layer.borderWidth = 1;
    [lbl_common setTag:_tag];
    [lbl_common setLineBreakMode:NSLineBreakByCharWrapping]; // UILineBreakModeWordWrap
    [lbl_common setNumberOfLines:0];
    [lbl_common setText:_lbltitle];
    [lbl_common setTextAlignment: _align==0 ? NSTextAlignmentCenter
                                : (_align==-1 ? NSTextAlignmentLeft : NSTextAlignmentRight)];
    [lbl_common setFont:_isbold ? [UIFont boldSystemFontOfSize:_fsize] :[UIFont systemFontOfSize:_fsize]];
    [lbl_common setTextColor:_tcolor];
    [lbl_common setBackgroundColor:_bgcolor];
    [_targetView addSubview:lbl_common];

#if ! __has_feature(objc_arc)
    [lbl_common release];
#endif
}

//  --  添加简单的 1 像素线
+ (void)Common_line:(CGRect) _cgrect targetView:(UIView *) _targetView backColor:(UIColor *) _bgColor{
    UILabel * lbl_line = [[UILabel alloc] initWithFrame:_cgrect];
    [lbl_line setTag:7093];
    [lbl_line setBackgroundColor:_bgColor];
    [_targetView addSubview:lbl_line];
    
#if ! __has_feature(objc_arc)
    [lbl_line release];
#endif
    
//    lbl_line.layer.borderWidth = 1;
//    lbl_line.layer.borderColor = [UIColor redColor].CGColor ;
}

/*  
 *  画圆角 虚线边框    :   注意：宽度必需跟切图宽一至，不然显示有问题，  为 592/2
 *  图片命名格式  ：  图片前缀_top.png     图片前缀_center.png    图片前缀_bottom.png
*/
+ (UIView *)Common_DottedCornerRadiusView:(CGRect) _cgrect
                               targetView:(UIView *) _targetView
                                      tag:(int) _tag
                               dottedImgName:(NSString *) _dottedName{
    
    
    if (_dottedName.length==0) {
        _dottedName = @"dottedLine";
    }
        
    UIView * viewContent = [[UIView alloc] initWithFrame:_cgrect];
    [viewContent setTag:_tag];
    [viewContent setBackgroundColor:[UIColor clearColor]];
    
    if (_cgrect.size.height>0) {
        UIImageView *topBg = [[UIImageView alloc] init];
        [topBg setFrame:CGRectMake(0,0,_cgrect.size.width,3)];
        [topBg setBackgroundColor:[UIColor clearColor]];
        [topBg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_top.png",_dottedName]]];
        [viewContent addSubview:topBg];
#if ! __has_feature(objc_arc)
        [topBg release];
#endif
        
        UIImageView *centerBg = [[UIImageView alloc] init];
        [centerBg setFrame:CGRectMake(0, topBg.frame.size.height, _cgrect.size.width, _cgrect.size.height-8)];
    //    [centerBg setBackgroundColor:[UIColor clearColor]];
    //    [centerBg setImage:[[UIImage imageNamed:@"dottedLine_center.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0]];
        centerBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_center.png",_dottedName]]];
        [viewContent addSubview:centerBg];
        
#if ! __has_feature(objc_arc)
        [centerBg release];
#endif
        
        UIImageView *bottomBg = [[UIImageView alloc] init];
        [bottomBg setFrame:CGRectMake(0, _cgrect.size.height-5, _cgrect.size.width, 5)];
        [bottomBg setBackgroundColor:[UIColor clearColor]];
        [bottomBg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_bottom.png",_dottedName]]];
        [viewContent addSubview:bottomBg];
        
#if ! __has_feature(objc_arc)
        [bottomBg release];
#endif
    }
    
    [_targetView addSubview:viewContent];
    
#if ! __has_feature(objc_arc)
    [viewContent release];
#endif
    
    return viewContent;
    
//  --  开始画虚线.....................
//    UIImageView *dotview = [[UIImageView alloc] initWithFrame:CGRectZero];
//    [dotview setImage:[UIImage imageNamed:@"dottedLine_top.png"]];
//    [_targetView addSubview:dotview];
//    UIGraphicsBeginImageContext(viewbg.frame.size);
//    [dotview.image drawInRect:CGRectMake(0, 0, viewbg.frame.size.width, viewbg.frame.size.height)];
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
//
//    float lengths[] = {2,1};
//    CGContextRef line = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(line, [UIColor convertHexToRGB:@"dbdbdb"].CGColor);
//
//    CGContextSetLineDash(line, 0, lengths, 2);  //画虚线  : 开始画线
//    CGContextMoveToPoint(line, 0.0, 0.0);
//    CGContextAddLineToPoint(line, viewbg.frame.size.width, 0);
//    CGContextMoveToPoint(line, 0.0, 1);
//    CGContextAddLineToPoint(line, 0.0, viewbg.frame.size.height-2);
//    CGContextMoveToPoint(line, viewbg.frame.size.width, 1);
//    CGContextAddLineToPoint(line, viewbg.frame.size.width, viewbg.frame.size.height-1);
//    CGContextMoveToPoint(line, 0.0, viewbg.frame.size.height);
//    CGContextAddLineToPoint(line, viewbg.frame.size.width, viewbg.frame.size.height);
//
//    CGContextStrokePath(line);
//    dotview.image = UIGraphicsGetImageFromCurrentImageContext();
//  --  结束画虚线.....................
}
@end




