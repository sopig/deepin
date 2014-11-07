//
//  UICommon.h
//  BoqiiLife
//
//  Created by YSW on 14-5-6.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UICommon : NSObject

//  -- label
+ (void)Common_UILabel_Add:(CGRect) _cgrect targetView:(UIView *) _targetView bgColor:(UIColor *) _bgcolor
                       tag:(int) _tag text:(NSString *) _lbltitle align:(int) _align
                    isBold:(BOOL) _isbold fontSize:(int) _fsize tColor:(UIColor *) _tcolor;

//  --  1像素线条
+ (void)Common_line:(CGRect) _cgrect targetView:(UIView *) _targetView backColor:(UIColor *) _bgColor;

/*
 *  画圆角 虚线边框 :   注意：宽度必需跟切图宽一至，不然显示有问题，  为 592/2
 *  图片命名格式   :  图片前缀_top.png     图片前缀_center.png    图片前缀_bottom.png
 */
+ (UIView *)Common_DottedCornerRadiusView:(CGRect) _cgrect
                               targetView:(UIView *) _targetView
                                      tag:(int) _tag
                            dottedImgName:(NSString *) _dottedName;
@end
