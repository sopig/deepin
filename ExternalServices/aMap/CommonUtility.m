//
//  CommonUtility.m
//  SearchV3Demo
//
//  Created by songjian on 13-8-22.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CommonUtility.h"
#import "LineDashPolyline.h"

@implementation CommonUtility

+ (MAMapRect)maMapRectByMKMapRect:(MKMapRect)mapRect
{
    MAMapRect maMapRect;
    maMapRect.origin.x = mapRect.origin.x;
    maMapRect.origin.y = mapRect.origin.y;
    maMapRect.size.width = mapRect.size.width;
    maMapRect.size.height = mapRect.size.height;

    return maMapRect;
}

+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil) {
        return NULL;
    }
    if (token == nil) {
        token = @",";
    }
    NSString *str = @"";
    if (![token isEqualToString:@","]) {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    else {
        str = [NSString stringWithString:string];
    }
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL) {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++) {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}

+ (MAPolyline *)polylineForCoordinateString:(NSString *)coordinateString
{
    if (coordinateString.length == 0)
    {
        return nil;
    }
    
    NSUInteger count = 0;
    
    CLLocationCoordinate2D *coordinates = [self coordinatesForString:coordinateString
                                                     coordinateCount:&count
                                                          parseToken:@";"];
    
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
    
    free(coordinates), coordinates = NULL;
    
    return polyline;
}

+ (MAPolyline *)polylineForStep:(AMapStep *)step
{
    if (step == nil)
    {
        return nil;
    }
    
    return [self polylineForCoordinateString:step.polyline];
}

+ (MAPolyline *)polylineForBusLine:(AMapBusLine *)busLine
{
    if (busLine == nil)
    {
        return nil;
    }
    
    return [self polylineForCoordinateString:busLine.polyline];
}

+(void)replenishPolylinesForWalkingWiht:(MAPolyline *)stepPolyline
                           LastPolyline:(MAPolyline *)lastPolyline
                              Polylines:(NSMutableArray *)polylines
                                Walking:(AMapWalking *)walking
{
    CLLocationCoordinate2D startCoor ;
    CLLocationCoordinate2D endCoor;
    
    CLLocationCoordinate2D points[2];
    
    [stepPolyline getCoordinates:&endCoor   range:NSMakeRange(0, 1)];
    [lastPolyline getCoordinates:&startCoor range:NSMakeRange(lastPolyline.pointCount -1, 1)];
    
    if (endCoor.latitude != startCoor.latitude || endCoor.longitude != startCoor.longitude)
    {
        points[0] = startCoor;
        points[1] = endCoor;
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:points count:2];
        LineDashPolyline *dathPolyline = [[LineDashPolyline alloc]initWithPolyline:polyline];
        dathPolyline.polyline = polyline;
        [polylines addObject:dathPolyline];
        
    }
    
}

+ (NSArray *)polylinesForWalking:(AMapWalking *)walking
{
    if (walking == nil || walking.steps.count == 0)
    {
        return nil;
    }
    
    NSMutableArray *polylines = [NSMutableArray array];
    
    [walking.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        
        MAPolyline *stepPolyline = [self polylineForStep:step];
        
        
        if (stepPolyline != nil)
        {
            [polylines addObject:stepPolyline];
            if (idx > 0)
            {
                [self replenishPolylinesForWalkingWiht:stepPolyline LastPolyline:[self polylineForStep:[walking.steps objectAtIndex:idx - 1]] Polylines:polylines Walking:walking];
            }
        }
        
    }];
    
    return polylines;
}

+ (void)replenishPolylinesForSegment:(NSArray *)walkingPolylines
                     busLinePolyline:(MAPolyline *)busLinePolyline
                             Segment:(AMapSegment *)segment
                           polylines:(NSMutableArray *)polylines
{
    if (walkingPolylines.count != 0)
    {
        AMapGeoPoint *walkingEndPoint = segment.walking.destination ;
        
        if (busLinePolyline)
        {
            CLLocationCoordinate2D startCoor;
            CLLocationCoordinate2D endCoor ;
            [busLinePolyline getCoordinates:&startCoor range:NSMakeRange(0, 1)];
            [busLinePolyline getCoordinates:&endCoor range:NSMakeRange(busLinePolyline.pointCount-1, 1)];
            
            if (startCoor.latitude != walkingEndPoint.latitude || startCoor.longitude != walkingEndPoint.longitude)
            {
                CLLocationCoordinate2D points[2];
                points[0] = CLLocationCoordinate2DMake(walkingEndPoint.latitude, walkingEndPoint.longitude);
                points[1] = startCoor ;
                
                MAPolyline *polyline = [MAPolyline polylineWithCoordinates:points count:2];
                LineDashPolyline *dathPolyline = [[LineDashPolyline alloc]initWithPolyline:polyline];
                dathPolyline.polyline = polyline;
                [polylines addObject:dathPolyline];
            }
        }
    }
    
}

