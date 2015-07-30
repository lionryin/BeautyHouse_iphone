//
//  UserProtocolVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/31.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "UserProtocolVC.h"
#import "MBProgressHUD.h"

@interface UserProtocolVC ()<UIWebViewDelegate>
@property (strong, nonatomic) MBProgressHUD    *progresshud;

@end
@implementation UserProtocolVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户协议";
    [self initMainUI];
}

- (void)initMainUI{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"user_agreement" ofType:@"html"];
    NSURL *url  = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_progresshud show:YES];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_progresshud hide:YES];
}

@end
