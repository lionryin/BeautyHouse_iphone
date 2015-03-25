//
//  HomeTableVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/8.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeTableVC.h"
#import "HomeAdCell.h"
#import "HomeService.h"
#import "FloorCareVC.h"
#import "NewHouseCareVC.h"
#import "CleanerVC.h"
#import "CurtainCareVC.h"
#import "NurseVC.h"
#import "AllServiceVC.h"



@interface HomeTableVC ()

@end

@implementation HomeTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:255.0/255 green:127.0/255 blue:80.0/255 alpha:1.0]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _adInfos = [[NSArray alloc] init];
    _serviceInfos = [[NSArray alloc] init];
    
    HomeService *homeService = [[HomeService alloc] init];
    [homeService getHomeServiceWithBlock:^(NSString *result, NSArray *resultInfo, NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            _serviceInfos = [resultInfo mutableCopy];
            [self.tableView reloadData];
        }
        
    }];
    [homeService getHomeAdWithBlock:^(NSString *result, NSArray *resultInfo, NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            _adInfos = [resultInfo mutableCopy];
            [self.tableView reloadData];
        }

    }];
    
    
/*    ///test
    //AFHTTPRequestOperation *opration = [MZBWebService getHomePageServiceCategroy];
    
    AFHTTPRequestOperation *opration = [MZBWebService getCurrentOrderListWithParameter:@"{\"proc\":{\"registeredUserId\":\"m78087037527\",\"checkOrderInfo\":1},\"order1\":\"orderDateTime\",\"sort1\":\"desc\",\"pageIndex\":0,\"pageSize\":5}"];
    
    
    [opration start];
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
        NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",result);
        
        MyPaser *parser = [[MyPaser alloc] initWithContent:result];
        [parser BeginToParse];
        
        //NSLog(@"%@",parser.result);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error description]);
    }];
    
    */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier1 = @"HomeAdCell_Identifier";
    static NSString *CellIdentifier2 = @"HomeBntCell_Identifier";
    
    UITableViewCell *cell = nil;
    
    NSInteger row = indexPath.row;
    
    if (row == 0) {//ad
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[HomeAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        ((HomeAdCell *)cell).adArray = _adInfos;
        
        return cell;
        
        
    }
    else if (row == 1){//bnt
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        
        ((HomeBtnCell *)cell).serviceInfos = _serviceInfos;
        ((HomeBtnCell *)cell).delegate = self;
        
        return cell;
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }

        return cell;
    }
    
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 160;
    }
    else if (indexPath.row == 1){
        return 286;
    }
    else{
        return 44;
    }
}

#pragma mark - HomeBtnCell delegate
- (void)HomeBtnCellButtonPressed:(id)sender andServiceInfos:(NSArray *)infos
{
    UIButton *button = (UIButton *)sender;
    MzbService *aService = [infos objectAtIndex:button.tag-1];
    
 /*   if ([aService.serviceName isEqualToString:@"地板保养"]) {
        FloorCareVC *floorCareVC = [[FloorCareVC alloc] initWithNibName:@"FloorCareVC" bundle:nil];
        floorCareVC.serviceInfo= aService;
        [self.navigationController pushViewController:floorCareVC animated:YES];
        
    }*/
    if ([aService.serviceParentId isEqualToString:@"11690485605"]) {//家居洗护
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
    else if ([aService.serviceParentId isEqualToString:@"23333"]){
        
    }
    else{//更多服务
        if ([aService.serviceId isEqualToString:@"80069561635"]) {//全部服务
            AllServiceVC *allServiceVC = [[AllServiceVC alloc] initWithNibName:@"AllServiceVC" bundle:nil];
            
            [self.navigationController pushViewController:allServiceVC animated:YES];
        }
    }
   
    
}

@end
