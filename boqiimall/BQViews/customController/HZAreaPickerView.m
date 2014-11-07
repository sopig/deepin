//
//  HZAreaPickerView.m
//  boqiimall
//
//  Created by YSW on 14-6-26.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.

#import "HZAreaPickerView.h"
#import <QuartzCore/QuartzCore.h>

#define kDuration 0.3
//设备屏幕大小
#define __Main_Frame   [[UIScreen mainScreen] bounds]
//设备屏幕宽
#define __Main_Width  __Main_Frame.size.width
//设备屏幕高 20,表示状态栏高度.如3.5inch 的高,得到的__MainScreenFrame.size.height是480,而去掉电量那条状态栏,我们真正用到的是460;
#define __Main_Height  (IOS7_OR_LATER?__Main_Frame.size.height:__Main_Frame.size.height - 20)

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize locate_province;
@synthesize locate_city;
@synthesize locate_area;
@synthesize arr_provinces;
@synthesize arr_cities;
@synthesize arr_areas;

- (void)dealloc {

    [locatePicker1 release];
    [locate_province release];
    [locate_city release];
    [locate_area release];
    
    self.arr_provinces = nil;
    self.arr_cities = nil;
    self.arr_areas = nil;
    
    [super dealloc];
}


- (id)initWithStyle:(id)_data delegate:(id<HZAreaPickerDelegate>) p_delegate frame:(CGRect)frame {

    self = [super init];
    if (self) {
        self.frame = frame;
        self.delegate = p_delegate;
        
        [self addToolBar];
        locatePicker1 = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 42, self.frame.size.width, 216)];
        locatePicker1.showsSelectionIndicator = YES;
        locatePicker1.dataSource = self;
        locatePicker1.delegate = self;
        locatePicker1.backgroundColor = [UIColor whiteColor];
        [self addSubview:locatePicker1];
        
        resMod_ProvinceCityArea * p_addressinfo = (resMod_ProvinceCityArea *)_data;
        provinceid = p_addressinfo.pca_provinceId ? p_addressinfo.pca_provinceId: @"11";
        cityid = p_addressinfo.pca_cityId ? p_addressinfo.pca_cityId : @"1101";
        areaid = p_addressinfo.pca_areaId ? p_addressinfo.pca_areaId : @"-1000";

        [self initData];
    }
        
    return self;    
}

- (void) initData{
    
    self.arr_provinces = [NSMutableArray array];
    self.arr_cities = [NSMutableArray array];
    self.arr_areas  = [NSMutableArray array];
    
    resMod_ProvinceInfo *tmpProinfo = [[resMod_ProvinceInfo alloc]init];
    resMod_CityInfo *tmpCityInfo = [[resMod_CityInfo alloc]init];
    resMod_AreaInfo * tmpAreaInfo = [[resMod_AreaInfo alloc] init];
    
    self.locate_province = tmpProinfo;
    self.locate_city = tmpCityInfo;
    self.locate_area = tmpAreaInfo;
    
    [tmpProinfo release];
    [tmpCityInfo release];
    [tmpAreaInfo release];

    
    [self setDataForProvinceCityArea:-100 pcaid:-100];
    
    for (int i=0; i<3; i++) {
        int sel_row = [self Position_PCA: i==0 ? self.arr_provinces:(i==1?self.arr_cities:self.arr_areas) Type:i];
        [locatePicker1 reloadComponent:i];
        [locatePicker1 selectRow:sel_row inComponent:i animated:NO];
    }
}

/*************************************************************************
 *
 *  pca_type:   -100:为第一次加载   0:加载省份    1:加载城市   2:加载区域
 *  rowidx  :   滑动行
 *
*************************************************************************/
- (void) setDataForProvinceCityArea:(int) pca_type pcaid:(int) _id{

    if (pca_type==-100 || pca_type==1) { [self.arr_cities removeAllObjects]; }
    [self.arr_areas removeAllObjects];
    
    BOOL isResetAreaData = NO;
    for (resMod_ProvinceInfo * keypro in [[PMGlobal shared] GetDataFromPlist_ProvinceCityArea]) {
        
        if (pca_type==-100) {
            resMod_ProvinceInfo * province = [[resMod_ProvinceInfo alloc] init];
            province.ProvinceId = keypro.ProvinceId;
            province.ProvinceName = keypro.ProvinceName;
            [self.arr_provinces addObject:province];
            [province release];
        }
        
        for (resMod_CityInfo * keycity in keypro.CityList) {
            
            if ( (pca_type == -100 && keypro.ProvinceId==[provinceid intValue])
                || (pca_type==1 && keypro.ProvinceId==_id) ) {
                
                resMod_CityInfo * city = [[resMod_CityInfo alloc] init];
                city.CityId = keycity.CityId;
                city.CityName = keycity.CityName;
                [self.arr_cities addObject:city];
                
                [city release];
            }
            
            int iarea=0;
            for (resMod_AreaInfo * keyArea in keycity.AreaList) {
                
                if ( (pca_type == -100 && keycity.CityId == [cityid intValue])
                    || (pca_type==1 && keypro.ProvinceId==_id && !isResetAreaData)
                    || (pca_type==2 && keycity.CityId==_id) ) {
                    
                    resMod_AreaInfo * area = [[resMod_AreaInfo alloc] init];
                    area.AreaId = keyArea.AreaId;
                    area.AreaName = keyArea.AreaName;
                    [self.arr_areas addObject: area];
                    [area release];
                    
                    isResetAreaData = (iarea+1==keycity.AreaList.count ? YES:NO);
                }
                iarea++;
            }
        }
    }
}

