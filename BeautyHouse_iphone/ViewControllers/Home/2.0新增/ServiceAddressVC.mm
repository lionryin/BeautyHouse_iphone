//
//  ServiceAddressVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/6/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ServiceAddressVC.h"
#import "SearchListTableVC.h"
#import <BaiduMapAPI/BMapKit.h>
#import "MZBHttpService.h"

@interface ServiceAddressVC ()<SearchListTableVCDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, BMKMapViewDelegate, BMKLocationServiceDelegate, BMKPoiSearchDelegate, BMKSuggestionSearchDelegate, BMKGeoCodeSearchDelegate>

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *detailAddressView;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressField;

@property (strong, nonatomic) NSMutableArray *tableList;
@property (strong, nonatomic) NSMutableArray *addressList;//历史地址列表
@property (nonatomic) BOOL isHaveAddressList;//是否有历史地址

@property (strong, nonatomic) SearchListTableVC *ddList;
@property (strong, nonatomic) NSString *searchStr;

///定位
@property (strong, nonatomic) BMKLocationService *locService;

//POI检索
@property (strong, nonatomic) BMKPoiSearch *searcher;

//建议检索
@property (strong, nonatomic) BMKSuggestionSearch *suggestionSearch;
@property (strong, nonatomic) NSString *cityName;

//地理编码
@property (strong, nonatomic) BMKGeoCodeSearch *geoCodeSearch;


@property (strong, nonatomic) MBProgressHUD *hud;


@end

@implementation ServiceAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"添加服务地址";
    
    _tableList = [NSMutableArray array];
    _addressList = [NSMutableArray array];
    _isHaveAddressList = NO;
    [self getAddressList];
    
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_hud];
    
    /////
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(self.view.frame.size.width-90, 2, 40, 25)];
    //[rightBtn setImage:[UIImage imageNamed:@"selected_Address.png"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    /////
    _ddList = [[SearchListTableVC alloc] initWithStyle:UITableViewStylePlain];
    _ddList.delegate = self;
    [_ddList.view setFrame:CGRectMake(0, 108, self.view.frame.size.width, 0)];
    [self.view addSubview:_ddList.view];
    
    self.detailAddressView.hidden = YES;
    
    ////////////////////////////////////////////////////定位
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
   
    //启动LocationService
    [_locService startUserLocationService];
    
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.zoomLevel = 15;
    
    ///POI检索
    _searcher =[[BMKPoiSearch alloc]init];
    
    ///建议检索
    _suggestionSearch =[[BMKSuggestionSearch alloc]init];
    self.cityName = @"武汉";
    
    ///
    _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    //_mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
     _searcher.delegate = self;
    _suggestionSearch.delegate = self;
    _geoCodeSearch.delegate = self;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
     _searcher.delegate = nil;
    _suggestionSearch.delegate = nil;
    _geoCodeSearch.delegate = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 添加一个PointAnnotation
    /*BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.title = @"这里是北京";
    [_mapView addAnnotation:annotation];*/
}

#pragma mark - action
- (void)rightBtnAction {
    if (_searchBar.text.length <= 0) {
        [UIFactory showAlert:@"小区名不能为空"];
    }
    else if (_detailAddressField.text.length <= 0) {
        [UIFactory showAlert:@"详细地址不能为空"];
    }
    else {
        [self saveAddressWithName:_searchBar.text andDetail:_detailAddressField.text];
    }
}

#pragma mark - http
- (void)getAddressList {
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSString *token = [userDic objectForKey:UserToken];

    [[MZBHttpService shareInstance] getAddressListWithUserId:userId andToken:token WithBlock:^(NSDictionary *result, NSError *error) {
        
        if (!error) {
            NSNumber *status = result[@"status"];
            if (status.boolValue) {
                _addressList = [result[@"data"] mutableCopy];
                if (_addressList.count>0) {
                    _isHaveAddressList = YES;
                    [self.tableView reloadData];
                }
            }
            else {
                NSLog(@"errorMSg:%@",result[@"message"]);
            }
        }
        else {
            NSLog(@"error:%@",[error description]);
        }
    }];
}

