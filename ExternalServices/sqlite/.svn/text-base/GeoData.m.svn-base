//
//  GeoData.m
//
//  Created by Fennivel Chai on 14-3-24.
//
//

#import "GeoData.h"

#define Uppertude                   999999.99f
#define MinInteralDistance          80000.0f
#define MaxNearDistance             200000.0f

@implementation GeoData
@synthesize geoData;
@synthesize cityData;
@synthesize hitCity;
@synthesize currentCity;
@synthesize nearCities;
@synthesize hotCities;
@synthesize currentLocation;
@synthesize locManager;
@synthesize locatedNewCity;
@synthesize sortedAllCities;

+ (GeoData *)singletonDB {
    static GeoData *_singletonUserDB = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singletonUserDB = [[GeoData alloc] initDB];
    });
    
    return _singletonUserDB;
}

- (id)initDB {
    if ( self = [super init] ) {
        
        [self loadGeoData];
        
        locatedNewCity = NO;
        self.hitCity = nil;
        self.currentCity = nil;
        
        self.cityData = [[NSMutableArray alloc] initWithCapacity:0];
        
        self.nearCities = nil;
        self.hotCities = nil;
        self.currentLocation = nil;
    }
    return self;
}

- (BOOL) openUserDB {
	database = [[CDatabase alloc] init];
    if ( ![database OpenCoreDatabase:@"CitysGeo.sqlite" ]) return NO;
    
	return YES;
}

- (void) closeUserDB {
	[database CloseDataBase];
}

- (void)loadGeoData {
    
    [self openUserDB];

    NSString *query = [NSString stringWithFormat:@"select City,Province,Longitude,Latitude from Geo"];

    NSMutableArray *geoList = [[NSMutableArray alloc] init];
    
    STATEMENT * pStatement = [database PrepareSQL:query];
    
    if ( pStatement != NULL )
    {
        while ([database GetNextColumn:pStatement]) {
            
            NSMutableDictionary *geo = [[NSMutableDictionary alloc] init];
            [geo setObject:[database GetColumnText:pStatement] forKey:@"City"];
            [geo setObject:[database GetColumnText:pStatement] forKey:@"Province"];
            [geo setObject:[NSNumber numberWithDouble:[database GetColumnDouble:pStatement]] forKey:@"Longitude"];
            [geo setObject:[NSNumber numberWithDouble:[database GetColumnDouble:pStatement]] forKey:@"Latitude"];
            
            [geoList addObject:geo];
#if ! __has_feature(objc_arc)
            [geo release];
#endif
            
        }
        [database FinishColumn:pStatement];
    }
    
    self.geoData = geoList;
#if ! __has_feature(objc_arc)
    [geoList release];
#endif
    
    [self closeUserDB];
}

- (void)locateUserCity
{
    CLLocationManager *lcManager = [[CLLocationManager alloc] init];
    self.locManager = lcManager;
#if ! __has_feature(objc_arc)
    [lcManager release];
#endif
    
    locManager.delegate = self;
    locManager.distanceFilter = 1000.0f;
//    if(IOS8_OR_LATER)
//    {
//        [locManager requestAlwaysAuthorization];
//    }
    [locManager startUpdatingLocation];
}

- (NSDictionary *)getGeoDataByCity:(NSString *)cityName
{
    for (NSDictionary *geo in geoData) {
        NSString *name = [geo objectForKey:@"City"];
        if ( [name isEqualToString:cityName] ) {
            return geo;
        }
    }
    return nil;
}

- (void)refreshCityByCityList:(NSArray *)cityList
{
    [cityData removeAllObjects];
    
    for ( int i = 1; i < cityList.count; i++ ) {

        BOOL geoHit = NO;
        
        NSString *city = [cityList objectAtIndex:i];
        NSDictionary *geo = [self getGeoDataByCity:city];
        if ( geo ) {
//            NSNumber *longitude = [geo objectForKey:@"Longitude"];
//            NSNumber *latitude = [geo objectForKey:@"Latitude"];
//            NSLog(@"%@ - %@, %f, %f", city, [geo objectForKey:@"Province"], longitude.doubleValue, latitude.doubleValue);
            
            [cityData addObject:geo];
            geoHit = YES;
        }
        else {
            if ( [[city substringFromIndex:city.length-1] isEqualToString:@"市"] ) {
                NSDictionary *geo2 = [self getGeoDataByCity:[city substringToIndex:city.length-1]];
                if ( geo2 ) {
                    NSNumber *longitude = [geo2 objectForKey:@"Longitude"];
                    NSNumber *latitude = [geo2 objectForKey:@"Latitude"];
//                    NSLog(@"%@ - %@, %f, %f", city, [geo2 objectForKey:@"Province"], longitude.doubleValue, latitude.doubleValue);
                    
                    NSMutableDictionary *geoD = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          city, @"City",
                                          [geo2 objectForKey:@"Province"], @"Province",
                                          longitude, @"Longitude",
                                          latitude,  @"Latitude", nil];
                    [cityData addObject:geoD];
                    geoHit = YES;
                }
                else {
                    NSLog(@"%@ - missing...", [city substringToIndex:city.length-1]);
                }
            }
            else {
                NSLog(@"%@ - missing...", city);
            }
        }

        if ( !geoHit ) {
            NSMutableDictionary *geoD = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         city, @"City",
                                         @"-", @"Province",
                                         [NSNumber numberWithDouble:Uppertude], @"Longitude",
                                         [NSNumber numberWithDouble:Uppertude], @"Latitude",
                                         nil];
            [cityData addObject:geoD];
        }
        
    }
    
    NSLog(@"Total Cities - %d", cityData.count);
