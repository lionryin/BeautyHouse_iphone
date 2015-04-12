//
//  AccountExpenseRecordVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/1.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AccountExpenseRecordVC.h"

@interface AccountExpenseRecordVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
@implementation AccountExpenseRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消费记录";
    [self initMainUI];
}

- (void)initMainUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
}

- (void)getExpenseRecord{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuserIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIdentifier];
        
    }
    
    cell.textLabel.text = @"消费记录测试数据";
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"消费记录";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}



@end
