//
//  MemberVO.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MemberVO.h"

@implementation MemberVO

- (void)parseWithDic:(NSDictionary *)dic{
    
    self.configName = dic[@"configName"];
    self.chargeMoney = dic[@"chargeMoney"];
    self.giveMoney= dic[@"giveMoney"];
    
}


@end
