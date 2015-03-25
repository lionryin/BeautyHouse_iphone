//
//  AllServiceVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AllServiceVC.h"
#import "AllServiceCell.h"
#import "HomeService.h"

#define AllServiceCellID @"AllServiceCellID"

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
    
    HomeService *homeService = [[HomeService alloc] init];
    [homeService getAllServiceWithBlock:^(NSString *result, NSArray *resultInfo, NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
            _tableList = [resultInfo mutableCopy];
            [self.tableView reloadData];
        }

    }];

    
   
}

- (void)initMainUI{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 144, self.view.frame.size.width, self.view.frame.size.height -144) style:UITableViewStyleGrouped];
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
    MzbService *aService = [_tableList objectAtIndex:section];
    
    return (aService.childServiceCategoryList.count+1)/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UINib *nib = [UINib nibWithNibName:@"AllServiceCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:AllServiceCellID];
    
    AllServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:AllServiceCellID forIndexPath:indexPath];
    
    MzbService *ParentService = [_tableList objectAtIndex:indexPath.section];
    NSArray *childArray = ParentService.childServiceCategoryList;
    
    
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




@end
