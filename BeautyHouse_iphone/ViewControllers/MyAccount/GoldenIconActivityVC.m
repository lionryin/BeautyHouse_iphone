//
//  GoldenIconActivityVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "GoldenIconActivityVC.h"
#import "GoldenIconTradeRecordVC.h"
#import "GoldenIconExchangeVC.h"
#import "MyAccountTVC.h"
#import "MZBWebService.h"

@interface GoldenIconActivityVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)NSInteger balance;

@end

@implementation GoldenIconActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"金币活动";
    self.balance = 0;
    [self initMainUI];
    
    [self getGoldenIconBalance];
}



- (void)initMainUI{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    //self.tableView.backgroundView.alpha = 0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    

}


- (NSString *)getUserLoginId{
    NSString *userId = nil;
    
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    userId = [userDic objectForKey:UserLoginId];
    
    return userId;
}


- (void)getGoldenIconBalance{
    
    if ([self getUserLoginId]) {
        NSString *jsonParam = [NSString stringWithFormat:@"{\"id\":\"%@\"}",[self getUserLoginId]];
        AFHTTPRequestOperation *opration = [MZBWebService getBalanceOfUserGoldCoinsQueryWithParameter:jsonParam];
        
        [opration start];
        
        [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
            NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

            
            MyPaser *parser = [[MyPaser alloc] initWithContent:result];
            [parser BeginToParse];

            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dic);
            NSNumber *rst = dic[@"result"];
            if (rst.integerValue == 0) {
                
                NSNumber *balanceNumber = dic[@"resultInfo"];
                self.balance = balanceNumber.integerValue;
                
                [self.tableView reloadData];
                
            }else{
                
//                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"resultInfo"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
//                
//                [av show];
            }
            
            
            
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            
        }];
        
    }else{
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请返回个人中心登录" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
    }
    
    
    
    
    
}


#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"MyAccountTVC";
    
    MyAccountTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[MyAccountTVC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        
    }
    
    NSString *str = nil;
    
    switch (indexPath.row) {
        case 0:
            str = [NSString stringWithFormat:@"金币余额:                  %li",(long)self.balance];
            break;
        case 1:
            str = @"金币交易记录查询";
            break;
        case 2:
            str = @"兑换";
            break;
        default:
            break;
    }
    
    
    cell.textLabel.text = str;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    if (indexPath.row != 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    
    return cell;
    
    
}




#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 44.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    switch (indexPath.row) {
        case 1:
        {
            GoldenIconTradeRecordVC *vc =[GoldenIconTradeRecordVC new];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
            break;
        case 2:
        {
            
            GoldenIconExchangeVC *vc =[GoldenIconExchangeVC new];
            vc.balance = self.balance;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
            
    }
    
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
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