- (void)saveAddressWithName:(NSString *)name andDetail:(NSString *)detail {
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSString *token = [userDic objectForKey:UserToken];
    
    NSDictionary *dic = @{@"name":name,@"detail":detail,@"longitude":[NSNumber numberWithFloat:_mapView.centerCoordinate.longitude],@"latitude":[NSNumber numberWithFloat:_mapView.centerCoordinate.latitude]};
    NSData *body = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];

    //MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    //[self.view addSubview:hud];
    //hud.labelText = @"保存中...";
    [_hud show:YES];
    [[MZBHttpService shareInstance] saveAddressWithUserId:userId andToken:token andBody:body WithBlock:^(NSDictionary *result, NSError *error) {
        
        [_hud hide:YES];
        
        if ([self.delegate respondsToSelector:@selector(ServiceAddressVCSelectedServiceAddress:andDetail:)]) {
            [self.delegate ServiceAddressVCSelectedServiceAddress:name andDetail:detail];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        if (!error) {
            NSNumber *status = result[@"status"];
            if (status.boolValue) {
                NSLog(@"保存成功");
            }
        }
    }];
}

- (void)deleteAddressWithAddress:(NSDictionary *)address {
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSString *token = [userDic objectForKey:UserToken];
    
     NSNumber *addressId = address[@"id"];
    
    [_hud show:YES];
    [[MZBHttpService shareInstance] deleteAddressWithUserId:userId andToken:token andAddressId:addressId.integerValue WithBlock:^(NSDictionary *result, NSError *error) {
        [_hud hide:YES];
        
        if (!error) {
            NSNumber *status = result[@"status"];
            if (status.boolValue) {
                [_addressList removeObject:address];
                [self.tableView reloadData];
                [UIFactory showAlert:@"删除成功"];
            }
            else {
                [UIFactory showAlert:@"删除失败"];
            }
        }
        else {
           // NSLog(@"error:%@",[error description]);
            [UIFactory showAlert:@"网络错误"];
        }
        
    }];
}

#pragma mark - myself

- (void)setDDListHidden:(BOOL)hidden {
    NSInteger height = hidden ? 0 : 180;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    [_ddList.view setFrame:CGRectMake(0, 108, self.view.frame.size.width, height)];
    [UIView commitAnimations];
}
#pragma mark -
#pragma mark SearchListTableVCDelegate
- (void)passValue:(NSString *)value{
    if (value) {
        _searchBar.text = value;
        [self searchBarSearchButtonClicked:_searchBar];
    }
    else {
        
    }
}

#pragma mark -
#pragma mark SearchBar Delegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] != 0) {
        //_ddList.searchText = searchText;
        
        //[_ddList updateData];
        
        BMKSuggestionSearchOption* option = [[BMKSuggestionSearchOption alloc] init];
        option.cityname = self.cityName;
        option.keyword  = searchText;
        BOOL flag = [_suggestionSearch suggestionSearch:option];
        if(flag)
        {
            NSLog(@"建议检索发送成功");
        }
        else
        {
            NSLog(@"建议检索发送失败");
        }
        
        [self.view bringSubviewToFront:_ddList.view];
        [self setDDListHidden:NO];
    }
    else {
        [self setDDListHidden:YES];
    }
}

//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    searchBar.text = @"";
//}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    if (![_searchBar.text isEqualToString:@""]) {
        _detailAddressView.hidden = NO;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self setDDListHidden:YES];
    self.searchStr = searchBar.text;
    [searchBar resignFirstResponder];
    
    ///定位
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= self.cityName;
    geoCodeSearchOption.address = self.searchStr;
    BOOL flag = [_geoCodeSearch geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;    
}

