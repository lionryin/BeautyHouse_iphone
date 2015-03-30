//
//  ChooseAddressVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ChooseAddressVC.h"
#import "ChooseAddressCell.h"
#import "AddAddressVC.h"
#import "MZBWebService.h"

#define ChooseAddressCellID  @"ChooseAddressCellID"
#define AddAddressCellID  @"AddAddressCellID"

@interface ChooseAddressVC ()<UITableViewDataSource, UITableViewDelegate, AddAddressVCDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableList;

@end

@implementation ChooseAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    [self initMainUI];
    self.title = @"服务地址";
    
    NSArray *addressArray = [[NSUserDefaults standardUserDefaults] arrayForKey:AddressGlobalKey];
    self.tableList = [addressArray mutableCopy];
}

- (void)initMainUI{
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-0) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        
        return _tableList.count;
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UINib *nib = [UINib nibWithNibName:@"ChooseAddressCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ChooseAddressCellID];
        
        ChooseAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseAddressCellID forIndexPath:indexPath];
        
        cell.addressDic = [self.tableList objectAtIndex:indexPath.row];
        
        return cell;
  
    }
    else{
        UINib *nib = [UINib nibWithNibName:@"AddAddressCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:AddAddressCellID];
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddAddressCellID forIndexPath:indexPath];
        
        return cell;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.tableList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [[NSUserDefaults standardUserDefaults] setValue:self.tableList forKey:AddressGlobalKey];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        [self.delegate chooseAddressVCCellSelected:[self.tableList objectAtIndex:indexPath.row]];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else if (indexPath.section == 1) {
        AddAddressVC *addAddressVC = [[AddAddressVC alloc] initWithNibName:@"AddAddressVC" bundle:nil];
        addAddressVC.delegate = self;
        [self.navigationController pushViewController:addAddressVC animated:YES];
    }
}

#pragma mark - AddAddressVC delegate

- (void)AddAddressVCAddAddressQuyu:(NSString *)quyu andXiaoqu:(NSString *)xiaoqu andDetailAddress:(NSString *)detailAddress{
    NSString *xq = [NSString stringWithFormat:@"%@ %@",quyu,xiaoqu];
    
    NSDictionary *dic = @{@"xq":xq, @"detail":detailAddress};
    
    [self.tableList addObject:dic];
    [self.tableView reloadData];
    
    [[NSUserDefaults standardUserDefaults] setValue:self.tableList forKey:AddressGlobalKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}



@end
