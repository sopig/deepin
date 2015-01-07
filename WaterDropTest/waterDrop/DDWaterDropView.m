//
//  DDWaterDropView.m
//  DDTimeLineDemo
//
//  Created by tolly on 15/1/6.
//  Copyright (c) 2015年 tolly. All rights reserved.
//

#import "DDWaterDropView.h"

#ifndef RGBCOLOR
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#endif

#ifndef RGBCOLORA
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#endif

@interface DDWaterDropView()
{
    BOOL _animationing;
    BOOL _isRefresh;
    float _centerX;
}
@property(strong,nonatomic)CAShapeLayer* doudongLayer;
@property(strong,nonatomic)NSTimer* timer;
@end

@implementation DDWaterDropView
-(BOOL)isRefreshing
{
    return _isRefresh;
}
-(void)parameterInit
{
    if(_waterTop == 0)
        _waterTop = 30;
    if(_maxDropLength == 0)
        _maxDropLength = 60;
    if(_radius == 0)
        _radius = 3.5;
    
    _centerX = self.bounds.size.width/2;
}
-(void)loadWaterView
{
    [self parameterInit];
    
    _lineLayer = [CAShapeLayer layer];
    _lineLayer.fillColor = RGBACOLOR(222, 216, 211, 0.5).CGColor;
    [self.layer addSublayer:_lineLayer];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = RGBCOLOR(222, 216, 211).CGColor;
    _shapeLayer.strokeColor = [[UIColor whiteColor] CGColor];
    _shapeLayer.lineWidth = 3;
    [self.layer addSublayer:_shapeLayer];
    
    _doudongLayer = [CAShapeLayer layer];
    _doudongLayer.fillColor = RGBCOLOR(222, 216, 211).CGColor;
    _doudongLayer.strokeColor = [[UIColor whiteColor] CGColor];
    _doudongLayer.lineWidth = 3;
    _doudongLayer.frame = CGRectMake(_centerX - _radius,self.bounds.size.height - _waterTop, _radius*2, _radius*2);
    _doudongLayer.path = CGPathCreateWithEllipseInRect(_doudongLayer.bounds, NULL);
    _doudongLayer.opacity = 0;
    [self.layer addSublayer:_doudongLayer];
    
    self.currentOffset = 0;
}

-(CGMutablePathRef)createPathWithOffset:(float)currentOffset
{
    CGMutablePathRef path = CGPathCreateMutable();
    float top = self.bounds.size.height - _waterTop - currentOffset;
    float wdiff = currentOffset* 0.2;
    
    if(currentOffset==0)
    {
        CGPathAddEllipseInRect(path, NULL, CGRectMake(_centerX-_radius, top, _radius*2, _radius*2));
    }
    else
    {
        CGPathAddArc(path, NULL, _centerX,top+_radius, _radius, 0, M_PI, YES);
        float bottom = top + wdiff+_radius*2;
        if(currentOffset<10)
        {
            CGPathAddCurveToPoint(path, NULL,_centerX - _radius,bottom,_centerX,bottom, _centerX,bottom);
            CGPathAddCurveToPoint(path, NULL, _centerX,bottom,_centerX+_radius,bottom, _centerX+_radius, top+_radius);
        }
        else
        {
            CGPathAddCurveToPoint(path, NULL,_centerX-_radius ,top +_radius, _centerX - _radius ,bottom-2,_centerX , bottom);
            CGPathAddCurveToPoint(path,NULL, _centerX + _radius, bottom-2, _centerX+_radius,top +_radius , _centerX+_radius, top+_radius);
        }
    }
    CGPathCloseSubpath(path);
    
    return path;
}
-(void)setCurrentOffset:(float)currentOffset
{
    if(_isRefresh)
        return;
    
    _refreshView.layer.opacity = 0;
    [self privateSetCurrentOffset:currentOffset];
}
-(void)privateSetCurrentOffset:(float)currentOffset
{
    currentOffset = currentOffset>0?0:currentOffset;
    currentOffset = -currentOffset;
    _currentOffset =  currentOffset;
    if(currentOffset < _maxDropLength)
    {
        float top = self.bounds.size.height - _waterTop - currentOffset;
        
        CGMutablePathRef path = [self createPathWithOffset:currentOffset];
        _shapeLayer.path = path;
        CGPathRelease(path);
        
        
        CGMutablePathRef line = CGPathCreateMutable();
        float w = ((_maxDropLength - currentOffset)/_maxDropLength) + 1;
        float lt = top + _radius*2;
        float lb = self.bounds.size.height;

        if(currentOffset==0)
        {
            CGPathAddRect(line, NULL, CGRectMake(_centerX-w/2, lt , 2 , lb-lt));
        }
        else{
            
            CGPathMoveToPoint(line, NULL, _centerX- w/2,lt);
            CGPathAddLineToPoint(line, NULL, _centerX + w/2,lt);
            
            CGPathAddCurveToPoint(line, NULL,_centerX + w/2,lt+ 5, _centerX + w/2,lt+(lb-lt)/2 -5, _centerX+1 , lb);
            CGPathAddLineToPoint(line,  NULL, _centerX - 1, lb);
            CGPathAddCurveToPoint(line, NULL,_centerX- w/2,lt + 5, _centerX- w/2,lt+(lb-lt)/2 - 5,_centerX-w/2, lt);
        }
        CGPathCloseSubpath(line);
        _lineLayer.path = line;
        CGPathRelease(line);
        self.transform = CGAffineTransformMakeScale(0.85+0.15*(w-1), 1);
    }
    else
    {
        if(self.timer == nil)
        {
            _isRefresh = YES;
            self.transform = CGAffineTransformIdentity;
            self.timer = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(resetWater) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            [_timer fire];
        }
    }
}
-(void)resetWater
{
    [self privateSetCurrentOffset:-(_currentOffset-(_maxDropLength/8))];
    if(_currentOffset==0)
    {
        [self.timer invalidate];
        self.timer = nil;
        
        if(self.handleRefreshEvent!= nil)
        {
            self.handleRefreshEvent();
        }
        [self doudong];
    }
}
-(void)stopRefresh
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startRefreshAnimation) object:nil];
    _isRefresh = NO;
    
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.fromValue = @(1);
    anim.toValue = @(0);
    anim.duration = 0.2;
    anim.delegate = self;
    [_refreshView.layer addAnimation:anim forKey:nil];
    _refreshView.layer.opacity = 0;
    _doudongLayer.opacity = 0;
    
    anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.fromValue = @(0);
    anim.toValue = @(1);
    anim.beginTime = 0.2;
    anim.duration = 0.2;
    anim.delegate = self;
    [_shapeLayer addAnimation:anim forKey:nil];
    _shapeLayer.opacity = 0;
}
-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    if(anim.beginTime > 0)
    {
        _shapeLayer.opacity = 1;
    }
    else
    {
        [_refreshView.layer removeAllAnimations];
    }
}

