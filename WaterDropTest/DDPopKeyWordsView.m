//
//  DDPopKeyWordsView.m
//  DDTimeLineDemo
//
//  Created by tolly on 15/1/6.
//  Copyright (c) 2015年 tolly. All rights reserved.
//


#import "DDPopKeyWordsView.h"
#import "pop/POP.h"

#define maxKeyWord 10
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HIGH [UIScreen mainScreen].bounds.size.height
#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@implementation DDPopKeyWordsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isFirst = YES;
        self.keyWordArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
        self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.changeBtn.frame = CGRectMake(SCREEN_WIDTH / 2.0 - 80, self.bounds.size.height - 45 - 30, 80 * 2, 45);
        self.changeBtn.backgroundColor = [UIColor colorWithRed:121.0/255.0 green:192.0/255.0 blue:31.0/255.0 alpha:1.0];
        [self.changeBtn setTitle:@"换标签，测试" forState:UIControlStateNormal];
        //        [self.changeBtn addTarget:self action:@selector(changeSearchKeyWord) forControlEvents:UIControlEventTouchUpInside];
        [self.changeBtn addTarget:self action:@selector(changeSearchKeyWord) forControlEvents:UIControlEventTouchUpInside];
        self.changeBtn.tag = 100;
        [self addSubview:self.changeBtn];
    }
    return self;
}
- (void)changeSearchKeyWord
{
    for (UIButton *button in self.subviews) {
        if (button.tag != 100) {
            [button removeFromSuperview];
        }
    }
    //随机获取10个key
    NSArray *keyWordArrayTemp = [self rondomkeyWordArray];// [NSArray arrayWithObjects:@"123",@"123",@"123",@"123",@"123",@"123",@"123",@"123",@"123",@"123", nil];
    NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [keyWordArrayTemp count]; i++) {
        UIButton *button = [self keyWordButtonWithTitle:[keyWordArrayTemp objectAtIndex:i] tag:i];
        [buttonArray addObject:button];
        [self addSubview:button];
    }
    NSArray *frameArray = [self keyWordButtonAnimationFrameWithButtonArray:buttonArray];
    for (UIButton *button in [self subviews]) {
        if (button.tag != 100) {
            //            [UIView animateWithDuration:2 animations:^{
            NSValue *value = frameArray[button.tag];
            CGRect frameTemp = [value CGRectValue];
            [self showPopWithPopButton:button showPosition:frameTemp];
        }
        
    }
}
//弹出动画
- (void)showPopWithPopButton:(UIButton *)aButton showPosition:(CGRect)aRect
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    positionAnimation.fromValue = [NSValue valueWithCGRect:aButton.frame];
    positionAnimation.toValue = [NSValue valueWithCGRect:aRect];
    positionAnimation.springBounciness = 15.0f;
    positionAnimation.springSpeed = 10.0f;
    [aButton pop_addAnimation:positionAnimation forKey:@"frameAnimation"];
}

