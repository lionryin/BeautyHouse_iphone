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
#import "CityButton.h"

#import "MZBHttpService.h"
#import "AppDelegate.h"
#import "CityListVC.h"



@interface HomeTableVC ()<CityListVCDelegate>

@property (strong, nonatomic) CityButton *servicePhoneBtn;

@end

@implementation HomeTableVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0 green:122/255.0 blue:255/255.0 alpha:1.0]];//[UIColor colorWithRed:255.0/255 green:127.0/255 blue:80.0/255 alpha:1.0]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
   
    ////
    _servicePhoneBtn = [CityButton buttonWithType:UIButtonTypeCustom];
    [_servicePhoneBtn setFrame:CGRectMake(0, 0, 52, 44)];
    [_servicePhoneBtn setTitle:@"武汉市" forState:UIControlStateNormal];
    [_servicePhoneBtn setImage:[UIImage imageNamed:@"logo_select_city.png"] forState:UIControlStateNormal];
    [_servicePhoneBtn addTarget:self action:@selector(cityClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *servicePhoneBarBtn = [[UIBarButtonItem alloc] initWithCustomView:_servicePhoneBtn];
    self.navigationItem.leftBarButtonItem = servicePhoneBarBtn;
    
    
    _adInfos = [[NSArray alloc] init];
    _serviceInfos = [NSArray array];//[self getAllServiceInfosWithInfos:[NSArray array]];
    _cities = [NSArray array];
    _currentCity = [NSDictionary dictionary];
    
    ///////////////////
    [self getCities];
    ////////////////////

    [self getHomeAd];
    //[self getHomeService];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (NSDictionary *)findCurrentCity:(NSArray *)arr {
    NSDictionary *city = [NSDictionary dictionary];
    for (NSDictionary *dic in arr) {
        NSNumber *isCurrent = dic[@"isCurrent"];
        if (isCurrent.boolValue) {
            city = dic;
        }
    }
    
    return city;
}

#pragma mark - Http
- (void)getCities {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate] ;
    [delegate getCities:^(NSArray *resultArray, NSError *error) {
        
        NSLog(@"getOpenCities2:%@",resultArray);
        if (!error && resultArray.count>0) {
            _cities = resultArray;
            _currentCity = [self findCurrentCity:_cities];
            
            if (_currentCity.count > 0) {
                [_servicePhoneBtn setTitle:_currentCity[@"name"] forState:UIControlStateNormal];
                [self getHomeServiceWithCityId:_currentCity[@"id"]];
            }
            else {
                [self getHomeService];
            }
        }
        else {
            NSLog(@"网络错误");
            [self getHomeService];
        }
        
    }];
}

- (void)getHomeAd {
   /* HomeService *homeService = [[HomeService alloc] init];
    
    [homeService getHomeAdWithBlock:^(NSNumber *result, NSArray *resultInfo, NSError *error) {
        if (error) {
            NSLog(@"网络错误");
        }
        else{
            if ([result integerValue] == 0) {
                _adInfos = [resultInfo mutableCopy];
                [self.tableView reloadData];
            }
            else{
                NSLog(@"resultInfo = 1");
            }
            
        }
        
    }];*/
    
    [[MZBHttpService shareInstance] getHomeAdWithBlock:^(NSArray *result, NSError *error) {
        if (error) {
            NSLog(@"网络错误");
        }
        else{
            if (result.count>0) {
                _adInfos = [result mutableCopy];
                [self.tableView reloadData];
            }
            else{
                NSLog(@"result.count = 0");
            }
            
        }

    }];

}

- (void)getHomeService {
    [[MZBHttpService shareInstance] getHomeServiceWithBlock:^(NSDictionary *result, NSError *error) {
        
        if (!error) {
            
            NSNumber *status = result[@"status"];
            
            if (status.boolValue) {
                _serviceInfos = [self getAllServiceInfosWithInfos:result[@"data"]];
                
                [self.tableView reloadData];
            }
            else {
                
                [UIFactory showAlert:result[@"message"]];
            }
        }
        else {
            
            [UIFactory showAlert:@"网路错误"];
        }
        
    }];

}

