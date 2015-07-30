//
//  BaseViewController.m
//  BeautyHouse
//
//  Created by Roy on 15/3/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()


@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    
    //frame
//    CGRect thisRc = [UIScreen mainScreen].applicationFrame;
//    float naviHeight = self.navigationController.navigationBar.frame.size.height;
//    
//    float tabHeight = 49;
//    if (self.hidesBottomBarWhenPushed) {
//        thisRc.size.height -= naviHeight;
//    } else {
//        thisRc.size.height -= naviHeight + tabHeight;
//    }
//    self.view.frame = thisRc;
    // Do any additional setup after loading the view.

}

- (void)initMainUI{}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