- (UIButton *)keyWordButtonWithTitle:(NSString *)aTitle tag:(NSInteger)aTag
{
    CGFloat button_X = SCREEN_WIDTH / 2;
    CGFloat button_Y = 150;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger fontSize = (arc4random() % 11) + 15;
    CGFloat button_W = [self widthForLableWithText:aTitle fontSize:fontSize];
    
    CGFloat red = (arc4random() % 246) + 10;
    CGFloat blue = (arc4random() % 246) + 10;
    CGFloat green = (arc4random() % 246) + 10;
    
    button.frame = CGRectMake(button_X, button_Y, button_W, 30);
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:red/255.0 green:blue/255.0 blue:green/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    button.tag = aTag;
    [button addTarget:self action:@selector(keyWordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return  button;
}
//点击keyWord button 时的事件
- (void)keyWordBtnAction:(UIButton *)aButton
{
    //
    [self.delegate searchHotTaglibWithKeyWord:aButton.titleLabel.text];
}

#pragma mark - 获取动画的位移的frame
//获取10个位移后的frame
- (NSArray *)keyWordButtonAnimationFrameWithButtonArray:(NSArray *)aButtonArray
{
    NSMutableArray *frameArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSArray *rowNoArray = [self keywordRowNoArray];
    NSInteger count = 0;
    
    NSInteger buttonCount = 0;
    for (int i = 0; i < [rowNoArray count]; i ++ ) {
        NSNumber *rowNo = [rowNoArray objectAtIndex:i];

        NSInteger button_y = (IPHONE5?20:0) + i * 50;

        NSMutableArray *weightArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int j = 0 ; j < [rowNo integerValue]; j++) {
            
            if ([aButtonArray count] >= buttonCount) {
                
                UIButton *button = [aButtonArray objectAtIndex:buttonCount];
                [weightArray addObject:[NSNumber numberWithInteger:button.frame.size.width]];
                buttonCount ++ ;
            }
            
        }
        NSArray *xArray = [self rowKeyWordButtonAnimationWithFrameArray:weightArray];
        for (int k = 0; k < [xArray count]; k ++ ) {
            UIButton *button = [aButtonArray objectAtIndex:count];
            count ++;
            NSInteger rondomY = (arc4random() % 20) + 0;//随机Y
            NSNumber *xNumber = [xArray objectAtIndex:k];
            CGRect frameTemp = CGRectMake([xNumber integerValue] , button_y + rondomY , button.frame.size.width, button.frame.size.height );

            [frameArray addObject:[NSValue valueWithCGRect:frameTemp]];
            
        }
    }
    
    return frameArray;
}

//获取一行的三个frame  如 100 100 100
- (NSArray *)rowKeyWordButtonAnimationWithFrameArray:(NSArray *)frameArray
{
    NSMutableArray *xPointArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSInteger count = [frameArray count];
    
    NSInteger totalWeight = 0;//n个frame 加起来的宽度
    for (int i = 0; i < count; i ++ ) {
        NSNumber *weight =[frameArray objectAtIndex:i];
        totalWeight += [weight floatValue];
    }
    NSInteger subWeight = SCREEN_WIDTH - totalWeight;
    if (subWeight < 0) {
        subWeight = -subWeight;
        NSInteger xTemp = (CGFloat)random() / (CGFloat)RAND_MAX * subWeight;//(arc4random() % subWeight) + 0;
        NSInteger x = 0;
        for (int i = 0; i < count; i ++ ) {
            
            if (i != 0) {
                NSNumber *weight =[frameArray objectAtIndex:i - 1];
                x = x + [weight floatValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            else
            {
//                NSNumber *weight =[frameArray objectAtIndex:0];
                x = -xTemp ;//[weight floatValue] -xTemp ;
                [xPointArray addObject:[NSNumber numberWithInteger:-xTemp]];
            }
            
        }
    }
    else
    {

        NSMutableArray * xTempArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < count; i ++) {
            NSInteger xTemp = (CGFloat)random() / (CGFloat)RAND_MAX * (subWeight/(count - i));//(arc4random() % subWeight) + 0;
            subWeight = subWeight - xTemp;
            [xTempArray addObject:[NSNumber numberWithInteger:xTemp]];
        }
        
        for (int k = 0; k < count; k ++ ) {

            if (k != 0) {
                
                NSNumber *x1 = [xPointArray objectAtIndex:k - 1];
                NSNumber *rondomX =[xTempArray objectAtIndex:k];
                
                NSNumber *prevWeight = [frameArray objectAtIndex:k-1];
                
                NSInteger x = [x1 integerValue] + [rondomX integerValue] + [prevWeight floatValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            else
            {
                NSInteger x = [[xTempArray objectAtIndex:0] integerValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            
        }
    }
    return xPointArray;
}

- (NSArray *)keywordRowNoArray
{
    NSInteger keyWordNo = 10;//keyword个数
    NSInteger maxRow = 5;//最大行
    NSInteger minRow = 5;//最小行
    
    NSInteger row = (arc4random() % (maxRow - minRow +1)) + 3;
    
    NSInteger theMaxRowNo = 4;
    
    NSInteger maxRowNo = keyWordNo / minRow + 1;//每行的最大数
    NSInteger minRowNo = [self keyWordCGFloatToNSInteger:(keyWordNo - maxRowNo) / (CGFloat)(row - 1) -1] ;//最小行keyWord个数
    
    NSMutableArray * rowNoArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < row; i ++ ) {
        if (i == row - 1) {
            NSInteger rowNo = keyWordNo;
            [rowNoArray addObject:[NSNumber numberWithInteger:rowNo]];
        }
        else
        {
            NSInteger rowNo = (arc4random() % (maxRowNo - minRowNo +1)) + minRowNo;
            [rowNoArray addObject:[NSNumber numberWithInteger:rowNo]];
            
            keyWordNo -= rowNo;
            NSInteger maxRowNoTemp = keyWordNo - (row - i - 1) + 1;
            maxRowNo = maxRowNoTemp>theMaxRowNo?theMaxRowNo:maxRowNoTemp ;//每行的最大数
            minRowNo =  [self keyWordCGFloatToNSInteger:(keyWordNo - maxRowNo) / (CGFloat)(row - i - 1 - 1)] ;//最小行keyWord个数
        }
        
    }
    return rowNoArray;
}

- (NSInteger )keyWordCGFloatToNSInteger:(CGFloat)aFloat
{
    NSInteger smallInt = aFloat;
    if (aFloat - smallInt > 0) {
        return smallInt + 1;
    }
    return smallInt;
}

// 取N个不同的随机数
- (NSArray *)rondomArrayWithCount:(NSInteger)arrayCount totalCount:(NSInteger)totalCount
{
    NSMutableArray *rondomArray = [[NSMutableArray alloc] initWithCapacity:0];
    do
    {
        int random = arc4random()%totalCount +0;
        
        NSString *randomString = [NSString stringWithFormat:@"%d",random];
        
        if (![rondomArray containsObject:randomString]) {
            [rondomArray addObject:randomString];
        }
        else{
            //            NSLog(@"数组中有已有该随机数，重新取数！");
        }
        
    } while (rondomArray.count != arrayCount);
    return rondomArray;
}

//获取N个热词
- (NSArray *)rondomkeyWordArray
{
    if ([self.keyWordArray count] > maxKeyWord) {
        if (self.isFirst) {
            self.isFirst = NO;
            //第一次取前十个热词
            NSArray *keyWordArray = [self.keyWordArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)]];
            return keyWordArray;
        }
        else
        {
            //第二次开始随机取
            NSArray *rondomNumArray = [self rondomArrayWithCount:maxKeyWord totalCount:[self.keyWordArray count]];
            NSMutableArray *rondomKeyWordArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i < maxKeyWord; i++) {
                NSString *indexStr = [rondomNumArray objectAtIndex:i];
                [rondomKeyWordArray addObject:[self.keyWordArray objectAtIndex:[indexStr integerValue]]];
            }
            return rondomKeyWordArray;
        }
        
    }
    else
    {
        return self.keyWordArray;
    }
    return nil;
}

- (CGFloat) widthForLableWithText:(NSString *)strText fontSize:(NSInteger)fontSize
{
    CGSize constraint = CGSizeMake(CGFLOAT_MAX,20);
    CGSize size = [strText sizeWithFont: [UIFont systemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByClipping];
    float fHeight = size.width +2;
    return fHeight;
}

@end
