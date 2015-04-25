//
//  MemberVO.h
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberVO : NSObject

@property (nonatomic,strong)NSString *configName;
@property (nonatomic,strong)NSNumber *chargeMoney;
@property (nonatomic,strong)NSNumber *giveMoney;

- (void)parseWithDic:(NSDictionary *)dic;

@end