-(void)startRefreshAnimation
{
    if(self.refreshView == nil)
    {
        self.refreshView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"first_timetowlight"]];
        [self addSubview:_refreshView];
    }
    
    _doudongLayer.opacity = 0;
    _shapeLayer.opacity = 0;
    
    _refreshView.center = CGPointMake(_centerX, _doudongLayer.frame.origin.y + _doudongLayer.frame.size.height/2);
    [_refreshView.layer removeAllAnimations];
    _refreshView.layer.opacity = 1;
    
    CABasicAnimation* alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.duration = 0.2;
    alpha.fromValue = @0.5;
    alpha.toValue = @1;
    
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 1;
    animation.beginTime = 0.1;
    animation.fromValue = @0;
    animation.toValue = @(M_PI*2);
    animation.repeatCount = INT_MAX;
    
    [_refreshView.layer addAnimation:alpha forKey:nil];
    [_refreshView.layer addAnimation:animation forKey:@"rotation"];
}
NS_INLINE CATransform3D CATransform3DMakeRotationScale(CGFloat angle,CGFloat sx, CGFloat sy,
                                                       CGFloat sz)
{
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, angle, 0, 0, 1);
    transform = CATransform3DScale(transform, sx, sy, sz);
    transform = CATransform3DRotate(transform, -angle, 0, 0, 1);
    return transform;
}
-(void)doudong
{
    _doudongLayer.opacity = 1;
    _shapeLayer.opacity = 0;
    
    float kDuration = 0.5;
    float angle = M_PI;
    float w = 1.3 , h = 1.3;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = [NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:_doudongLayer.transform],
                        [NSValue valueWithCATransform3D:CATransform3DMakeRotationScale(angle,w, 2-h, 1)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeRotationScale(angle,1-(w-1)*0.5, 1+(h-1)*0.5, 1)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeRotationScale(angle,1+(w-1)*0.25, 1-(h-1)*0.25, 1)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeRotationScale(angle,1, 1, 1)], nil];
    animation.keyTimes = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0],
                          [NSNumber numberWithFloat:0.3],
                          [NSNumber numberWithFloat:0.6],
                          [NSNumber numberWithFloat:0.9],
                          [NSNumber numberWithFloat:1], nil];
    _doudongLayer.transform = CATransform3DIdentity;
    animation.timingFunctions = [NSArray arrayWithObjects:
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], nil];
    
    animation.duration = kDuration;
    [_doudongLayer addAnimation:animation forKey:nil];
    
    __weak DDWaterDropView* wself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((kDuration-0.1f) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wself startRefreshAnimation];
    });
}
@end
