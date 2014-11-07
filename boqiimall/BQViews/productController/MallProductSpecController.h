//
//  MallProductSpecController.h
//  BoqiiLife
//
//  Created by YSW on 14-6-23.
//  Copyright (c) 2014年 boqii. All rights reserved.
//

#import "BQIBaseViewController.h"
#import "EC_UIScrollView.h"
#import "resMod_Mall_Goods.h"
#import "resMod_Mall_GoodsSpec.h"


//  -- button扩展 .........................
@interface EC_ButtonForProSpec : UIButton
@property (assign,nonatomic) BOOL isCheckSpec;
@property (assign,nonatomic) BOOL isNotExistSpec; 
@property (assign,nonatomic) int propertyID;
@property (strong,nonatomic) NSString * propertyName;
@property (assign,nonatomic) int    specID;
@property (strong,nonatomic) NSString * specName;
@end



@interface MallProductSpecController : BQIBaseViewController<UIScrollViewDelegate,UITextFieldDelegate>{
    
    EC_UIScrollView * scrollview_Root;
    
    UIView * TopProductInfo;
    
    UIButton * btn_discount;
    UIButton * btn_sum;
    UITextField * txt_productNum;
    UILabel * lbl_LimitNum;
    UILabel * lbl_StockNum;
    
    
    
    int     operType;   //  0：现在购买  1：加入购物车
    float   fSpecHeight;
    
    resMod_Mall_GoodsInfo   * productInfo;
    resMod_Mall_GoodsSpecGroups * checkSpecGroup;   //最终选中的规格组合
    
    NSMutableArray * m_productSpecs;                //  属性列表
    NSMutableArray * m_productSpecGroup;            //  属性组合
    
    //  -- 存储所有规格按钮
    NSMutableDictionary * dic_allSpecBtns;
    
}

@end
