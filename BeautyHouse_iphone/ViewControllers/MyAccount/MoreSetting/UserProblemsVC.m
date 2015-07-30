//
//  UserProblemsVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/31.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "UserProblemsVC.h"
#import "MBProgressHUD.h"

@interface UserProblemsVC ()<UIWebViewDelegate>
@property (strong, nonatomic) MBProgressHUD        * progresshud;

@end


@implementation UserProblemsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常见问题";
    [self initMainUI];
    
    _progresshud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_progresshud];
    [_progresshud show:NO];
}


- (void)initMainUI{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    

    NSString *path = [[NSBundle mainBundle] pathForResource:@"question" ofType:@"html"];
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
