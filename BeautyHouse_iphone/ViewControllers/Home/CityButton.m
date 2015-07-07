//
//  CityButton.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/6.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CityButton.h"

#define KFont 12
#define KImageWith 11
#define KImageHeight 12
#define KTitleHeight 20
#define kTitleWith 38

@implementation CityButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置文字
        [self setTitleColor:[UIColor colorWithRed:0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        self.titleLabel.textAlignment=NSTextAlignmentRight;
        self.titleLabel.font=[UIFont systemFontOfSize:KFont];
        //设置图片
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    
    return self;
}


-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, 12, kTitleWith, KTitleHeight);
}

-(CGRect )imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(kTitleWith+2, 16, KImageWith, KImageHeight);
    
}


@end
