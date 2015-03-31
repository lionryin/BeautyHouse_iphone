//
//  XiaohaopinVC.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XiaohaopinVCDelegate <NSObject>

- (void)xiaohaopinVCIsXhpOrBjtc:(NSString *)name andContent:(NSString *)content andSelectedImageViewTag:(NSInteger)imageViewtag;

@end

@interface XiaohaopinVC : UIViewController

@property (assign, nonatomic) id<XiaohaopinVCDelegate>delegate;

@property (nonatomic) NSInteger selectedXhpTag;
@property (nonatomic) NSInteger selectedBjtcTag;

@end
