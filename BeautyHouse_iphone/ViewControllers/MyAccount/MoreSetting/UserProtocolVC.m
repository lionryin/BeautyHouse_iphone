//
//  UserProtocolVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/31.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "UserProtocolVC.h"

@implementation UserProtocolVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户协议";
    [self initMainUI];
}

- (void)initMainUI{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"user_agreement" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
}


@end
