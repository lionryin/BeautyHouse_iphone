//
//  HomeButton.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeButton.h"

#define KFont 12
#define KImageWith 46
#define KImageHeight 42
#define KTitleHeight 20
#define kTitleWith 106

@implementation HomeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        //设置文字
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:KFont];
        //设置图片
        self.imageView.contentMode=UIViewContentModeScaleAspectFit;
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, 10+KImageHeight+8, kTitleWith, KTitleHeight);
}

-(CGRect )imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(30, 10, KImageWith, KImageHeight);
    
}


@end
