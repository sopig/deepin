//
//  EC_UITextField.h
//  BoqiiLife
//
//  Created by YSW on 14-5-10.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


typedef enum _ECTextFieldBackgroundState {
	ECTextFieldGary = 0,
    ECTextFieldBorder = 1,
	ECTextFieldNone = 2
} ECTextFieldBackgroundState;



@interface EC_UITextField : UITextField
{
    NSUInteger                              _maxLength;
    UIResponder *                           _nextChain;
    
    ECTextFieldBackgroundState              _textFieldState;
}

@property   (nonatomic,assign)  BOOL                    active;
@property   (nonatomic,assign)  NSUInteger              maxLength;
@property   (nonatomic,assign)  NSObject *              nextChain;

@property   (nonatomic,assign)  ECTextFieldBackgroundState textFieldState;

@property   (nonatomic,assign)  float                    paddingLeft;
@property   (nonatomic,assign)  float                    paddingRight;
@property   (nonatomic,assign)  float                    paddingTop;
@property   (nonatomic,assign)  float                    paddingBottom;

//+ (EC_UITextField *)spawn;

@end