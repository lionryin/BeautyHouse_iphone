//
//  MyOrderVC.m
//  BeautyHouse
//
//  Created by Roy on 15/3/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyOrderVC.h"
#import "MyOrderTVC.h"
#import "HomeService.h"
#import "MJRefresh.h"

#define MyOrderCellID @"MyOrderCellID"



@interface MyOrderVC ()<UITableViewDataSource,UITableViewDelegate,MyOrderTVCDelegate>

@property (nonatomic,strong)UISegmentedControl *segCtrl;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *orderList;
@property (strong, nonatomic) NSMutableArray *currentOrderList;
@property (strong, nonatomic) NSMutableArray *historyOrderList;

@property (nonatomic) NSInteger currentOrderPageIndex;
@property (nonatomic) NSInteger historyOrderPageIndex;

@end

@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainUI];
    // Do any additional setup after loading the view.
    
    _currentOrderPageIndex = 0;
    _historyOrderPageIndex = 0;
    
    _currentOrderList = [[NSMutableArray alloc] init];
    _historyOrderList = [[NSMutableArray alloc] init];
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
#pragma mark - MJRefresh
/**
 *  集成刷新控件
 */
- (void)setupRefresh:(NSString *)dateKey
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    // dateKey用于存储刷新时间，可以保证不同界面拥有不同的刷新时间
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:dateKey];
//#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.tableView.headerRefreshingText = @"正在努力帮您刷新中,不客气";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在努力帮您加载中,不客气";
}

- (void)headerRereshing
{
    if(_segCtrl.selectedSegmentIndex == 0){
        [self getPageByOrderInfo:1 andWithBlock:^(NSArray *orderResults) {
            self.currentOrderList = [orderResults mutableCopy];
            self.orderList = self.currentOrderList;
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        }];

    }
    else{
        [self getPageByOrderInfo:2 andWithBlock:^(NSArray *orderResults) {
            _historyOrderList = [orderResults mutableCopy];
            self.orderList = self.historyOrderList;
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        }];

    }
    // 刷新表格
    //[self.tableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    //[self.tableView headerEndRefreshing];
    
}

- (void)footerRereshing
{
       // 刷新表格
    [self.tableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
    
}


#pragma mark - order

- (void)getPageByOrderInfo:(NSInteger )checkOrderInfo andWithBlock:(void (^)(NSArray *orderResults))block;
{
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSLog(@"userId:%@",userId);

    NSString *param = [NSString stringWithFormat:@"{\"proc\":{\"registeredUserId\":\"%@\",\"checkOrderInfo\":%li},\"order1\":\"orderDateTime\",\"sort1\":\"desc\",\"pageIndex\":0,\"pageSize\":5}",userId,checkOrderInfo];
    
    HomeService *homeService = [[HomeService alloc] init];
    [homeService getPageByOrderInfoWithParam:param andWithBlock:^(NSNumber *result, NSDictionary *resultInfo, NSError *error) {
        if (!error) {
            if ([result integerValue] == 0) {
                NSArray *orderArray = [resultInfo objectForKey:@"data"];
                NSMutableArray *tempOrderList = [[NSMutableArray alloc] init];
                for (int i = 0; i<orderArray.count; i++) {
                    NSDictionary *tempDic = [orderArray objectAtIndex:i];
                    MyOrderVO *order = [[MyOrderVO alloc] init];
                    order.orderID = [tempDic objectForKey:@"id"];
                    order.title = [[tempDic objectForKey:@"serviceCategory"] objectForKey:@"serviceName"];
                    order.time = [tempDic objectForKey:@"orderDateTime"];
                    order.address = [NSString stringWithFormat:@"%@ %@",[[tempDic objectForKey:@"serviceAddress"] objectForKey:@"cellName"],[[tempDic objectForKey:@"serviceAddress"] objectForKey:@"detailAddress"]];
                    order.status = [[tempDic objectForKey:@"orderStatue"] objectForKey:@"keyName"];
                    order.orderType = checkOrderInfo == 1 ? kOrderTypeCurrent : kOrderTypeHistory;
                    [tempOrderList addObject:order];
                }
                block(tempOrderList);
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发生未知错误，请重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
    }];
}


- (void)getCurrentOrderList{
    //[self.orderList removeAllObjects];
    
   /* MyOrderVO *orderVO = [[MyOrderVO alloc]init];
    orderVO.title = @"请保姆";
    orderVO.time = @"2015-03-22 17:30:25";
    orderVO.address = @"光谷大道120号";//orderVO.address;
    orderVO.status = @"已分配";
    orderVO.orderType = kOrderTypeCurrent;
    [self.orderList addObject:orderVO];
    [self.orderList addObject:orderVO];
    [self.orderList addObject:orderVO];*/
    if (self.currentOrderList.count == 0) {
        [self setupRefresh:@"current"];
    }
    else{
        self.orderList = self.currentOrderList;
        [self.tableView reloadData];
    }
}


- (void)getHistoryOrderList{
    //[self.orderList removeAllObjects];
    
    /*MyOrderVO *orderVO = [[MyOrderVO alloc]init];
    orderVO.title = @"地板保养";
    orderVO.time = @"2015-03-22 17:30:25";
    orderVO.address = @"关山大道特1号";//orderVO.address;
    orderVO.status = @"退单";
    orderVO.orderType = kOrderTypeHistory;
    
    [self.orderList addObject:orderVO];*/
    if (self.historyOrderList.count == 0) {
        [self setupRefresh:@"history"];
    }
    else{
        self.orderList = self.historyOrderList;
        [self.tableView reloadData];
    }
    
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
    
    return 195;
    
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
