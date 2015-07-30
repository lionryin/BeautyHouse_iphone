//
//  AllServiceButton.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AllServiceButton.h"

#define KFont 14
#define KImageWith 23
#define KImageHeight 21
#define KTitleHeight 20
#define kTitleWith 100

@implementation AllServiceButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        //设置文字
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        //self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:KFont];
        //设置图片
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(35, 5, kTitleWith, KTitleHeight);
}

-(CGRect )imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(7, 4, KImageWith, KImageHeight);
    
}


@end