- (void)getHomeServiceWithCityId:(NSString *)cityId {
    [[MZBHttpService shareInstance] getHomeServiceWithCityId:cityId WithBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            
            NSNumber *status = result[@"status"];
            
            if (status.boolValue) {
                _serviceInfos = [self getAllServiceInfosWithInfos:result[@"data"]];
                
                [self.tableView reloadData];
            }
            else {
                
                [UIFactory showAlert:result[@"message"]];
            }
        }
        else {
            
            [UIFactory showAlert:@"网路错误"];
        }

    }];
}

#pragma mark - IBAction
- (IBAction)phoneClicked:(id)sender {
    //呼叫
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt://4000870201"]];
}

- (IBAction)cityClicked:(id)sender {
    CityListVC *cityListVC = [[CityListVC alloc] initWithNibName:@"CityListVC" bundle:nil];
    cityListVC.cities = self.cities;
    cityListVC.currentCity = self.currentCity;
    cityListVC.delegate = self;
    [self.navigationController pushViewController:cityListVC animated:YES];
}

#pragma mark - self
- (NSArray *)getAllServiceInfosWithInfos:(NSArray *)infos{
    NSMutableArray *allInfos = [infos mutableCopy];
    NSDictionary *lastDic = @{@"id":allServiceInfoID, @"name":@"全部服务"};
    [allInfos addObject:lastDic];
    
    return allInfos;
}

- (NSArray *)getBtnCellServiceInfoWithServieInfos:(NSArray *)infos andIndexPathRow:(NSInteger )row {
    
    NSMutableArray *result = [NSMutableArray array];
    
    [result addObject:infos[3*row]];
    
    if ((3*row+1) < infos.count) {
        [result addObject:infos[3*row+1]];
    }
    
    if ((3*row+2) < infos.count) {
        [result addObject:infos[3*row+2]];
    }
    
    return result;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return (_serviceInfos.count + 2) / 3;
    }
    else {
        return 0;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier1 = @"HomeAdCell_Identifier";
    static NSString *CellIdentifier2 = @"HomeBntCell_Identifier";
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {//ad
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[HomeAdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        ((HomeAdCell *)cell).adArray = _adInfos;
        
        return cell;
        
        
    }
    else if (indexPath.section == 1){//bnt
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        
        ((HomeBtnCell *)cell).cellServices = [self getBtnCellServiceInfoWithServieInfos:_serviceInfos andIndexPathRow:indexPath.row];
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
    if(indexPath.section == 0){
        return 160;
    }
    else if (indexPath.section == 1){
        return 100;
    }
    else{
        return 44;
    }
}

#pragma mark - HomeBtnCell delegate
- (void)HomeBtnCellButtonPressedWithServiceInfo:(NSDictionary *)info
{
   // UIButton *button = (UIButton *)sender;
    //MzbService *aService = [infos objectAtIndex:button.tag-1];
    
 /*   if ([aService.serviceName isEqualToString:@"地板保养"]) {
        FloorCareVC *floorCareVC = [[FloorCareVC alloc] initWithNibName:@"FloorCareVC" bundle:nil];
        floorCareVC.serviceInfo= aService;
        [self.navigationController pushViewController:floorCareVC animated:YES];
        
    }
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
    
    NSString *serviceId = info[@"id"];
    if ([serviceId isEqualToString:allServiceInfoID]) {//全部服务
        AllServiceVC *allServiceVC = [[AllServiceVC alloc] initWithNibName:@"AllServiceVC" bundle:nil];
        allServiceVC.currentCity = self.currentCity;
        [self.navigationController pushViewController:allServiceVC animated:YES];

    }
    else if ([serviceId isEqualToString:@"18181630679"]) {//新居开荒
        NewHouseCareVC *newHouseCareVC = [[NewHouseCareVC alloc] initWithNibName:@"NewHouseCareVC" bundle:nil];
        newHouseCareVC.serviceInfo = info;
        [self.navigationController pushViewController:newHouseCareVC animated:YES];

    }
    else {
        FloorCareVC *floorCareVC = [[FloorCareVC alloc] initWithNibName:@"FloorCareVC" bundle:nil];
        floorCareVC.serviceInfo= info;
        [self.navigationController pushViewController:floorCareVC animated:YES];

    }
    
}

#pragma mark - CityListVC delegate
- (void)cityListVCChangedCity:(NSDictionary *)city {
    self.currentCity = city;
    [_servicePhoneBtn setTitle:_currentCity[@"name"] forState:UIControlStateNormal];
    [self getHomeServiceWithCityId:_currentCity[@"id"]];
}

@end
