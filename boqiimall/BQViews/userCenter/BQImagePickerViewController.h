//
//  BQImagePickerViewController.h
//  boqiimall
//
//  Created by zhengchaoZhang on 14-9-25.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQIBaseViewController.h"

@interface BQImagePickerViewController : BQIBaseViewController


@property(nonatomic,readwrite,strong)id delegate;
@property(nonatomic,readwrite,assign)SEL selector;
@property(nonatomic,readwrite,strong)id object;  //传递的参数


@end
