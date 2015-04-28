//
//  SelectStarView.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SelectStarView.h"

@implementation SelectStarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews{
    for (int i =1; i<=5; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i];
        [button setImage:[UIImage imageNamed:@"star_normal.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"star_select.png"] forState:UIControlStateSelected];
    }
}

- (void)setButtonWithTag:(NSInteger)tag{
    
    for (int i=1; i<=5 ; i++) {
        UIButton *buttoni = (UIButton *)[self viewWithTag:i];
        if (i<tag) {
            buttoni.selected = YES;
        }
        else{
            buttoni.selected = NO;

        }
    }

}


- (IBAction)buttonClicked:(id)sender{
    UIButton *button = (UIButton *)sender;
    [self setButtonWithTag:button.tag];
}


@end
