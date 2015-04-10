//
//  SaveOrderSuccessVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SaveOrderSuccessVC.h"

@interface SaveOrderSuccessVC ()

@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceAddressLabel;

@end

@implementation SaveOrderSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"下单成功";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 4, 20)];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_back.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消订单" style:UIBarButtonItemStylePlain target:self action:@selector(cancelOrder)];
    [rightItem setTintColor:[UIColor orangeColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelOrder{
    
}

- (void)leftClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
