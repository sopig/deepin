//
//  TimeScroller.m
//  TimerScroller
//
//  Created by Andrew Carter on 12/4/11.


#import "DDTimeScroller.h"
#import <QuartzCore/QuartzCore.h>

#import "DDMacro.h"

@interface DDTimeScroller()
{
    __weak UITableView *_tableView;
    __weak UIImageView *_scrollBar;
    UILabel *_timeLabel;
    UILabel *_dateLabel;
    UIImageView *_backgroundView;
  
    CGSize _savedTableViewSize;
}

@property (nonatomic, copy) NSDateFormatter *timeDateFormatter;


@end

@implementation DDTimeScroller

- (id)initWithDelegate:(id<DDTimeScrollerDelegate>)delegate
{

     UIImage *background = [[UIImage imageNamed:@"wareBlackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 35.0f, 0.0f, 10.0f)];
    
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, background.size.height)];
    if (self)
    {
        self.calendar = [NSCalendar currentCalendar];
        
        self.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, CGRectGetHeight(self.frame));
        self.alpha = 0.0f;
        self.transform = CGAffineTransformMakeTranslation(10.0f, 0.0f);
        
        _backgroundView = [[UIImageView alloc] initWithImage:background];
        _backgroundView.frame = CGRectMake(CGRectGetWidth(self.frame) - 80.0f, 30.0f, 80.0f, CGRectGetHeight(self.frame));
        [self addSubview:_backgroundView];

    
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 4.0f, 120.0f, 20.0f)];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.shadowColor = [UIColor blackColor];
        _timeLabel.shadowOffset = CGSizeMake(-0.5f, -0.5f);
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0f];
        _timeLabel.autoresizingMask = UIViewAutoresizingNone;
        [_backgroundView addSubview:_timeLabel];
        
       
    
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0f, 20.0f, 100.0f, 20.0f)];
        _dateLabel.textColor = [UIColor colorWithRed:179.0f green:179.0f blue:179.0f alpha:0.60f];
        _dateLabel.shadowColor = [UIColor blackColor];
        _dateLabel.shadowOffset = CGSizeMake(-0.5f, -0.5f);
        _dateLabel.backgroundColor = [UIColor clearColor];
        _dateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0f];
        _dateLabel.alpha = 0.0f;
        [_backgroundView addSubview:_dateLabel];
        
    
        
        _delegate = delegate;
    }
    return self;
}

- (void)createFormatters
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:self.calendar];
    [dateFormatter setTimeZone:self.calendar.timeZone];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 h:mm a"];
    self.timeDateFormatter = dateFormatter;
    
}


- (void)setCalendar:(NSCalendar *)cal
{
    _calendar = cal;
    
    [self createFormatters];
}


- (void)captureTableViewAndScrollBar
{
    _tableView = [self.delegate tableViewForTimeScroller:self];
    
    self.frame = CGRectMake(CGRectGetWidth(self.frame) - 10.0f, 0.0f, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    
    for (id subview in [_tableView subviews])
    {
        if ([subview isKindOfClass:[UIImageView class]])
        {
            UIImageView *imageView = (UIImageView *)subview;
            
            if (
                imageView.frame.size.width == 7.0f ||
                imageView.frame.size.width == 5.0f ||
                imageView.frame.size.width == 3.5f ||
                imageView.frame.size.width == 2.5f
                )
            {
                imageView.clipsToBounds = NO;
                [imageView addSubview:self];
                _scrollBar = imageView;
                _savedTableViewSize = _tableView.frame.size;
            }
        }
    }
}

- (void)updateDisplayWithCell:(UITableViewCell *)cell
{
    NSString *str = [self.delegate timeScroller:self ContentdateForCell:cell];
    
    NSDate *today = [NSDate date];
    
    _timeLabel.text = [self.timeDateFormatter stringFromDate:today];
    
    CGRect backgroundFrame;
    CGRect timeLabelFrame;
    CGRect dateLabelFrame = _dateLabel.frame;
    NSString *dateLabelString;
    NSString *timeLabelString = _timeLabel.text;
    CGFloat dateLabelAlpha;
        
    timeLabelFrame = CGRectMake(5.0f, 4.0f, 120.0f, 10.0f);
    backgroundFrame = CGRectMake(CGRectGetWidth(self.frame) - 130 , 0.0f, 130, CGRectGetHeight(self.frame));
    dateLabelFrame = _dateLabel.frame;
    dateLabelString = str;
    dateLabelAlpha = 1.0f;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowAnimatedContent animations:^{
        
        _timeLabel.frame = timeLabelFrame;
        _dateLabel.frame = dateLabelFrame;
        _dateLabel.alpha = dateLabelAlpha;
        _timeLabel.text = timeLabelString;
        _dateLabel.text = dateLabelString;
        _backgroundView.frame = backgroundFrame;
        
    } completion:nil];
}

