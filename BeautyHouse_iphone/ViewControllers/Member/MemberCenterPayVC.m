//
//  MemberCenterPayVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MemberCenterPayVC.h"

@interface MemberCenterPayVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;


@end

@implementation MemberCenterPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"会员";
    
    [self initMainUI];
    
    // Do any additional setup after loading the view.
}


- (void)initMainUI{
    
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}


#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *reuse = @"JoinTVC";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = [NSString stringWithFormat:@"账户申请:  %@",self.memberVO.configName];
            }
                break;
                
            case 1:
            {
                cell.textLabel.text = [NSString stringWithFormat:@"充值金额:  %li",self.memberVO.chargeMoney.integerValue];
            }
                break;
                
            case 2:
            {
                cell.textLabel.text = [NSString stringWithFormat:@"赠送金额:  %li",self.memberVO.giveMoney.integerValue];
            }
                break;
                
            default:
                break;
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];

        return cell;
        
    }else{
        
        static NSString *reuse = @"PrivilegeTVC";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        
        switch (indexPath.row) {
            case 0:
            {
                UIImageView *aliPayIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 43, 36)];
                [aliPayIV setImage:[UIImage imageNamed:@"zhifubao"]];
                [cell.contentView addSubview:aliPayIV];
                
                
                UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 100, 30)];
                name.text = @"支付宝支付";
                name.font = [UIFont systemFontOfSize:14];
                name.textAlignment = NSTextAlignmentLeft;
                [cell.contentView addSubview:name];
                
                UIImageView *flagIV = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 50, 5, 30, 30)];
                [flagIV setImage:[UIImage imageNamed:@"pay_unselected"]];
                [cell.contentView addSubview:flagIV];
                
                
                
                
            }
                break;
                
            case 1:
            {
                UIImageView *aliPayIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 43, 36)];
                [aliPayIV setImage:[UIImage imageNamed:@"weixin2"]];
                [cell.contentView addSubview:aliPayIV];
                
                
                UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, 100, 30)];
                name.text = @"微信支付";
                name.font = [UIFont systemFontOfSize:14];
                name.textAlignment = NSTextAlignmentLeft;
                [cell.contentView addSubview:name];
                
                UIImageView *flagIV = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 50, 5, 30, 30)];
                [flagIV setImage:[UIImage imageNamed:@"pay_unselected"]];
                [cell.contentView addSubview:flagIV];
            }
                break;
                
            default:
                break;
        }

        
        
        
        return cell;
        
    }
    
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 44;
    }
    return 50;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 1) {
        
    }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"信息确认";
    }else{
        return @"选择支付方式";
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
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
