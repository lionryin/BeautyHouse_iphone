//
//  OrderVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/14.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "OrderVC.h"
#import "OrderView.h"


@interface OrderVC ()

@property (strong, nonatomic) OrderView *mOrderView;


@end

@implementation OrderVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单";
    
    self.edgesForExtendedLayout =UIRectEdgeNone ;
    
    if (_mOrderView == nil) {
        _mOrderView = [[OrderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64-49)];
    }
    [self.view addSubview:_mOrderView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
