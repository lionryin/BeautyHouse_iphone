//
//  AppDelegate.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AppDelegate.h"
#import "Common.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "LoginVC.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "Constant.h"

#import <BaiduMapAPI/BMapKit.h>
#import "UIFactory.h"

#import "UserGuidVC.h"

/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
NSString * const WXAppId = @"wx038e41f97fa55586";

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppKey = @"4ad2595522b5ff33d82a886764a68d82";

/**
 * 微信开放平台和商户约定的密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppSecret = @"4ad2595522b5ff33d82a886764a68d82";

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXPartnerKey = @"4ad2595522b5ff33d82a886764a68d82";

/**
 *  微信公众平台商户模块生成的ID
 */
NSString * const WXPartnerId = @"1234641402";

@interface AppDelegate ()<BMKGeneralDelegate, BMKLocationServiceDelegate>

@property (strong, nonatomic) BMKMapManager *mapManager;
///定位
//@property (strong, nonatomic) BMKLocationService *locService;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];

    
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:self];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    ((UITabBarController *)self.window.rootViewController).delegate = self;
    self.window.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    if (!userDic) {
        //对象：用户是否已经登陆,0未登陆，1登陆；用户名
        userDic = @{UserIsLoginKey:@"0",UserPhoneNumberKey:@"",UserLoginId:@""};
        
        [[NSUserDefaults standardUserDefaults] setValue:userDic forKey:UserGlobalKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSArray *addressArray = [[NSUserDefaults standardUserDefaults] arrayForKey:AddressGlobalKey];
    if (!addressArray) {
        addressArray = [[NSArray alloc] init];
        [[NSUserDefaults standardUserDefaults] setValue:addressArray forKey:AddressGlobalKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    //微信分享
    [UMSocialData setAppKey:@"54f7f5d2fd98c52b230005a4"];
    [UMSocialWechatHandler setWXAppId:@"wx038e41f97fa55586" appSecret:@"4ad2595522b5ff33d82a886764a68d82" url:@"http://www.mrchabo.com/"];
    //微信支付
    [WXApi registerApp:WXAppId];
    
    //////百度地图
    _mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:BAIDU_MAP_KEY generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    ///百度地图定位
    //设置定位精确度，默认：kCLLocationAccuracyBest
    //[BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    

    //初始化BMKLocationService
   // _locService = [[BMKLocationService alloc]init];
   // _locService.delegate = self;
    //启动LocationService
    //[_locService startUserLocationService];
    
    /**
     *  ///////////////////////////////////////////////////用户引导页
     */
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"第一次启动");
        //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
        UserGuidVC *vc = [[UserGuidVC alloc] init];
        
        self.window.rootViewController = vc;
    }
    else
    {
        NSLog(@"不是第一次启动");
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController * vc = [story instantiateViewControllerWithIdentifier:@"MainTabBarController"];
        self.window.rootViewController = vc;
    }

    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - tabBarController delegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if ([viewController.tabBarItem.title isEqualToString:@"订单"]) {
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
        NSString *userIsLogin = [userDic objectForKey:UserIsLoginKey];
        
        if ([userIsLogin isEqualToString:@"0"]) {//未登陆
             LoginVC *loginVC = [[LoginVC alloc]init];
            loginVC.isOrderFrom = YES;
             UINavigationController *loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
             [tabBarController presentViewController:loginNC animated:YES completion:nil];
            
            return NO;
        }

    }
    
    return YES;
}

#pragma mark - wx delegate

- (void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]) {
        
        NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle
                                                        message:strMsg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:HUDDismissNotification object:nil userInfo:nil];
    }

}

#pragma mark - LocationService delegate

//实现相关delegate 处理位置信息更新
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
   // [_locService stopUserLocationService];
    //_locService.delegate = nil;
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    /*CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        //NSLog(@"placemarks:%i",placemarks.count);
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            
             NSLog(@"地址locality:%@",placeMark.locality);//市
        }
        
    }];*/
    
    //_cities = [NSArray array];
    
    
    //[[MZBHttpService shareInstance] getOpenCitiesWithLongitude:userLocation.location.coordinate.longitude andLatitude:userLocation.location.coordinate.latitude WithBlock:_citiesBlock];
    
}

- (void)didFailToLocateUserWithError:(NSError *)error {
    //NSLog(@"%@",[error description]);
    [UIFactory showAlert:@"定位失败"];
    self.citiesBlock(nil, error);
}

- (void)getCities:(CitiesBlock)block {
   self.citiesBlock = block;
}

@end
