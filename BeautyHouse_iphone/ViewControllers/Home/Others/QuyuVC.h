//
//  QuyuVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuyuVCDelegate <NSObject>

- (void)quyuVCSelectedQuyu:(NSString *)quyu;

@end

@interface QuyuVC : UIViewController

@property (assign, nonatomic) id<QuyuVCDelegate> delegate;

@end
