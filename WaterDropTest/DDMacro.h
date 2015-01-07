//
//  DDMacro.h
//  DDMacro
//
//  Created by tolly on 14/12/30.
//  Copyright (c) 2014年 tolly. All rights reserved.
//

#ifndef DDMacro_DDMacro_h
#define DDMacro_DDMacro_h


#define metamacro_concat(A, B) \
metamacro_concat_(A, B)

#define metamacro_at(N, ...) \
metamacro_concat(metamacro_at, N)(__VA_ARGS__)

#define metamacro_argcount(...) \
metamacro_at(20, __VA_ARGS__, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)

#define metamacro_at20(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, ...) metamacro_head(__VA_ARGS__)

#define metamacro_head(...) \
metamacro_head_(__VA_ARGS__, 0)


#define metamacro_head_(FIRST, ...) FIRST

#define metamacro_concat_(A, B) A ## B

#define DDLog( s, ... ) NSLog( @"[%@:%d] %@", [[NSString stringWithUTF8String:__FILE__] \
lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#define DDSelectorName  DDLog(@"%@",NSStringFromSelector(_cmd));

#define DDPading 12
#define DDMargin 5

//获取屏幕 宽度、高度
#define SCREEN_WIDTH \
([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT \
([UIScreen mainScreen].bounds.size.height)


#define DDContact(A, B) A ## B

#define DDSring(VALUE) # VALUE


//加边框线黑色用于调试
#define DDAddBoarderLayer(toView) \
        DDAddBoarderLayer_(toView,[UIColor blackColor])

#define DDAddBoarderLayer_(toView,color) \
    toView.layer.borderColor = color.CGColor;\
    toView.layer.borderWidth = 1.0f;\


#define DDParamsAssert(aInstance) \
    if(!aInstance) \
    { aInstance = @""; \
    }

//
#define kDegreeToRadian(x) (M_PI/180.0 * (x))


//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]


#endif
