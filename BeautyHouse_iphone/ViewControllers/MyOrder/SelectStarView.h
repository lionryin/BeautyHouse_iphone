//
//  SelectStarView.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectStarView : UIView

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;

- (IBAction)buttonClicked:(id)sender;

@end
