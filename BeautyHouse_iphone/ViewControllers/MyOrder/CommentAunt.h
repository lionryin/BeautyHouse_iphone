//
//  CommentAunt.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderVO.h"

@protocol CommentAuntDelegate <NSObject>

- (void)commentAuntSuccess;

@end

@interface CommentAunt : UIViewController

@property (nonatomic, strong) MyOrderVO *orderVO;
@property (nonatomic, strong) NSDictionary *orderItem;
@property (nonatomic, assign) id<CommentAuntDelegate>delegate;

@end
