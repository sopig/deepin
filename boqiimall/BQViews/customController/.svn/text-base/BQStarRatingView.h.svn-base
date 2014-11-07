//
//  BQStarRatingView.h
//  boqiimall
//
//  Created by 张正超 on 14-7-16.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BQStarRatingView;


@protocol StarRatingViewDelegate <NSObject>

@optional
-(void)starRatingView:(BQStarRatingView *)view score:(float)score;

@end


@interface BQStarRatingView : UIView


- (id)initWithFrame:(CGRect)frame numberOfStar:(int)number withStatue:(NSUInteger)ststueNo;

@property (nonatomic, readonly) int numberOfStar;
@property (nonatomic, weak) id <StarRatingViewDelegate> delegate;
@property (nonatomic,readwrite,assign) float scoreVale;

@end
