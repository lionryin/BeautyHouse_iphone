//
//  CountdownButton.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CountdownButton.h"

@interface CountdownButton ()
@property(nonatomic, strong)NSString* titleFormat;
@property(nonatomic, strong)NSString* normalTitle;
@property(nonatomic, weak)NSTimer* mTimer;
@end


@implementation CountdownButton

- (id)initWithFrame:(CGRect)frame
               time:(float)time
        normalTitle:(NSString *)normalTitle
      countingTitle:(NSString *)countingTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleFormat = [countingTitle stringByAppendingString:@"(%.fs)"];
        self.mTimeInterVal = time;
        self.mOriginalTime = time;
        self.normalTitle = normalTitle;
        [self setTitle:normalTitle forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor orangeColor]];
        [self.titleLabel setNumberOfLines:0];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return self;
}


- (void)timeMethod
{
    self.mTimeInterVal --;
    if (_mTimeInterVal < 0) {
        [self.mTimer invalidate];
        [self setMTimer:nil];
        [self setTitle:_normalTitle forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor orangeColor]];
        self.enabled = YES;
    } else {
        [self setTitle:[NSString stringWithFormat:_titleFormat, _mTimeInterVal] forState:UIControlStateNormal];
    }
}


- (void)startCounting
{
    
    self.mTimeInterVal = _mOriginalTime;
    self.mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeMethod) userInfo:nil repeats:YES];
    self.enabled = NO;
    [self setBackgroundColor:[UIColor lightGrayColor]];
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (self.mTimer) {
        [self.mTimer invalidate];
        [self setMTimer:nil];
    }
}


@end