/*
    NSString *cCityName = [FXUtils savedTextVariableByKey:kCurrentCity];
    if ( !cCityName ) {
        cCityName = @"上海";
        [FXUtils saveTextVariable:cCityName forKey:kCurrentCity];
    }
    
    if ( cCityName ) {
        for (NSDictionary *cData in cityData) {
            if ( [cCityName isEqualToString:[cData objectForKey:@"City"]] ) {
                self.currentCity = cData;
                break;
            }
        }
    }
    
    NSMutableArray *theHotCities = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < MIN(21, cityData.count); i++) {
        NSDictionary *cData = [cityData objectAtIndex:i];
        [theHotCities addObject:cData];
    }
    
    self.hotCities = theHotCities;
#if ! __has_feature(objc_arc)
    [theHotCities release];
#endif
    
    NSArray *sortedArray = [cityData sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        NSDictionary *city1 = (NSDictionary *)obj1;
        NSDictionary *city2 = (NSDictionary *)obj2;
        
        NSString *pyC1 = [FXUtils convertHanziToPinyin:[city1 objectForKey:@"City"]];
        NSString *pyC2 = [FXUtils convertHanziToPinyin:[city2 objectForKey:@"City"]];
        
        return [pyC1 compare:pyC2];
        
    }];
    
    self.sortedAllCities = [NSMutableArray arrayWithArray:sortedArray];
*/
}

- (void)searchCityByNewLocation:(CLLocation *)newLocation
{
    self.currentLocation = newLocation;
    
    NSDictionary *nearestCity = nil;
    CLLocationDistance nearestDistance = 999999999999999.999f;
    
//    for (NSDictionary *cData in cityData) {
    for (NSDictionary * cData in self.geoData) {
        NSNumber *latN = [cData objectForKey:@"Latitude"];
        NSNumber *lonN = [cData objectForKey:@"Longitude"];
        CLLocation *cityLoc = [[CLLocation alloc] initWithLatitude:latN.doubleValue longitude:lonN.doubleValue];
        CLLocationDistance cityDistance = [newLocation distanceFromLocation:cityLoc];
#if ! __has_feature(objc_arc)
        [cityLoc release];
#endif
        if ( cityDistance < nearestDistance ) {
            nearestDistance = cityDistance;
            nearestCity = cData;
        }
    }
    
    if ( nearestDistance < MinInteralDistance ) {
//            locatedNewCity = YES;
        self.hitCity = nearestCity;

        [[PMGlobal shared] location_SetLocalCity:[hitCity objectForKey:@"Province"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"goLocation" object:nil];
    }
    /*
    NSMutableArray *theNearCities = [[NSMutableArray alloc] init];
    
    for (NSDictionary *cData in cityData) {
        NSNumber *latN = [cData objectForKey:@"Latitude"];
        NSNumber *lonN = [cData objectForKey:@"Longitude"];
        CLLocation *cityLoc = [[CLLocation alloc] initWithLatitude:latN.doubleValue longitude:lonN.doubleValue];
        CLLocationDistance cityDistance = [newLocation distanceFromLocation:cityLoc];
#if ! __has_feature(objc_arc)
        [cityLoc release];
#endif
        if ( cityDistance <= MaxNearDistance ) {
            [theNearCities addObject:cData];
            NSLog(@"near city: %@ - %f", [cData objectForKey:@"City"], cityDistance);
        }
    }
    
    NSArray *sortedArray = [theNearCities sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        NSDictionary *city1 = (NSDictionary *)obj1;
        NSDictionary *city2 = (NSDictionary *)obj2;
        
        NSNumber *latN = [city1 objectForKey:@"Latitude"];
        NSNumber *lonN = [city1 objectForKey:@"Longitude"];
        CLLocation *cityLoc = [[CLLocation alloc] initWithLatitude:latN.doubleValue longitude:lonN.doubleValue];
        CLLocationDistance cityDistance1 = [newLocation distanceFromLocation:cityLoc];
#if ! __has_feature(objc_arc)
        [cityLoc release];
#endif
        
        latN = [city2 objectForKey:@"Latitude"];
        lonN = [city2 objectForKey:@"Longitude"];
        cityLoc = [[CLLocation alloc] initWithLatitude:latN.doubleValue longitude:lonN.doubleValue];
        CLLocationDistance cityDistance2 = [newLocation distanceFromLocation:cityLoc];
#if ! __has_feature(objc_arc)
        [cityLoc release];
#endif
        
        if (cityDistance1 > cityDistance2) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if (cityDistance1 < cityDistance2) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];

    self.nearCities = [NSMutableArray arrayWithArray:sortedArray];
#if ! __has_feature(objc_arc)
    [theNearCities release];
#endif
*/
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    [self searchCityByNewLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self searchCityByNewLocation:newLocation];
}


#if ! __has_feature(objc_arc)
- (void) dealloc {
    self.geoData = nil;
    self.cityData = nil;
    self.hitCity = nil;
    self.nearCities = nil;
    self.hotCities = nil;
    self.currentCity = nil;
    self.locManager = nil;
    self.currentLocation = nil;
    
    [database release];
    [super dealloc];
}
#endif
@end
