//
//  OrderDetailVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/14.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "OrderDetailVC.h"
#import "HomeService.h"

@interface OrderDetailVC ()
@property (weak, nonatomic) IBOutlet UIImageView *dfpImageView;
@property (weak, nonatomic) IBOutlet UIImageView *zxzImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fwwcImageView;
@property (weak, nonatomic) IBOutlet UIImageView *jsImageView;

@property (weak, nonatomic) IBOutlet UILabel *hLabel;

@property (weak, nonatomic) IBOutlet UIImageView *statusImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView4;

@property (weak, nonatomic) IBOutlet UIView *statusView1;
@property (weak, nonatomic) IBOutlet UIView *statusView2;
@property (weak, nonatomic) IBOutlet UIView *statusView3;
@property (weak, nonatomic) IBOutlet UIView *statusView4;
@property (weak, nonatomic) IBOutlet UILabel *keyNameLabel1;
@property (weak, nonatomic) IBOutlet UILabel *statusTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *keyNameLabel2;
@property (weak, nonatomic) IBOutlet UILabel *statusTimeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *keyNameLabel3;
@property (weak, nonatomic) IBOutlet UILabel *statusTimeLabel3;
@property (weak, nonatomic) IBOutlet UILabel *keyNameLabel4;
@property (weak, nonatomic) IBOutlet UILabel *statusTimeLabel4;

@end