+ (NSArray *)polylinesForSegment:(AMapSegment *)segment
{
    if (segment == nil)
    {
        return nil;
    }
    
    NSMutableArray *polylines = [NSMutableArray array];
    
    NSArray *walkingPolylines = [self polylinesForWalking:segment.walking];
    if (walkingPolylines.count != 0)
    {
        [polylines addObjectsFromArray:walkingPolylines];
    }
    
    MAPolyline *busLinePolyline = [self polylineForBusLine:segment.busline];
    if (busLinePolyline != nil)
    {
        [polylines addObject:busLinePolyline];
    }
    [self replenishPolylinesForSegment:walkingPolylines busLinePolyline:busLinePolyline Segment:segment polylines:polylines];
    
    return polylines;
}

+ (void)replenishPolylinesForPathWith:(MAPolyline *)stepPolyline
                         lastPolyline:(MAPolyline *)lastPolyline
                            Polylines:(NSMutableArray *)polylines
{
    CLLocationCoordinate2D startCoor ;
    CLLocationCoordinate2D endCoor;
    
    [stepPolyline getCoordinates:&endCoor range:NSMakeRange(0, 1)];
    
    [lastPolyline getCoordinates:&startCoor range:NSMakeRange(lastPolyline.pointCount -1, 1)];
    
    
    if ((endCoor.latitude != startCoor.latitude || endCoor.longitude != startCoor.longitude ))
    {
        CLLocationCoordinate2D points[2];
        points[0] = startCoor;
        points[1] = endCoor;
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:points count:2];
        LineDashPolyline *dathPolyline = [[LineDashPolyline alloc]initWithPolyline:polyline];
        dathPolyline.polyline = polyline;
        [polylines addObject:dathPolyline];
    }
}

+ (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    
    NSMutableArray *polylines = [NSMutableArray array];
    
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        
        MAPolyline *stepPolyline = [self polylineForStep:step];
        
        if (stepPolyline != nil)
        {
            [polylines addObject:stepPolyline];
            
            if (idx > 0 )
            {
                [self replenishPolylinesForPathWith:stepPolyline lastPolyline:[self polylineForStep:[path.steps objectAtIndex:idx-1]]  Polylines:polylines];
            }
        }
    }];
    
    return polylines;
}

+ (void)replenishPolylinesForTransit:(AMapSegment *)lastSegment
                      CurrentSegment:(AMapSegment * )segment
                           Polylines:(NSMutableArray *)polylines
{
    if (lastSegment)
    {
        CLLocationCoordinate2D startCoor;
        CLLocationCoordinate2D endCoor;
        
        MAPolyline *busLinePolyline = [self polylineForBusLine:(lastSegment).busline];
        if (busLinePolyline != nil)
        {
            [busLinePolyline getCoordinates:&startCoor range:NSMakeRange(busLinePolyline.pointCount-1, 1)];
        }
        else
        {
            if ((lastSegment).walking && [(lastSegment).walking.steps count] != 0)
            {
                startCoor.latitude  = (lastSegment).walking.destination.latitude;
                startCoor.longitude = (lastSegment).walking.destination.longitude;
            }
            else
            {
                return;
            }
        }
        
        if ((segment).walking && [(segment).walking.steps count] != 0)
        {
            AMapStep *step = [(segment).walking.steps objectAtIndex:0];
            MAPolyline *stepPolyline = [self polylineForStep:step];
            
            [stepPolyline getCoordinates:&endCoor range:NSMakeRange(0 , 1)];
        }
        else
        {
            
            MAPolyline *busLinePolyline = [self polylineForBusLine:(segment).busline];
            if (busLinePolyline != nil)
            {
                [busLinePolyline getCoordinates:&endCoor range:NSMakeRange(0 , 1)];
            }
            else
            {
                return;
            }
        }
        
        CLLocationCoordinate2D points[2];
        points[0] = startCoor;
        points[1] = endCoor ;
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:points count:2];
        LineDashPolyline *dathPolyline = [[LineDashPolyline alloc]initWithPolyline:polyline];
        dathPolyline.polyline = polyline;
        [polylines addObject:dathPolyline];
    }
}

