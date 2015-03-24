//
//  ServiceIntroductionVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ServiceIntroductionVC.h"

@interface ServiceIntroductionVC ()

@end

@implementation ServiceIntroductionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlStr]];
    [_webView loadRequest:request];
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
