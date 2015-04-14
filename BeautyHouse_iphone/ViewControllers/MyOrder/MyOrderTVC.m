//
//  MyOrderTVC.m
//  BeautyHouse
//
//  Created by Roy on 15/3/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyOrderTVC.h"
#import "HomeService.h"

@interface MyOrderTVC ()<UIAlertViewDelegate>

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *status;

@property (nonatomic, strong) UIButton *complaintBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong)UIView  *verticalLine1;
@property (nonatomic, strong)UIView  *verticalLine2;
@property (nonatomic, strong)UIView  *verticalLine3;

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation MyOrderTVC

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *firstIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 22, 22)];
        [firstIV setImage:[UIImage imageNamed:@"icon_home"]];
        [self.contentView addSubview:firstIV];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 165, 20)];
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.textColor = [UIColor darkGrayColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.title];
        
        
        self.complaintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.complaintBtn setFrame:CGRectMake(220, 5, 70, 30)];
        [self.complaintBtn setTitle:@"投诉" forState:UIControlStateNormal];
        self.complaintBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.complaintBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.complaintBtn addTarget:self action:@selector(complaintBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        //[self.contentView addSubview:self.complaintBtn];
        
        
        self.verticalLine1 = [[UIView alloc]initWithFrame:CGRectMake(40, 40, 260, 1)];
        self.verticalLine1.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.verticalLine1];
        
        UIImageView *secondIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49, 22, 22)];
        [secondIV setImage:[UIImage imageNamed:@"icon_time"]];
        [self.contentView addSubview:secondIV];
        
        self.time = [[UILabel alloc]initWithFrame:CGRectMake(40, 50, 205, 20)];
        self.time.font = [UIFont systemFontOfSize:14];
        self.time.textColor = [UIColor darkGrayColor];
        self.time.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.time];
        
        self.verticalLine2 = [[UIView alloc]initWithFrame:CGRectMake(40, 80, 260, 1)];
        self.verticalLine2.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.verticalLine2];
        
        UIImageView *thirdIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 99, 22, 22)];
        [thirdIV setImage:[UIImage imageNamed:@"icon_adress"]];
        [self.contentView addSubview:thirdIV];
        
        self.address = [[UILabel alloc]initWithFrame:CGRectMake(40, 90, 205, 40)];
        self.address.font = [UIFont systemFontOfSize:14];
        self.address.textColor = [UIColor darkGrayColor];
        self.address.numberOfLines = 2;
        self.address.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.address];
        
        
        self.verticalLine3 = [[UIView alloc]initWithFrame:CGRectMake(10, 140, 290, 1)];
        self.verticalLine3.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.verticalLine3];
        
        self.status = [[UILabel alloc]initWithFrame:CGRectMake(10, 155, 160, 25)];
        self.status.font = [UIFont systemFontOfSize:14];
        self.status.textColor = [UIColor darkGrayColor];
        self.status.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.status];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn setFrame:CGRectMake(180, 155, 100, 30)];
        [self.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.cancelBtn];
        // Initialization code
    }
    return self;
    
}


- (void)updateMyOrderTVC:(MyOrderVO *)orderVO{
    self.title.text = orderVO.title;
    self.time.text = orderVO.time;
    self.address.text = orderVO.address;
    self.status.text = orderVO.status;
    
    if (orderVO.orderType == kOrderTypeHistory) {
        self.complaintBtn.hidden = YES;
        self.cancelBtn.hidden = YES;
    }else{
        self.complaintBtn.hidden = NO;
        self.cancelBtn.hidden = NO;
    }
}


- (void)complaintBtnClicked:(id)sender{
    if ([self.delegate respondsToSelector:@selector(complaintBtnClickedWithMyOrderTVC:)]) {
        [self.delegate complaintBtnClickedWithMyOrderTVC:self];
    }
}


- (void)cancelBtnClicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要取消订单吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 88;
    [alert show];
    
 }

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 88 && buttonIndex == 1) {
        NSLog(@"%li",buttonIndex);
        
        NSString *param = [NSString stringWithFormat:@"{\"id\":\"%@\"}", self.myOrderVO.orderID];
        
        _hud = [[MBProgressHUD alloc] initWithView:self.contentView];
        _hud.labelText = @"取消中...";
        [self.contentView addSubview:_hud];
        [_hud show:YES];
        
        
        HomeService *homeService = [HomeService alloc];
        [homeService cancelOrdersWithParam:param andWithBlock:^(NSNumber *result, NSError *error) {
            [_hud hide:NO];
            
            if (!error) {
                if ([result integerValue] == 0) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"订单已经成功取消！" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    alert.tag = 888;
                    [alert show];
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发生未知错误，请重试！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
                
            }
            else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
    else if (alertView.tag == 888){
        
        if ([self.delegate respondsToSelector:@selector(cancelBtnClickedWithMyOrderTVC:)]) {
            [self.delegate cancelBtnClickedWithMyOrderTVC:self];
        }

    }
}


@end
