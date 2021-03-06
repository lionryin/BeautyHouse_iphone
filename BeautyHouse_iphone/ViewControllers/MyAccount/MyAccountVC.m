//
//  MyAccountVC.m
//  BeautyHouse
//
//  Created by Roy on 15/3/22.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyAccountVC.h"
#import "MyAccountTVC.h"

#import "GoldenIconActivityVC.h"
#import "AccountDetailVC.h"
#import "ShareToFriendsVC.h"
#import "FeedBackVC.h"
#import "AvailableCitiesVC.h"
#import "MoreSettingVC.h"

#import "LoginVC.h"
#import "UMSocial.h"
#import "MBProgressHUD.h"


//#define ShareText @"这是要分享的文字，可以在这里自定义"

@interface MyAccountVC ()<UMSocialUIDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic, strong) UIButton *exitBtn;
@property (nonatomic,strong)UILabel *userPhoneNumber;
@property (strong, nonatomic) MBProgressHUD        * progresshud;


@end

@implementation MyAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateHeader) name:MZB_NOTE_LOGIN_OK object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateHeader) name:MZB_NOTE_EXIT_OK object:nil];
    
    _progresshud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_progresshud];
    [_progresshud hide:YES];


    [self initMainUI];
    [self updateHeader];
    
}

- (BOOL)isLoginOK{
    BOOL loginOK = NO;
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    NSString  *flag = [userDic objectForKey:UserIsLoginKey];
    
    if ([flag isEqualToString:@"1"]) {
        loginOK = YES;
    }else{
        loginOK = NO;
    }
    
    return loginOK;
}

- (NSString *)getUserPhoneNumber{
    NSString *phoneStr = nil;
    
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    phoneStr = [userDic objectForKey:UserPhoneNumberKey];
    
    return phoneStr;
}



- (void)updateHeader{
    if ([self isLoginOK]) {
        self.userPhoneNumber.hidden = NO;
        self.loginBtn.hidden = YES;
        
        self.userPhoneNumber.text = [self getUserPhoneNumber];
        
        _exitBtn.hidden = NO;
        
    }else{
        self.userPhoneNumber.hidden = YES;
        self.loginBtn.hidden = NO;
        
        _exitBtn.hidden = YES;
    }
    
}


- (void)initMainUI{
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = [self tableHeaderView];
    self.tableView.tableFooterView = [self tableFooterView];
    [self.view addSubview:self.tableView];
}


- (UIView *)tableHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 148)];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, 128)];
    [bgIV setImage:[UIImage imageNamed:@"mybgpic"]];
    
    [view addSubview:bgIV];
    
    UIImageView *photoIV=[[UIImageView alloc]initWithFrame:CGRectMake(40, 50, 31, 34)];
    [photoIV setImage:[UIImage imageNamed:@"people_ayb"]];
    
    [view addSubview:photoIV];
    
    self.userPhoneNumber = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, 220, 40)];
    self.userPhoneNumber.textAlignment = NSTextAlignmentLeft;
    self.userPhoneNumber.font =[UIFont systemFontOfSize:17];
    self.userPhoneNumber.textColor = [UIColor whiteColor];
    self.userPhoneNumber.hidden = YES;
    [view addSubview:self.userPhoneNumber];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setFrame:CGRectMake(80, 50, 80, 40)];
    [self.loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    
    [self.loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.loginBtn];
    self.loginBtn.hidden = YES;
    
    
    
    

    return view;
}

- (UIView *)tableFooterView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    view.backgroundColor = [UIColor clearColor];
    
    _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_exitBtn setFrame:CGRectMake(20, 0, 280, 40)];
    [_exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_exitBtn setBackgroundColor:[UIColor orangeColor]];
    _exitBtn.layer.cornerRadius = 4;
    [_exitBtn addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_exitBtn];
    
    if ([self isLoginOK]) {
        _exitBtn.hidden = NO;
    }else{
        _exitBtn.hidden = YES;
    }
    
    return view;
}



- (void)exitAction:(id)sender{
    
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你确定要退出登录吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [av show];

}


