//
//  CommonUtility.h
//  SearchV3Demo
//
//  Created by songjian on 13-8-22.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <MapKit/MapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

@interface CommonUtility : NSObject

+ (MAMapRect)maMapRectByMKMapRect:(MKMapRect)mapRect;

+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token;

+ (MAPolyline *)polylineForCoordinateString:(NSString *)coordinateString;

+ (MAPolyline *)polylineForStep:(AMapStep *)step;

+ (MAPolyline *)polylineForBusLine:(AMapBusLine *)busLine;

+ (NSArray *)polylinesForWalking:(AMapWalking *)walking;

+ (NSArray *)polylinesForSegment:(AMapSegment *)segment;

+ (NSArray *)polylinesForPath:(AMapPath *)path;

+ (NSArray *)polylinesForTransit:(AMapTransit *)transit;


+ (MAMapRect)unionMapRect1:(MAMapRect)mapRect1 mapRect2:(MAMapRect)mapRect2;

+ (MAMapRect)mapRectUnion:(MAMapRect *)mapRects count:(NSUInteger)count;

+ (MAMapRect)mapRectForOverlays:(NSArray *)overlays;


+ (MAMapRect)minMapRectForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count;

+ (MAMapRect)minMapRectForAnnotations:(NSArray *)annotations;

@end
