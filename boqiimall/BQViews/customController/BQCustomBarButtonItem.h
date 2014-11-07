//
//  BQCustomBarButtonItem.h
//  boqiimall
//
//  Created by 张正超 on 14-7-28.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BQCustomBarButtonItem : UIView

@property(nonatomic,readwrite,strong)UILabel* titleLabel;
@property(nonatomic,readwrite,assign)CGRect titleRect;
@property(nonatomic,readwrite,strong)UIColor *Color;
@property(nonatomic,readwrite,assign)CGFloat radius;


@property(nonatomic,readwrite,strong)id delegate;
@property(nonatomic,readwrite,assign)SEL selector;
@property(nonatomic,readwrite,strong)id paramObject;


@end