- (void)exitOperation{
    NSUserDefaults *accountDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [accountDefaults dictionaryForKey:UserGlobalKey];
    NSMutableDictionary *mUserDic= [userDic mutableCopy];
    
    [mUserDic setObject:@"0" forKey:UserIsLoginKey];
    [mUserDic setObject:[self getUserPhoneNumber] forKey:UserPhoneNumberKey];
    [mUserDic setObject:@"" forKey:UserLoginId];
    
    [accountDefaults setObject:mUserDic forKey:UserGlobalKey];
    
    [accountDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:MZB_NOTE_EXIT_OK object:nil];
}

- (void)loginAction:(id)sender{
    
    LoginVC *loginVC = [[LoginVC alloc]init];
    loginVC.isOrderFrom = NO;
    UINavigationController *loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self presentViewController:loginNC animated:YES completion:^{
        
    }];
    //[self.navigationController pushViewController:loginVC animated:YES];
    
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuse = @"MyAccountTVC";
    
    MyAccountTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell == nil) {
        cell = [[MyAccountTVC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
        //cell.delegate = self;
    }
    
    NSString *str = nil;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
//            case 0:
//                str = @"金币活动";
//                break;
            case 0:
                str = @"账户详情";
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
                str = @"告诉朋友";
                break;
            case 1:
                str = @"意见反馈";
                break;
//            case 2:
//                str = @"获取开通服务城市";
//                break;
            case 2:
                str = @"更多设置";
                break;
            default:
                break;
        }
    }
    
    cell.textLabel.text = str;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
    
}




#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    return 44.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
//            case 0:
//            {
//                GoldenIconActivityVC *goldenIcon = [GoldenIconActivityVC new];
//                [self.navigationController pushViewController:goldenIcon animated:YES];
//                
//            }
//                break;
            case 0:
            {
                if ([self isLoginOK]) {
                    AccountDetailVC *detailVC =[AccountDetailVC new];
                    [self.navigationController pushViewController:detailVC animated:YES];
                }
                else {
                    [UIFactory showAlert:@"请登录"];
                }
                
            }
                break;
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:
            {
//                ShareToFriendsVC *friendVC =[ShareToFriendsVC new];
//                [self.navigationController pushViewController:friendVC animated:YES];
                [self shareAction];
            }
                break;
            case 1:
            {
                FeedBackVC *feedBackVC =[FeedBackVC new];
                [self.navigationController pushViewController:feedBackVC animated:YES];
            }
                break;
//            case 2:
//            {
//                AvailableCitiesVC *availableCities = [AvailableCitiesVC new];
//                [self.navigationController pushViewController:availableCities animated:YES];
//            }
//                break;
            case 2:
            {
                MoreSettingVC *moreSetting =[MoreSettingVC new];
                [self.navigationController pushViewController:moreSetting animated:YES];
            }
                break;
            default:
                break;
        }
    }

    
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.1;
    }else{
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return 20;
    }
    return 0.01;
}


- (void)shareAction{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userID = [userDic objectForKey:UserLoginId];
    
    //分享得优惠 http://www.mrchabo.com/mz/Service/register.do?recommenderId=

    
    [[MZBHttpService shareInstance] getShareContentWithShareUserID:userID andBlock:^(NSString *response, NSError *error) {
        
        NSString *shareText = @"分享得优惠 http://www.mrchabo.com/mz/Service/register.do?recommenderId=";
        
        if (!error) {
            
            shareText = response;
        }
        
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"54f7f5d2fd98c52b230005a4"
                                          shareText:shareText
                                         shareImage:[UIImage imageNamed:@"icon-60@2x.png"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToSms,UMShareToWechatTimeline,nil]
                                           delegate:self];
        [UMSocialConfig setFinishToastIsHidden:YES position:UMSocialiToastPositionCenter];

        
    }];
    
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            [self exitOperation];
            break;
        }
        case 1:
            
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    
    NSLog(@"%u",response.responseCode);
    if (response.responseCode == UMSResponseCodeSuccess) {
        hud.labelText = @"分享成功";
    }
    else{
        hud.labelText = @"分享失败";
    }
    
    
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    hud.mode = MBProgressHUDModeCustomView;
    

    [hud show:YES];
    [hud hide:YES afterDelay:2.0];

  

}

@end
