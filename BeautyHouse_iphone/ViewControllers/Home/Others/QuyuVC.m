//
//  QuyuVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "QuyuVC.h"

@interface QuyuVC ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *tableList;

@end

@implementation QuyuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMainUI];
    
    self.title = @"区域选择";
    
    self.tableList = @[@"江岸区",@"江汉区",@"乔口区",@"汉阳区",@"武昌区",@"青山区",@"洪山区",@"东西湖区",@"汉南区",@"蔡甸区",@"江夏区",@"黄陂区",@"新洲区"];
    
}

- (void)initMainUI{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView datasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuyuCellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuyuCellID"];
    }
    
    cell.textLabel.text = [self.tableList objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - tableView delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"区域列表";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate quyuVCSelectedQuyu:[self.tableList objectAtIndex:indexPath.row]];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
