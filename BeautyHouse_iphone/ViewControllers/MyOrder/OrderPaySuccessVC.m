//
//  OrderPaySuccessVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "OrderPaySuccessVC.h"

@interface OrderPaySuccessVC ()

@end

@implementation OrderPaySuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"会员中心";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 4, 20)];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];

    
}

- (void)leftClick{
    //[self dismissViewControllerAnimated:YES completion:nil];
    if ([self.delegate respondsToSelector:@selector(orderPaySuccessVCLeftButtonClicked)]) {
        [self.delegate orderPaySuccessVCLeftButtonClicked];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