- (void) addToolBar{
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 2, __Main_Width, 40)];
    NSMutableArray *buttons = [[NSMutableArray alloc]init];
    
    
    UIBarButtonItem *cancelbutton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone
                                                                    target:self action:@selector(onCancleClick:)];
    [buttons addObject:cancelbutton];
    [cancelbutton setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor] forState:UIControlStateNormal];
    [cancelbutton release];
    UIBarButtonItem * fixWidth = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixWidth.width = 220.0;
    [buttons addObject:fixWidth];
    [fixWidth release];
    
    UIBarButtonItem *confirmbutton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(onConfirmClick:)];
    
    [buttons addObject:confirmbutton];
    [confirmbutton setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor] forState:UIControlStateNormal];
    [confirmbutton release];
    
    toolbar.barStyle = UIBarStyleBlackOpaque;
    [toolbar setItems:buttons];
    [buttons release];

    [self addSubview:toolbar];
    [toolbar release];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:     return [self.arr_provinces count];   break;
        case 1:     return [self.arr_cities count];      break;
        case 2:     return [self.arr_areas count];       break;            
        default:    return 0;   break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    resMod_ProvinceInfo    * tmpProvince;
    resMod_CityInfo        * tmpCity;
    resMod_AreaInfo        * tmpArea;
    
    switch (component) {
        case 0:
            if (!arr_provinces && arr_cities.count>0) {
                return @"";
            }
            else {
                tmpProvince = [self.arr_provinces objectAtIndex:row];
                return [NSString stringWithFormat:@"%@",tmpProvince.ProvinceName];
            }
            break;
        case 1:
            if (!arr_cities && arr_cities.count>0) {
                return @"";
            }
            else{
                tmpCity = [self.arr_cities objectAtIndex:row];
                return [NSString stringWithFormat:@"%@",tmpCity.CityName];
            }
            break;
        case 2:
            if (!arr_areas && arr_areas.count>0) {
                return @"";
            }
            else{
                tmpArea = [self.arr_areas objectAtIndex:row];
                return tmpArea.AreaName;
            }
            break;
        default: return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            if( (resMod_ProvinceInfo *)[self.arr_provinces objectAtIndex:row] != self.locate_province ) {
                
                self.locate_province =[self.arr_provinces objectAtIndex:row];
                provinceid = [NSString stringWithFormat:@"%d",self.locate_province.ProvinceId];

                [self setDataForProvinceCityArea:1 pcaid: self.locate_province.ProvinceId];
                [locatePicker1 reloadComponent:1];
                [locatePicker1 selectRow:0 inComponent:1 animated:NO];
                self.locate_city = [self.arr_cities objectAtIndex:0];

                
                [locatePicker1 reloadComponent:2];
                [locatePicker1 selectRow:0 inComponent:2 animated:NO];
                self.locate_area = [self.arr_areas objectAtIndex:0];
            }
                break;
        case 1:
            if((resMod_CityInfo *)[self.arr_cities objectAtIndex:row] != self.locate_city){
                
                self.locate_city = [self.arr_cities objectAtIndex:row];
                cityid = [NSString stringWithFormat:@"%d",self.locate_city.CityId];
                
                [self setDataForProvinceCityArea:2 pcaid: self.locate_city.CityId];
                
                [locatePicker1 reloadComponent:2];
                [locatePicker1 selectRow:0 inComponent:2 animated:NO];
                self.locate_area = [self.arr_areas objectAtIndex:0];
            }
                break;
        case 2:
            if((resMod_AreaInfo *)[self.arr_areas objectAtIndex:row] != self.locate_area){
                
                self.locate_area = (resMod_AreaInfo *)[self.arr_areas objectAtIndex:row];
            }
                break;
            
        default:
            break;
    }

}

#pragma mark -- 第一次进来定位 ：省  、 市  、 区
-(int) Position_PCA:(NSMutableArray *)_arr Type:(int)_type {

    int sel_row = 0;
    for(int i=0; i<_arr.count; i++) {
        if(_type == 0){
            resMod_ProvinceInfo * pi = [[_arr objectAtIndex:i] retain];
            if (pi.ProvinceId==[provinceid intValue]) {
                sel_row = i;
                self.locate_province = (resMod_ProvinceInfo *)[self.arr_provinces objectAtIndex:sel_row];
                [pi release];
                break;
            }
            [pi release];
        }
        else if (_type == 1) {
            resMod_CityInfo * ci = [[_arr objectAtIndex:i] retain];
            if (ci.CityId ==[cityid intValue]) {
                sel_row = i;
                self.locate_city = (resMod_CityInfo *)[self.arr_cities objectAtIndex:sel_row];
                [ci release];
                break;
            }
            [ci release];
        }
        else{
            resMod_AreaInfo * ai = [[_arr objectAtIndex:i] retain];
            if (ai.AreaId == [areaid intValue]) {
                sel_row = i;
                self.locate_area = (resMod_AreaInfo *)[self.arr_areas objectAtIndex:sel_row];
                [ai release];
                break;
            }
            [ai release];
        }
    }
    return sel_row;
}

- (IBAction) onCancleClick:(id) sender{
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:NO];
    }
}

- (IBAction) onConfirmClick:(id) sender{
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:YES];
    }
}

#pragma mark - animation

- (void)showInView:(UIView *) supview {
    
    self.hidden = NO;
    self.frame = CGRectMake(0, __Main_Height - 258, __Main_Width, 258);
}

- (void)cancelPicker  {    
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.frame = CGRectMake(0, __Main_Height, __Main_Width, 0);
                     }
                     completion:^(BOOL finished){
                         self.hidden = YES;
                     }];
}

@end
