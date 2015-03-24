//
//  BaseTVC.m
//  BeautyHouse
//
//  Created by Roy on 15/3/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@implementation BaseTVC

- (void)setFrame:(CGRect)frame
{
    CGRect rc = CGRectMake(frame.origin.x + self.cellEdge, frame.origin.y, frame.size.width - self.cellEdge * 2, frame.size.height);
    [super setFrame:rc];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
