//
//  AccountRechargeVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AccountRechargeVC.h"

@interface AccountRechargeVC ()
@property (nonatomic, strong) UITextField *exchTF;
@end
@implementation AccountRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线充值";
    [self initMainUI];
}


- (void)initMainUI{
    
    UIView *containView = [[UIView alloc]initWithFrame:CGRectMake(10, 64+15, self.view.frame.size.width-20, 44)];
    containView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containView];
    
    
    
    UILabel *exchStr = [self createLabelWithFrame:CGRectMake(0, 0,120, 44)];
    exchStr.text = @" 充值金额:";
    [containView addSubview:exchStr];
    
    
    _exchTF = [[UITextField alloc]initWithFrame:CGRectMake(110, 0, containView.frame.size.width-120, 44)];
    _exchTF.placeholder = @"输入想充值的金额";
    _exchTF.textAlignment =  NSTextAlignmentCenter;
    [containView addSubview:_exchTF];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(10, 64+15+70, self.view.frame.size.width-20, 40)];
    [nextBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor orangeColor]];
    nextBtn.layer.cornerRadius = 4;
    [nextBtn addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}


- (void)nextBtnAction:(id)sender{
    
}

- (UILabel *)createLabelWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    return label;
}

@end