#pragma mark - UITableView delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isHaveAddressList) {
        return _addressList.count;
    }
    else {
        return _tableList.count;
    }
    
}
- (void)btnClicked:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil)
    {
        [self tableView:_tableView accessoryButtonTappedForRowWithIndexPath : indexPath];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"ServiceAddressVCIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Identifier];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
        [cell.detailTextLabel setTextColor:[UIColor darkGrayColor]];
        
        //UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width-50, 7, 30, 30)];
        //imgView.image = [UIImage imageNamed:@"deleteAddress.png"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(cell.frame.size.width-50, 0, 44, 44)];
        [button addTarget:self action:@selector(btnClicked:event:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"deleteAddress.png"] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(7, 7, 7, 7)];
        
        cell.accessoryView = button;
    
    }
    
    if (_isHaveAddressList) {
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.accessoryView.hidden = NO;
        NSDictionary *dic = _addressList[indexPath.row];
        cell.textLabel.text = dic[@"name"];
        cell.detailTextLabel.text = dic[@"detail"];
        
        
    }
    else {
        cell.accessoryView.hidden = YES;
        BMKPoiInfo *info = [_tableList objectAtIndex:indexPath.row];
        cell.textLabel.text = info.name;
        cell.detailTextLabel.text = info.address;

    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (_isHaveAddressList) {
        return @"从历史地址中选择";
    }
    else {
        return @"附近小区";
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"accessoryButtonTapped");
    
     NSDictionary *dic = _addressList[indexPath.row];
    [self deleteAddressWithAddress:dic];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_isHaveAddressList) {
         NSDictionary *dic = _addressList[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(ServiceAddressVCSelectedServiceAddress:andDetail:)]) {
            
            [self.delegate ServiceAddressVCSelectedServiceAddress:dic[@"name"] andDetail:dic[@"detail"]];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        BMKPoiInfo *info = [_tableList objectAtIndex:indexPath.row];
        _searchBar.text = info.name;
        
        if (_detailAddressView.hidden) {
            _detailAddressView.hidden = NO;
        }

    }
    
    
}

#pragma mark - LocationService delegate

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
   // NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //[_locService stopUserLocationService];
    _mapView.centerCoordinate = userLocation.location.coordinate;
    [_mapView updateLocationData:userLocation];
    _mapView.delegate = self;
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    // 添加一个PointAnnotation
    //BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    //CLLocationCoordinate2D coor = userLocation.location.coordinate;;
     //coor.latitude = userLocation.location.coordinate.latitude;
     //coor.longitude = userLocation.location.coordinate.longitude;
     //annotation.coordinate = userLocation.location.coordinate;
     //annotation.title = @"这里是北京";
     //[_mapView addAnnotation:annotation];
    
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isRotateAngleValid = true;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    displayParam.locationViewImgName= @"icon";//定位图标名称
    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [_mapView updateLocationViewWithParam:displayParam];
    
    ///定位图标
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_gcoding.png"]];
    imageView.center = [_mapView convertCoordinate:userLocation.location.coordinate toPointToView:self.view];
    [self.view addSubview:imageView];
    
  /*  ///周边检索
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.location = userLocation.location.coordinate;
    option.radius = 1000;
    option.keyword = @"小区";
    BOOL flag = [_searcher poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"1周边检索发送成功");
    }
    else
    {
        NSLog(@"1周边检索发送失败");
    }*/
}



#pragma mark - MapView delegate
- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus *)status {
    //NSLog(@"status:%f\t%f",status.targetGeoPt.latitude,status.targetGeoPt.longitude);
    ///周边检索
    //发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.location = status.targetGeoPt;
    option.radius = 1000;
    option.keyword = @"小区";
    BOOL flag = [_searcher poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"2周边检索发送成功");
    }
    else
    {
        NSLog(@"2周边检索发送失败");
    }

}

#pragma mark - Poi Search Delegate
//实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSLog(@"poi:%@",poiResultList.poiInfoList);
        for(BMKPoiInfo *info in poiResultList.poiInfoList) {
            NSLog(@"name:%@ \n address:%@",info.name, info.address);
        }
        _tableList = [poiResultList.poiInfoList mutableCopy];
        [self.tableView reloadData];
        
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果：%u",error);
    }
}


#pragma mark - suggestionSearch delegate
//实现Delegate处理回调结果
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
//        for (NSString *str in result.keyList) {
//            NSLog(@"keyList:%@",str);
//        }
        _ddList.resultList = [result.keyList mutableCopy];
        [_ddList updateData];
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

#pragma mark - geoCodeSearch delegate
//实现Deleage处理回调结果
//接收正向编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        
        _mapView.centerCoordinate = result.location;
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

@end
