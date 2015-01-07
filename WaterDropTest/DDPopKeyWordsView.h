//
//  DDPopKeyWordsView.h
//  DDTimeLineDemo
//
//  Created by tolly on 15/1/6.
//  Copyright (c) 2015年 tolly. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DDSearchShowViewDelegate <NSObject>

@optional

- (void)searchHotTaglibWithKeyWord:(NSString *)keyWords;

@end


@interface DDPopKeyWordsView : UIView
@property (nonatomic, retain) UIButton *changeBtn;
@property (nonatomic, retain) NSMutableArray *keyWordArray;
@property (nonatomic, weak) id<DDSearchShowViewDelegate>delegate;
@property (nonatomic, assign) BOOL isFirst;
- (void)changeSearchKeyWord;
//- (void)changeAnother:(UIButton *)sender;
@end
