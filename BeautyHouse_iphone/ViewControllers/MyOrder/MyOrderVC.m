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
#import "OrderDetailVC.h"
#import "OrderPayVC.h"

#define MyOrderCellID @"MyOrderCellID"



@interface MyOrderVC ()<UITableViewDataSource,UITableViewDelegate,MyOrderTVCDelegate,UIAlertViewDelegate,OrderPayVCDelegate>

@property (nonatomic,strong)UISegmentedControl *segCtrl;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *orderList;
@property (strong, nonatomic) NSMutableArray *currentOrderList;
@property (strong, nonatomic) NSMutableArray *historyOrderList;

@property (nonatomic) NSInteger currentOrderPageIndex;
@property (nonatomic) NSInteger historyOrderPageIndex;
@property (nonatomic) NSInteger currentOrderTotalPage;
@property (nonatomic) NSInteger historyOrderTotalPage;

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMainUI];
    // Do any additional setup after loading the view.
    
    _currentOrderPageIndex = 0;
    _historyOrderPageIndex = 0;
    _currentOrderTotalPage = 0;
    _historyOrderTotalPage = 0;
    
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
        self.currentOrderPageIndex = 0;
        [self getPageByOrderInfo:1 andPageIndex:self.currentOrderPageIndex andWithBlock:^(NSArray *orderResults,NSInteger totalPage) {
            self.currentOrderPageIndex++;
            self.currentOrderTotalPage = totalPage;
            self.currentOrderList = [orderResults mutableCopy];
            self.orderList = self.currentOrderList;
            [self.tableView reloadData];
            [self.tableView headerEndRefreshing];
        }];

    }
    else{
        self.historyOrderPageIndex = 0;
        [self getPageByOrderInfo:2 andPageIndex:self.historyOrderPageIndex andWithBlock:^(NSArray *orderResults,NSInteger totalPage) {
            self.historyOrderPageIndex++;
            self.historyOrderTotalPage = totalPage;
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
    if(_segCtrl.selectedSegmentIndex == 0){
        if (_currentOrderPageIndex < _currentOrderTotalPage) {
            [self getPageByOrderInfo:1 andPageIndex:_currentOrderPageIndex andWithBlock:^(NSArray *orderResults, NSInteger totalPage) {
                self.currentOrderPageIndex++;
                self.currentOrderTotalPage = totalPage;
                [self.currentOrderList addObjectsFromArray:orderResults ];
                self.orderList = self.currentOrderList;
                [self.tableView reloadData];
                [self.tableView footerEndRefreshing];
            }];

        }
        
        
    }
    else{
        if (_historyOrderPageIndex < _historyOrderTotalPage) {
            [self getPageByOrderInfo:2 andPageIndex:_historyOrderPageIndex andWithBlock:^(NSArray *orderResults, NSInteger totalPage) {
                self.historyOrderPageIndex++;
                self.historyOrderTotalPage = totalPage;
                [self.historyOrderList addObjectsFromArray:orderResults];
                self.orderList = self.historyOrderList;
                [self.tableView reloadData];
                [self.tableView footerEndRefreshing];
            }];
        }
        
    }
       // 刷新表格
    [self.tableView reloadData];
    
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
    
}


#pragma mark - order

- (void)getPageByOrderInfo:(NSInteger )checkOrderInfo andPageIndex:(NSInteger)index andWithBlock:(void (^)(NSArray *orderResults ,NSInteger totalPage))block;
{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSLog(@"userId:%@",userId);
    
    NSString *param = [NSString stringWithFormat:@"{\"proc\":{\"registeredUserId\":\"%@\",\"checkOrderInfo\":%li},\"order1\":\"orderDateTime\",\"sort1\":\"desc\",\"pageIndex\":%li,\"pageSize\":5}",userId,checkOrderInfo,index];
    
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
                    order.statusID = [[tempDic objectForKey:@"orderStatue"] objectForKey:@"id"];
                    
                    NSDictionary *auntDic = [tempDic objectForKey:@"auntInfo"];
                    
                    NSLog(@"%@",auntDic);
                    
                    if ([auntDic isKindOfClass:[NSDictionary class]]) {
                        order.auntName = [auntDic objectForKey:@"auntName"];
                        order.auntLevel = [auntDic objectForKey:@"level"];
                        order.auntPhone = [auntDic objectForKey:@"phone"];
                    }
                    
                    order.orderType = checkOrderInfo == 1 ? kOrderTypeCurrent : kOrderTypeHistory;
                    [tempOrderList addObject:order];
                }
                NSNumber *totalNum = [resultInfo objectForKey:@"totalPage"];
                block(tempOrderList,[totalNum integerValue]);
            }
            else{
                 [self.tableView headerEndRefreshing];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发生未知错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else{
             [self.tableView headerEndRefreshing];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];

        }
    }];
}


- (void)getCurrentOrderList{
    //[self.orderList removeAllObjects];
    
  
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
    cell.myOrderVO = orderVO;
    //[cell updateMyOrderTVC];
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     MyOrderVO *orderVO = [self.orderList objectAtIndex:indexPath.section];
    if ([orderVO.statusID integerValue] == 32 || [orderVO.statusID integerValue] == 78) {
        return 195;
    }
    else{
        return 60+195;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderDetailVC *orderDetailVC = [[OrderDetailVC alloc] initWithNibName:@"OrderDetailVC" bundle:nil];
    orderDetailVC.orderVO = [self.orderList objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - MyOrderTVC Delegate

- (void)complaintBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell{
    
}


- (void)cancelBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell{//取消成功
    [self setupRefresh:@"current"];
}

- (void)zhifuBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell{
    OrderPayVC *orderPayVC = [[OrderPayVC alloc] initWithNibName:@"OrderPayVC" bundle:nil];
    orderPayVC.orderVO = cell.myOrderVO;
    orderPayVC.delegate = self;
    [self.navigationController pushViewController:orderPayVC animated:YES];
}

#pragma mark - orderPayVC delegate
- (void)orderPayVCPaySuccess{
    [self setupRefresh:@"current"];
}

@end