- (void)scrollViewDidScroll
{
    if (!_tableView || !_scrollBar)
    {
        [self captureTableViewAndScrollBar];
    }
    
    [self checkChanges];
    
    if (!_scrollBar)
    {
        return;
    }
    
    CGRect selfFrame = self.frame;
    CGRect scrollBarFrame = _scrollBar.frame;
    
    self.frame = CGRectMake(CGRectGetWidth(selfFrame) * -1.0f,
                            (CGRectGetHeight(scrollBarFrame) / 2.0f) - (CGRectGetHeight(selfFrame) / 2.0f),
                            CGRectGetWidth(selfFrame),
                            CGRectGetHeight(_backgroundView.frame));
    
    CGPoint point = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    point = [_scrollBar convertPoint:point toView:_tableView];
    
    UITableViewCell* cell=[_tableView cellForRowAtIndexPath:[_tableView indexPathForRowAtPoint:point]];
    if (cell) {
        [self updateDisplayWithCell:cell];
        if (![self alpha])
        {
            [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self setAlpha:1.0f];
            } completion:nil];
        }
    }
    else
    {
        if ([self alpha])
        {
            [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self setAlpha:0.0f];
            } completion:nil];
        }
    }
}

- (void)scrollViewDidEndDecelerating
{
    if (!_scrollBar)
    {
        return;
    }
    
    CGRect newFrame = [_scrollBar convertRect:self.frame toView:_tableView.superview];
    self.frame = newFrame;
    [_tableView.superview addSubview:self];
    
    [UIView animateWithDuration:0.15f delay:1.0f options:UIViewAnimationOptionBeginFromCurrentState  animations:^{
        
        self.alpha = 0.0f;
        self.transform = CGAffineTransformMakeTranslation(10.0f, 0.0f);
        
    } completion:nil];
}


- (void)scrollViewWillBeginDragging
{
    if (!_tableView || !_scrollBar)
    {
        [self captureTableViewAndScrollBar];
    }
    
    if (!_scrollBar)
    {
        return;
    }
    
    CGRect selfFrame = self.frame;
    CGRect scrollBarFrame = _scrollBar.frame;
    
    
    self.frame = CGRectIntegral(CGRectMake(CGRectGetWidth(selfFrame) * -1.0f,
                                           (CGRectGetHeight(scrollBarFrame) / 2.0f) - (CGRectGetHeight(selfFrame) / 2.0f),
                                           CGRectGetWidth(selfFrame),
                                           CGRectGetHeight(selfFrame)));
    
    [_scrollBar addSubview:self];
    
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState  animations:^{
        
        self.alpha = 1.0f;
        self.transform = CGAffineTransformIdentity;
        
    } completion:nil];
    
}


- (void)invalidate
{
    _tableView = nil;
    _scrollBar = nil;
    [self removeFromSuperview];
}


- (void)checkChanges
{
    if (!_tableView ||
        _savedTableViewSize.height != _tableView.frame.size.height ||
        _savedTableViewSize.width != _tableView.frame.size.width)
    {
        [self invalidate];
    }
}

@end
