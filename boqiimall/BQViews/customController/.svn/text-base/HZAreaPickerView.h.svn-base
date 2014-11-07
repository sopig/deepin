//
// HZAreaPickerView.h
//  boqiimall
//
//  Created by YSW on 14-6-26.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.

#import "resMod_ProvinceCityArea.h"

@class HZAreaPickerView;

@protocol HZAreaPickerDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(BOOL) b_type;
@end


@interface HZAreaPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource,InterfaceAPIDelegate> {
    
    NSString * provinceid;
    NSString * cityid;
    NSString * areaid;
    
    
//    MKNetworkOperation *mkOperation;                        //http请求操作handle;
    
    UIPickerView *locatePicker1;
}

@property (assign, nonatomic) id <HZAreaPickerDelegate> delegate;
@property (retain, nonatomic) resMod_ProvinceInfo * locate_province;
@property (retain, nonatomic) resMod_CityInfo * locate_city;
@property (retain, nonatomic) resMod_AreaInfo * locate_area;

@property (retain, nonatomic) NSMutableArray * arr_provinces, * arr_cities, * arr_areas;

- (IBAction) onCancleClick:(id) sender;
- (IBAction) onConfirmClick:(id) sender;


- (id)initWithStyle:(id)_data delegate:(id <HZAreaPickerDelegate>)delegate frame:(CGRect)frame;
- (void)showInView:(UIView *)view;
- (void)cancelPicker;

- (int) Position_PCA:(NSMutableArray *)_arr Type:(int)_type;

@end
