//
//  UserProblemsVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/31.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "UserProblemsVC.h"

@implementation UserProblemsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常见问题";
    [self initMainUI];
}


- (void)initMainUI{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"question" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
}

@end
