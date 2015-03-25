//
//  MyAccountVC.m
//  BeautyHouse
//
//  Created by Roy on 15/3/22.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyAccountVC.h"
#import "MyAccountTVC.h"


@interface MyAccountVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MyAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self initMainUI];
    // Do any additional setup after loading the view.
}



- (void)initMainUI{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"MyAccountTVC";
    
    MyAccountTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[MyAccountTVC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        //cell.delegate = self;
    }
    
    NSString *str = nil;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                str = @"金币活动";
                break;
            case 1:
                str = @"账户详情";
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                str = @"告诉朋友";
                break;
            case 1:
                str = @"意见反馈";
                break;
            case 2:
                str = @"获取开通服务城市";
                break;
            case 3:
                str = @"更多设置";
                break;
            default:
                break;
        }
    }
    
    cell.textLabel.text = str;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
    
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    return 44.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 120;
    }else{
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return 20;
    }
    return 0.01;
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
