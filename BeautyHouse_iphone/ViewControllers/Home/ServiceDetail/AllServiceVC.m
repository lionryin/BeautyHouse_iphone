//
//  AllServiceVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AllServiceVC.h"
#import "HomeService.h"
#import "FloorCareVC.h"
#import "NewHouseCareVC.h"
#import "CleanerVC.h"
#import "CurtainCareVC.h"
#import "NurseVC.h"

#import "MZBHttpService.h"

//#define AllServiceCellID @"AllServiceCellID"

@interface AllServiceVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableList;

@end

@implementation AllServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"全部服务";
    [self initMainUI];
    
    /*HomeService *homeService = [[HomeService alloc] init];
    [homeService getAllServiceWithBlock:^(NSNumber *result, NSArray *resultInfo, NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            if ([result integerValue] == 0) {
                _tableList = [resultInfo mutableCopy];
                [self.tableView reloadData];
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发生未知错误，请重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }

    }];*/
    [[MZBHttpService shareInstance] getAllServiceWithBlock:^(NSArray *resultArray, NSError *error) {
        
       if (!error) {
            
            if (resultArray) {
                _tableList = [resultArray mutableCopy];
                [self.tableView reloadData];
            }
            else {
                
                [UIFactory showAlert:@"未知错误"];
            }
        }
        else {
            
            [UIFactory showAlert:@"网路错误"];
        }

    }];

    
   
}

- (void)initMainUI{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 144, self.view.frame.size.width, self.view.frame.size.height-144) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[self.tableView registerClass:[AllServiceCell class] forCellReuseIdentifier:AllServiceCellID];
    //self.tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _tableList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //MzbService *aService = [_tableList objectAtIndex:section];
    
    //return (aService.childServiceCategoryList.count+1)/2;
    
    NSDictionary *dic = [_tableList objectAtIndex:section];
    NSArray *arr = dic[@"mountedItems"];
    
    return (arr.count+1) / 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *AllServiceCellID = @"AllServiceCellID";
    
    UINib *nib = [UINib nibWithNibName:@"AllServiceCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:AllServiceCellID];
    
    AllServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:AllServiceCellID forIndexPath:indexPath];
    
    cell.delegate = self;
    
    //MzbService *ParentService = [_tableList objectAtIndex:indexPath.section];
    //NSArray *childArray = ParentService.childServiceCategoryList;
    
    NSDictionary *dic = [_tableList objectAtIndex:indexPath.section];
    
    NSArray *childArray = dic[@"mountedItems"];

    
    
    
    cell.childService1 = [childArray objectAtIndex:2*(indexPath.row)];
    
    if ( (2*(indexPath.row)+1) < childArray.count) {
        cell.childService2 = [childArray objectAtIndex:2*(indexPath.row)+1];
    }
    else{
        cell.childService2 = nil;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSDictionary *dic = [_tableList objectAtIndex:section];
    
   // MzbService *parentService = [_tableList objectAtIndex:section];
    
    NSString *serviceID = dic[@"id"];
    if ([serviceID isEqualToString:allServiceInfoID]) {//全部服务
        return nil;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8+10, 10, 14)];
    imageView.image = [UIImage imageNamed:@"arrow_right_gray.png"];
    [headerView addSubview:imageView];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28, 5+10, 200, 20)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setTextColor:[UIColor blackColor]];
    label.text = dic[@"name"];//parentService.serviceName;
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == _tableList.count-1){
        return 50;
    }
    return 0.01;
}
- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

#pragma mark - allServiceCell delegate
- (void)AllServiceCellButtonPressed:(id)sender andMzbService:(NSDictionary *)aService{
    /*if ([aService.serviceParentId isEqualToString:@"11690485605"]) {//家居洗护
        if ([aService.serviceId isEqualToString:@"20843422762"]) {//清洗窗帘
            CurtainCareVC *curtainCareVC = [[CurtainCareVC alloc] initWithNibName:@"CurtainCareVC" bundle:nil];
            curtainCareVC.serviceInfo = aService;
            [self.navigationController pushViewController:curtainCareVC animated:YES];
        }
        else{//地板保养；沙发保养；高温杀菌；油烟机清洗；洗衣洗鞋
            FloorCareVC *floorCareVC = [[FloorCareVC alloc] initWithNibName:@"FloorCareVC" bundle:nil];
            floorCareVC.serviceInfo= aService;
            [self.navigationController pushViewController:floorCareVC animated:YES];
        }
    }
    else if ([aService.serviceParentId isEqualToString:@"51302610230"]){//保洁服务
        
        if ([aService.serviceId isEqualToString:@"18181630679"]) {//新居开荒
            NewHouseCareVC *newHouseCareVC = [[NewHouseCareVC alloc] initWithNibName:@"NewHouseCareVC" bundle:nil];
            newHouseCareVC.serviceInfo = aService;
            [self.navigationController pushViewController:newHouseCareVC animated:YES];
        }
        else{//钟点保洁；定期保洁
            CleanerVC *clearnerVC = [[CleanerVC alloc] initWithNibName:@"CleanerVC" bundle:nil];
            clearnerVC.serviceInfo = aService;
            [self.navigationController pushViewController:clearnerVC animated:YES];
        }
    }
    else if ([aService.serviceParentId isEqualToString:@"49313730143"]){//综合保姆
        
        NurseVC *nurseVc = [[NurseVC alloc] initWithNibName:@"NurseVC" bundle:nil];
        nurseVc.serviceInfo = aService;
        [self.navigationController pushViewController:nurseVc animated:YES];
    }
    else{//更多服务
        if ([aService.serviceId isEqualToString:@"80069561635"]) {//全部服务
            AllServiceVC *allServiceVC = [[AllServiceVC alloc] initWithNibName:@"AllServiceVC" bundle:nil];
            
            [self.navigationController pushViewController:allServiceVC animated:YES];
        }
    }*/

}


@end