+ (NSArray *)polylinesForTransit:(AMapTransit *)transit
{
    if (transit == nil || transit.segments.count == 0)
    {
        return nil;
    }
    
    NSMutableArray *polylines = [NSMutableArray array];
    
    [transit.segments enumerateObjectsUsingBlock:^(AMapSegment *segment, NSUInteger idx, BOOL *stop) {
        
        NSArray *segmentPolylines = [self polylinesForSegment:segment];
        
        if (segmentPolylines.count != 0)
        {
            [polylines addObjectsFromArray:segmentPolylines];
        }
        if (idx >0)
        {
            [self replenishPolylinesForTransit:[transit.segments objectAtIndex:idx-1] CurrentSegment:segment Polylines:polylines];
            
        }
    }];
    
    return polylines;
}

+ (MAMapRect)unionMapRect1:(MAMapRect)mapRect1 mapRect2:(MAMapRect)mapRect2
{
    CGRect rect1 = CGRectMake(mapRect1.origin.x, mapRect1.origin.y, mapRect1.size.width, mapRect1.size.height);
    CGRect rect2 = CGRectMake(mapRect2.origin.x, mapRect2.origin.y, mapRect2.size.width, mapRect2.size.height);
    
    CGRect unionRect = CGRectUnion(rect1, rect2);
    
    return MAMapRectMake(unionRect.origin.x, unionRect.origin.y, unionRect.size.width, unionRect.size.height);
}

+ (MAMapRect)mapRectUnion:(MAMapRect *)mapRects count:(NSUInteger)count
{
    if (mapRects == NULL || count == 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:nil userInfo:nil];
    }
    
    MAMapRect unionMapRect = mapRects[0];
    
    for (int i = 1; i < count; i++)
    {
        unionMapRect = [self unionMapRect1:unionMapRect mapRect2:mapRects[i]];
    }
    
    return unionMapRect;
}

+ (MAMapRect)mapRectForOverlays:(NSArray *)overlays
{
    if (overlays.count == 0)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:nil userInfo:nil];
    }
    
    MAMapRect mapRect;
    
    MAMapRect *buffer = (MAMapRect*)malloc(overlays.count * sizeof(MAMapRect));
    
    [overlays enumerateObjectsUsingBlock:^(id<MAOverlay> obj, NSUInteger idx, BOOL *stop) {
        buffer[idx] = [obj boundingMapRect];
    }];
    
    mapRect = [self mapRectUnion:buffer count:overlays.count];
    
    free(buffer), buffer = NULL;
    
    return mapRect;
}

+ (MAMapRect)minMapRectForMapPoints:(MAMapPoint *)mapPoints count:(NSUInteger)count
{
    if (mapPoints == NULL || count <= 1)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:nil userInfo:nil];
    }
    
    CGFloat minX = mapPoints[0].x, minY = mapPoints[0].y;
    CGFloat maxX = minX, maxY = minY;
    
    /* Traverse and find the min, max. */
    for (int i = 1; i < count; i++)
    {
        MAMapPoint point = mapPoints[i];
        
        if (point.x < minX)
        {
            minX = point.x;
        }
        
        if (point.x > maxX)
        {
            maxX = point.x;
        }
        
        if (point.y < minY)
        {
            minY = point.y;
        }
        
        if (point.y > maxY)
        {
            maxY = point.y;
        }
    }
    
    /* Construct outside min rectangle. */
    return MAMapRectMake(minX, minY, fabs(maxX - minX), fabs(maxY - minY));
}

+ (MAMapRect)minMapRectForAnnotations:(NSArray *)annotations
{
    if (annotations.count <= 1)
    {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:nil userInfo:nil];
    }
    
    MAMapPoint *mapPoints = (MAMapPoint*)malloc(annotations.count * sizeof(MAMapPoint));
    
    [annotations enumerateObjectsUsingBlock:^(id<MAAnnotation> obj, NSUInteger idx, BOOL *stop) {
        mapPoints[idx] = MAMapPointForCoordinate([obj coordinate]);
    }];
    
    MAMapRect minMapRect = [self minMapRectForMapPoints:mapPoints count:annotations.count];
    
    free(mapPoints), mapPoints = NULL;
    
    return minMapRect;
}

@end