@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = [NSString stringWithFormat:@"%@--订单详情",_orderVO.title];
    [self getOrderLogList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fillStatus1WithDic:(NSDictionary *)dic{
    _statusImageView1.highlighted = YES;
    _statusView1.hidden = NO;
    
    _keyNameLabel1.text = [[dic objectForKey:@"lastStatue"] objectForKey:@"keyName"];
    _statusTimeLabel.text = [dic objectForKey:@"operateTime"];

}

- (void)fillStatus2WithDic:(NSDictionary *)dic{
    _statusImageView2.highlighted = YES;
    _statusView2.hidden = NO;
    
    _keyNameLabel2.text = [[dic objectForKey:@"lastStatue"] objectForKey:@"keyName"];
    _statusTimeLabel2.text = [dic objectForKey:@"operateTime"];
}

- (void)fillStatus3WithDic:(NSDictionary *)dic{

    _statusImageView3.highlighted = YES;
    _statusView3.hidden = NO;
    
    _keyNameLabel3.text = [[dic objectForKey:@"lastStatue"] objectForKey:@"keyName"];
    _statusTimeLabel3.text = [dic objectForKey:@"operateTime"];
}

- (void)fillStatus4WithDic:(NSDictionary *)dic{

    _statusImageView4.highlighted = YES;
    _statusView4.hidden = NO;
    
    _keyNameLabel4.text = [[dic objectForKey:@"lastStatue"] objectForKey:@"keyName"];
    _statusTimeLabel4.text = [dic objectForKey:@"operateTime"];
}



- (void)initUIWithResultInfo:(NSArray *)info andOrderStatus:(NSInteger)orderStatus{
    
    if (info.count == 0) {
        return;
    }
    
    CGRect hLabelFrame = _hLabel.frame;
    hLabelFrame.size.height = 74*(info.count) + 15*(info.count-1);
    _hLabel.frame = hLabelFrame;
    
    
    if (orderStatus == 32 ) {
        NSDictionary *dic = [info objectAtIndex:0];
        [self fillStatus1WithDic:dic];
    }
    else if (orderStatus == 33){
        NSDictionary *dic = [info objectAtIndex:0];
        [self fillStatus1WithDic:dic];
        
        if (info.count>1) {
            NSDictionary *dic1 = [info objectAtIndex:1];
            [self fillStatus2WithDic:dic1];

        }
    }
    else if (orderStatus == 34){
        NSDictionary *dic = [info objectAtIndex:0];
        [self fillStatus1WithDic:dic];
        if (info.count>1) {
            NSDictionary *dic1 = [info objectAtIndex:1];
            [self fillStatus2WithDic:dic1];
            
            if (info.count>2) {
                NSDictionary *dic2 = [info objectAtIndex:2];
                [self fillStatus3WithDic:dic2];
            }
        }
    }
    else if (orderStatus == 35){
        NSDictionary *dic = [info objectAtIndex:0];
        [self fillStatus1WithDic:dic];
        if (info.count>1) {
            NSDictionary *dic1 = [info objectAtIndex:1];
            [self fillStatus2WithDic:dic1];
            
            if (info.count>2) {
                NSDictionary *dic2 = [info objectAtIndex:2];
                [self fillStatus3WithDic:dic2];
                
                if (info.count>3) {
                    NSDictionary *dic3 = [info objectAtIndex:3];
                    [self fillStatus4WithDic:dic3];

                }
            }
        }

    }
    else if (orderStatus == 36 ){
        if (info.count>4) {
            
            NSDictionary *dic = [info objectAtIndex:0];
            [self fillStatus1WithDic:dic];
            
            NSDictionary *dic1 = [info objectAtIndex:1];
            [self fillStatus2WithDic:dic1];
            
        
            NSDictionary *dic2 = [info objectAtIndex:3];
            [self fillStatus3WithDic:dic2];
            
        
            NSDictionary *dic3 = [info objectAtIndex:4];
            [self fillStatus4WithDic:dic3];
            
            
        }
        else{
            NSDictionary *dic = [info objectAtIndex:0];
            [self fillStatus1WithDic:dic];
            if (info.count>1) {
                NSDictionary *dic1 = [info objectAtIndex:1];
                [self fillStatus2WithDic:dic1];
                
                if (info.count>2) {
                    NSDictionary *dic2 = [info objectAtIndex:2];
                    [self fillStatus3WithDic:dic2];
                    
                    if (info.count>3) {
                        NSDictionary *dic3 = [info objectAtIndex:3];
                        [self fillStatus4WithDic:dic3];
                        
                    }
                }
            }

        }
    }
    else if (orderStatus == 78){
        NSDictionary *dic = [info objectAtIndex:0];
        [self fillStatus1WithDic:dic];
        if (info.count>1) {
            NSDictionary *dic1 = [info objectAtIndex:1];
            [self fillStatus2WithDic:dic1];
            
            if (info.count>2) {
                NSDictionary *dic2 = [info objectAtIndex:2];
                [self fillStatus3WithDic:dic2];
                
                if (info.count>3) {
                    NSDictionary *dic3 = [info objectAtIndex:3];
                    [self fillStatus4WithDic:dic3];
                    
                }
            }
        }

    }
    else{
        _dfpImageView.highlighted = NO;
        _zxzImageView.highlighted = NO;
        _fwwcImageView.highlighted = NO;
        _jsImageView.highlighted = NO;
    }

    
    
}

- (void)initStatusImageViewWithStatus:(NSInteger)orderStatus{
    
    if (orderStatus == 32 || orderStatus == 33) {
        _dfpImageView.highlighted = YES;
    }
    else if (orderStatus == 34){
        _dfpImageView.highlighted = YES;
        _zxzImageView.highlighted = YES;
    }
    else if (orderStatus == 35){
        _dfpImageView.highlighted = YES;
        _zxzImageView.highlighted = YES;
        _fwwcImageView.highlighted = YES;
    }
    else if (orderStatus == 36 || orderStatus == 78){
        _dfpImageView.highlighted = YES;
        _zxzImageView.highlighted = YES;
        _fwwcImageView.highlighted = YES;
        _jsImageView.highlighted = YES;
    }
}

#pragma mark - getOrderList
- (void)getOrderLogList{
    HomeService *homeService = [[HomeService alloc] init];
    [homeService getOrderLogListWithParam:[NSString stringWithFormat:@"{\"orderId\":\"%@\"}",_orderVO.orderID] andWithBlock:^(NSNumber *result,NSNumber *orderStatus, NSArray *resultInfo, NSError *error) {
        
        if (!error) {
            if ([result integerValue] == 0) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self initStatusImageViewWithStatus:[orderStatus integerValue]];
                    [self initUIWithResultInfo:resultInfo andOrderStatus:[orderStatus integerValue]];
                });
                
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发生未知错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
    }];
}


@end
