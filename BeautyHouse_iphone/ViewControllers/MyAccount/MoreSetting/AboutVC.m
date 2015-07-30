//
//  AboutVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/31.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AboutVC.h"

@interface AboutVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end


@implementation AboutVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    [self initMainUI];
}

- (void)initMainUI{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"AboutTVC";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
    }
    
    NSString *str = @"";
    NSString *detailStr = @"";
    
    switch (indexPath.row) {
        case 0:
            str = @"微信关注 :";
            detailStr = @"meizhaibao";
            break;
        case 1:
            str = @"新浪微博 :";
            detailStr = @"meizhaibao@sina.com";
            break;
        case 2:
            str = @"公司网站 :";
            detailStr = @"http://www.mrchabo.com";
            break;
            
        default:
            break;
    }
    
    
    

    
    cell.textLabel.text = str;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    //cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    cell.detailTextLabel.text = detailStr;
    cell.detailTextLabel.textColor = [UIColor orangeColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    //cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    
    
    return cell;
    
    
}




#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44.0;
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 280;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"关注我们的官方微信和微博,参加我们的活动,即有机会获得金币积分~";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"         ©2015 美宅宝 鄂ICP备14019882号-1";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
