//
//  MoreDemandVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreDemandVCDelegate <NSObject>

- (void)moreDemandVCGetDemand:(NSString *)demand;

@end

@interface MoreDemandVC : UIViewController

@property (strong, nonatomic) NSString *moreDemand;

@property (assign, nonatomic) id<MoreDemandVCDelegate>delegate;

@end
