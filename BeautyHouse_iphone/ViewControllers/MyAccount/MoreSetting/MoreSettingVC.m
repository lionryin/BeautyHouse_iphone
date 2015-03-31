//
//  MoreSettingVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MoreSettingVC.h"
#import "MyAccountTVC.h"

#import "UserProblemsVC.h"
#import "UserProtocolVC.h"
#import "SoftwareUpdateVC.h"
#import "AboutVC.h"


@interface MoreSettingVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation MoreSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多设置";
    [self initMainUI];
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
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"MyAccountTVC";
    
    MyAccountTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[MyAccountTVC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    
    NSString *str = nil;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                str = @"常见问题";
                break;
            case 1:
                str = @"用户协议";
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                str = @"版本升级";
                break;
            case 1:
                str = @"关于";
                break;
            default:
                break;
        }
    }
    
    cell.textLabel.text = str;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
    
}




#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                UserProblemsVC *vc =[UserProblemsVC new];
                
                [self.navigationController pushViewController:vc animated:YES];

                
            }
                break;
            case 1:
            {

                UserProtocolVC *vc =[UserProtocolVC new];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {

                SoftwareUpdateVC *vc =[SoftwareUpdateVC new];
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                AboutVC *vc =[AboutVC new];
                
                [self.navigationController pushViewController:vc animated:YES];

            }
                break;
            default:
                break;
        }
    }
    
    
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
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
