//
//  SaveOrderSuccessVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "SaveOrderSuccessVC.h"
#import "HomeService.h"
#import "MBProgressHUD.h"

@interface SaveOrderSuccessVC ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceAddressLabel;

@property (strong, nonatomic) MBProgressHUD *hud;

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
    
    
    ///////
    if (_order) {
        self.serviceNameLabel.text = _order.title;
        self.serviceTimeLabel.text = _order.time;
        self.serviceAddressLabel.text = _order.address;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelOrder{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要取消订单吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
     alert.tag = 99;
     [alert show];
}

- (void)leftClick{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 99 && buttonIndex == 1) {
        NSLog(@"%li",buttonIndex);
        
        NSString *param = [NSString stringWithFormat:@"{\"id\":\"%@\"}", self.order.orderID];
        
        _hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        _hud.labelText = @"取消中...";
        [self.navigationController.view addSubview:_hud];
        [_hud show:YES];

         
         HomeService *homeService = [HomeService alloc];
         [homeService cancelOrdersWithParam:param andWithBlock:^(NSNumber *result, NSError *error) {
             [_hud hide:NO];
             
             if (!error) {
                 if ([result integerValue] == 0) {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单已经成功取消！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                     alert.tag = 100;
                     [alert show];
                 }
                 else{
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发生未知错误，请重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                     [alert show];
                 }
                
                 //[self dismissViewControllerAnimated:YES completion:nil];
             }
             else{
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                 [alert show];
             }
         }];
    }
    else if (alertView.tag == 100 ){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
