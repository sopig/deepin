//
//  UIColor+ColorUtility.h
//  Ule
//
//  Created by eachnet on 11/30/12.
//  Copyright (c) 2012 Ule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorUtility)

+ (UIColor *)convertHexToRGB:(NSString *)hexString;

+ (UIColor *)randomColor;

@end
