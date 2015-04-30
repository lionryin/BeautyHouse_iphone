//
//  CountdownButton.h
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountdownButton : UIButton

@property(nonatomic)float mTimeInterVal;


@property(nonatomic)float mOriginalTime;



- (id)initWithFrame:(CGRect)frame
               time:(float)time
        normalTitle:(NSString *)normalTitle
      countingTitle:(NSString *)countingTitle;


- (void)startCounting;





@end
