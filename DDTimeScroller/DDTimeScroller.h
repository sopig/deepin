//
//  DDTimeScroller.h
//  DDTimeLineDemo
//
//  Created by tolly on 15/1/6.
//  Copyright (c) 2015年 tolly. All rights reserved.
//
#import <UIKit/UIKit.h>

@class DDTimeScroller;

@protocol DDTimeScrollerDelegate <NSObject>

@required

- (UITableView *)tableViewForTimeScroller:(DDTimeScroller *)timeScroller;
- (NSDate *)timeScroller:(DDTimeScroller *)timeScroller dateForCell:(UITableViewCell *)cell;

@optional
- (id)timeScroller:(DDTimeScroller *)timeScroller ContentdateForCell:(UITableViewCell *)cell;

@end

@interface DDTimeScroller : UIImageView

@property (nonatomic, weak) id <DDTimeScrollerDelegate> delegate;
@property (nonatomic, copy) NSCalendar *calendar;

- (id)initWithDelegate:(id <DDTimeScrollerDelegate>)delegate;
- (void)scrollViewDidScroll;
- (void)scrollViewDidEndDecelerating;
- (void)scrollViewWillBeginDragging;

@end
