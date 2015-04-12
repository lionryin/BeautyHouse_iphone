//
//  UserProblemsVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/31.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "UserProblemsVC.h"

@interface UserProblemsVC ()

@end


@implementation UserProblemsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常见问题";
    [self initMainUI];
}


- (void)initMainUI{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    

    NSString *path = [[NSBundle mainBundle] pathForResource:@"question" ofType:@"html"];
    NSURL *url  = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}



@end
