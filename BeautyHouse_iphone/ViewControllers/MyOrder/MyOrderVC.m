//
//  MyOrderVC.m
//  BeautyHouse
//
//  Created by Roy on 15/3/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyOrderTVC.h"

#define MyOrderCellID @"MyOrderCellID"



@interface MyOrderVC ()<UITableViewDataSource,UITableViewDelegate,MyOrderTVCDelegate>

@property (nonatomic,strong)UISegmentedControl *segCtrl;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *orderList;
@end

@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainUI];
    // Do any additional setup after loading the view.
}


- (void)initMainUI{
    
    self.title = @"订单";
    
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    
    self.segCtrl = [[UISegmentedControl alloc]initWithItems:@[@"当前订单",@"历史订单"]];
    [self.segCtrl setFrame:CGRectMake(10, 70, self.view.frame.size.width-20, 40)];
    self.segCtrl.selectedSegmentIndex = 0;
    self.segCtrl.tintColor =[UIColor orangeColor];
    [self.segCtrl addTarget:self action:@selector(segCtrlClicked:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segCtrl];
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height -120-30) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[MyOrderTVC class] forCellReuseIdentifier:MyOrderCellID];
    //self.tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableView];
    
    //
    if (self.orderList == nil) {
        self.orderList = [[NSMutableArray alloc]init];
    }
    
    [self getCurrentOrderList];
    
}


- (void)getCurrentOrderList{
    [self.orderList removeAllObjects];
    
    MyOrderVO *orderVO = [[MyOrderVO alloc]init];
    orderVO.title = @"请保姆";
    orderVO.time = @"2015-03-22 17:30:25";
    orderVO.address = @"光谷大道120号";//orderVO.address;
    orderVO.status = @"已分配";
    orderVO.orderType = kOrderTypeCurrent;
    [self.orderList addObject:orderVO];
    [self.orderList addObject:orderVO];
    [self.orderList addObject:orderVO];

    [self.tableView reloadData];
}


- (void)getHistoryOrderList{
    [self.orderList removeAllObjects];
    
    MyOrderVO *orderVO = [[MyOrderVO alloc]init];
    orderVO.title = @"地板保养";
    orderVO.time = @"2015-03-22 17:30:25";
    orderVO.address = @"关山大道特1号";//orderVO.address;
    orderVO.status = @"退单";
    orderVO.orderType = kOrderTypeHistory;
    
    [self.orderList addObject:orderVO];
    
    [self.tableView reloadData];
}



- (void)segCtrlClicked:(id)sender{
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    NSInteger index = seg.selectedSegmentIndex;
    
    switch (index) {
        case 0:{
            
            [self getCurrentOrderList];
            
            break;
        }
            
            
        case 1:{
         
            [self getHistoryOrderList];
            
            break;
        }
            
            
        default:
            break;
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.orderList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyOrderTVC *cell = [tableView dequeueReusableCellWithIdentifier:MyOrderCellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellEdge = 10;
    
    MyOrderVO *orderVO = [self.orderList objectAtIndex:indexPath.section];
    
    [cell updateMyOrderTVC:orderVO];
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 175;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MyOrderTVC Delegate

- (void)complaintBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell{
    
}


- (void)cancelBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell{
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
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
