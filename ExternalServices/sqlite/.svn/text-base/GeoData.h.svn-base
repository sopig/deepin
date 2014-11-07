//
//  GeoData.h
//
//  Created by Fennivel Chai on 14-3-24.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CDatabase.h"

@interface GeoData : NSObject <CLLocationManagerDelegate> {
    
	CDatabase *database;
    
    NSArray *geoData;
    NSMutableArray *cityData;
    
    CLLocation *currentLocation;
    NSDictionary *currentCity;
    NSDictionary *hitCity;
    
    NSMutableArray *nearCities;
    NSMutableArray *hotCities;
    NSMutableArray *sortedAllCities;
    
    CLLocationManager *locManager;
    
    BOOL locatedNewCity;
}

@property (nonatomic, retain) NSArray *geoData;
@property (nonatomic, retain) NSMutableArray *cityData;
@property (nonatomic, retain) NSDictionary *currentCity;
@property (nonatomic, retain) NSDictionary *hitCity;
@property (nonatomic, retain) NSMutableArray *nearCities;
@property (nonatomic, retain) NSMutableArray *hotCities;
@property (nonatomic, retain) NSMutableArray *sortedAllCities;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) CLLocationManager *locManager;
@property (nonatomic, readonly) BOOL locatedNewCity;

+ (GeoData *)singletonDB;
- (id)initDB;

- (NSDictionary *)getGeoDataByCity:(NSString *)cityName;
- (void)refreshCityByCityList:(NSArray *)cityList;
- (void)locateUserCity;

@end
