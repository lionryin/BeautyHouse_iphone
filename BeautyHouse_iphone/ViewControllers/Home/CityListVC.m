//
//  CityListVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CityListVC.h"
#import "CityListCell.h"
#import "Common.h"

@interface CityListVC ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"选择城市";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView datasouce delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cities.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cityListCell";
    
    [tableView registerNib:[UINib nibWithNibName:@"CityListCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    CityListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSDictionary *city = _cities[indexPath.row];
    cell.cityName.text = city[@"name"];
    
    if ([city[@"id"] isEqualToString:self.currentCity[@"id"]]) {
        cell.selectedImageView.image = [UIImage imageNamed:@"small_hook.png"];
    }
    else {
        cell.selectedImageView.image = [UIImage imageNamed:@""];
    }
    
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"城市列表";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *city = _cities[indexPath.row];
    
    /////本地存储
    NSDictionary *selectedCityDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:CityGlobalKey];
    NSMutableDictionary *mutDic = [selectedCityDic mutableCopy];
    
    [mutDic setObject:city[@"id"] forKey:CityIdOfSelected];
    [mutDic setObject:city[@"name"] forKey:CityNameOfSelected];
    
    [[NSUserDefaults standardUserDefaults] setValue:mutDic forKey:CityGlobalKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    ////////////
    
    if ([city[@"id"] isEqualToString:self.currentCity[@"id"]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        self.currentCity = city;
        if ([self.delegate respondsToSelector:@selector(cityListVCChangedCity:)]) {
            [self.delegate cityListVCChangedCity:city];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
