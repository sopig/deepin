//
//  ViewController.m
//  DDTimeLineDemo
//
//  Created by tolly on 15/1/6.
//  Copyright (c) 2015年 tolly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDHeadInfoView.h"
@interface ViewController : UIViewController
@property (strong, nonatomic) DDHeadInfoView *headView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
