//
//  HKUIScrollView.h
//  ule_specSale 
//
//  Created by ysw-ule on 13-8-20.
//  Copyright (c) 2013年 ule. All rights reserved.
//  

#import <UIKit/UIKit.h>

@interface EC_UIScrollView : UIScrollView
{
    UIEdgeInsets    _priorInset;
    BOOL            _priorInsetSaved;
    BOOL            _keyboardVisible;
    CGRect          _keyboardRect;
    CGSize          _originalContentSize;
}

- (void)adjustOffsetToIdealIfNeeded;

@end