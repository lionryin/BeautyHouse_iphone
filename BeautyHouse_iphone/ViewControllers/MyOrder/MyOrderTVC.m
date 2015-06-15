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

@property (strong, nonatomic) UIView *view1;
@property (strong, nonatomic) UIView *view2;

@property (nonatomic, strong) UILabel *auntNameLabel;
@property (nonatomic, strong) UIImageView *levelImageView1;
@property (nonatomic, strong) UIImageView *levelImageView2;
@property (nonatomic, strong) UIImageView *levelImageView3;
@property (nonatomic, strong) UIImageView *levelImageView4;
@property (nonatomic, strong) UIImageView *levelImageView5;

@property (nonatomic, strong) UIButton *phoneButton;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *status;

@property (nonatomic, strong) UIButton *complaintBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (strong, nonatomic) UIButton *zhifuBtn;

@property (nonatomic, strong)UIView  *verticalLine1;
@property (nonatomic, strong)UIView  *verticalLine2;
@property (nonatomic, strong)UIView  *verticalLine3;

@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation MyOrderTVC

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _view1 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_view1];
        
        UIImageView *auntImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        auntImageView.image = [UIImage imageNamed:@"auntIcon.png"];
        [_view1 addSubview:auntImageView];
        
        _auntNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 8, 150, 20)];
        _auntNameLabel.font = [UIFont systemFontOfSize:12];
        _auntNameLabel.textColor = [UIColor darkGrayColor];
        _auntNameLabel.textAlignment = NSTextAlignmentLeft;
        [_view1 addSubview:_auntNameLabel];
        
        ///level
        CGFloat levelX = 60, levelSize = 15;
        _levelImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(levelX, 33, levelSize, levelSize)];
        _levelImageView1.image = [UIImage imageNamed:@"star_normal.png"];
        _levelImageView1.highlightedImage = [UIImage imageNamed:@"star_select.png"];
        [_view1 addSubview:_levelImageView1];
        
        levelX += levelSize + 2;
        
        _levelImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(levelX, 33, levelSize, levelSize)];
        _levelImageView2.image = [UIImage imageNamed:@"star_normal.png"];
        _levelImageView2.highlightedImage = [UIImage imageNamed:@"star_select.png"];
        [_view1 addSubview:_levelImageView2];
        
        levelX += levelSize + 2;
        
        _levelImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(levelX, 33, levelSize, levelSize)];
        _levelImageView3.image = [UIImage imageNamed:@"star_normal.png"];
        _levelImageView3.highlightedImage = [UIImage imageNamed:@"star_select.png"];
        [_view1 addSubview:_levelImageView3];
        
        levelX += levelSize + 2;
        
        _levelImageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(levelX, 33, levelSize, levelSize)];
        _levelImageView4.image = [UIImage imageNamed:@"star_normal.png"];
        _levelImageView4.highlightedImage = [UIImage imageNamed:@"star_select.png"];
        [_view1 addSubview:_levelImageView4];
        
        levelX += levelSize + 2;
        
        _levelImageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(levelX, 33, levelSize, levelSize)];
        _levelImageView5.image = [UIImage imageNamed:@"star_normal.png"];
        _levelImageView5.highlightedImage = [UIImage imageNamed:@"star_select.png"];
        [_view1 addSubview:_levelImageView5];
        ///////////////
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneButton setFrame:CGRectMake(260, 18, 25, 25)];
        _phoneButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_phoneButton setImage:[UIImage imageNamed:@"auntPhone.png"] forState:UIControlStateNormal];
        [_phoneButton addTarget:self action:@selector(phoneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_view1 addSubview:_phoneButton];
        
        UIView *verticalLine4 = [[UIView alloc]initWithFrame:CGRectMake(10, 59, 280, 1)];
        verticalLine4.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_view1 addSubview:verticalLine4];


        
        /////view2
        _view2 = [[UIView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_view2];
        
        UIImageView *firstIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 22, 22)];
        [firstIV setImage:[UIImage imageNamed:@"icon_home"]];
        [_view2 addSubview:firstIV];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 165, 20)];
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.textColor = [UIColor darkGrayColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        [_view2 addSubview:self.title];
        
        
        self.complaintBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.complaintBtn setFrame:CGRectMake(220, 5, 70, 30)];
        [self.complaintBtn setTitle:@"评价" forState:UIControlStateNormal];
        self.complaintBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.complaintBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.complaintBtn addTarget:self action:@selector(complaintBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_view2 addSubview:self.complaintBtn];
        
        
        self.verticalLine1 = [[UIView alloc]initWithFrame:CGRectMake(40, 40, 250, 1)];
        self.verticalLine1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_view2 addSubview:self.verticalLine1];
        
        UIImageView *secondIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 49, 22, 22)];
        [secondIV setImage:[UIImage imageNamed:@"icon_time"]];
        [_view2 addSubview:secondIV];
        
        self.time = [[UILabel alloc]initWithFrame:CGRectMake(40, 50, 205, 20)];
        self.time.font = [UIFont systemFontOfSize:14];
        self.time.textColor = [UIColor darkGrayColor];
        self.time.textAlignment = NSTextAlignmentLeft;
        [_view2 addSubview:self.time];
        
        self.verticalLine2 = [[UIView alloc]initWithFrame:CGRectMake(40, 80, 250, 1)];
        self.verticalLine2.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_view2 addSubview:self.verticalLine2];
        
        UIImageView *thirdIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 99, 22, 22)];
        [thirdIV setImage:[UIImage imageNamed:@"icon_adress"]];
        [_view2 addSubview:thirdIV];
        
        self.address = [[UILabel alloc]initWithFrame:CGRectMake(40, 90, 205, 40)];
        self.address.font = [UIFont systemFontOfSize:14];
        self.address.textColor = [UIColor darkGrayColor];
        self.address.numberOfLines = 2;
        self.address.textAlignment = NSTextAlignmentLeft;
        [_view2 addSubview:self.address];
        
        
        self.verticalLine3 = [[UIView alloc]initWithFrame:CGRectMake(10, 140, 280, 1)];
        self.verticalLine3.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_view2 addSubview:self.verticalLine3];
        
        self.status = [[UILabel alloc]initWithFrame:CGRectMake(10, 155, 160, 25)];
        self.status.font = [UIFont systemFontOfSize:14];
        self.status.textColor = [UIColor darkGrayColor];
        self.status.textAlignment = NSTextAlignmentLeft;
        [_view2 addSubview:self.status];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn setFrame:CGRectMake(200, 155, 100, 30)];
        [self.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_view2 addSubview:self.cancelBtn];
        
        self.zhifuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.zhifuBtn setFrame:CGRectMake(200, 155, 100, 30)];
        [self.zhifuBtn setTitle:@"支付" forState:UIControlStateNormal];
        [self.zhifuBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.zhifuBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.zhifuBtn addTarget:self action:@selector(zhifuBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_view2 addSubview:self.zhifuBtn];
        // Initialization code
    }
    return self;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self updateMyOrderTVC];
}

- (CGFloat )updateMyOrderTVC{
    
    MyOrderVO *orderVO = self.myOrderVO;
    
    CGFloat height = 0;
    
    if ([orderVO.statusID integerValue] == 32 || [orderVO.statusID integerValue] == 78) {
        _view1.hidden = YES;
        _view2.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 195);
        height = 195;
        
        self.zhifuBtn.hidden = YES;
        self.cancelBtn.hidden = [orderVO.statusID integerValue] == 32 ? NO : YES;
        self.complaintBtn.hidden = YES;
        
    }
    else{
        _view1.hidden = NO;
        _view1.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 60);
        _view2.frame = CGRectMake(0, 60, self.contentView.frame.size.width, 195);
        
        height = 60 + 195;
        
        
        if ([orderVO.statusID integerValue] == 33) {
            self.zhifuBtn.hidden = NO;
            self.cancelBtn.hidden = YES;
            self.complaintBtn.hidden = YES;
        }
        else if ([orderVO.statusID integerValue] == 34){
            self.zhifuBtn.hidden = YES;
            self.cancelBtn.hidden = YES;
            self.complaintBtn.hidden = NO;
        }
        else {
            self.zhifuBtn.hidden = YES;
            self.cancelBtn.hidden = YES;
            self.complaintBtn.hidden = YES;
        }
        
        _auntNameLabel.text = orderVO.auntName;
        
        double level = [orderVO.auntLevel doubleValue];
        
        if (level >= 0.2 && level<0.4) {
            _levelImageView1.highlighted = YES;
        }
        else if (level>=0.4 && level<0.6){
            _levelImageView1.highlighted = YES;
            _levelImageView2.highlighted = YES;
        }
        else if (level>=0.6 && level<0.8){
            _levelImageView1.highlighted = YES;
            _levelImageView2.highlighted = YES;
            _levelImageView3.highlighted = YES;
        }
        else if (level>=0.8 && level<1.0){
            _levelImageView1.highlighted = YES;
            _levelImageView2.highlighted = YES;
            _levelImageView3.highlighted = YES;
            _levelImageView4.highlighted = YES;
        }
        else if (level== 1.0){
            _levelImageView1.highlighted = YES;
            _levelImageView2.highlighted = YES;
            _levelImageView3.highlighted = YES;
            _levelImageView4.highlighted = YES;
            _levelImageView5.highlighted = YES;
        }
        else{
            _levelImageView1.highlighted = NO;
            _levelImageView2.highlighted = NO;
            _levelImageView3.highlighted = NO;
            _levelImageView4.highlighted = NO;
            _levelImageView5.highlighted = NO;
        }


    }
    
    if (![orderVO.isAppraised isKindOfClass:[NSNull class]]) {
        if ([orderVO.isAppraised integerValue] == 1) {
            self.complaintBtn.hidden = YES;
        }
    }
    
    
    
    self.title.text = orderVO.title;
    self.time.text = orderVO.time;
    self.address.text = orderVO.address;
    self.status.text = orderVO.status;
    
   /* if (orderVO.orderType == kOrderTypeHistory) {
        self.complaintBtn.hidden = NO;
        self.cancelBtn.hidden = YES;
        self.zhifuBtn.hidden = YES;
    }else{
        self.complaintBtn.hidden = YES;
        self.cancelBtn.hidden = NO;
    }*/
    
    return height;
}

#pragma mark - action
- (void)phoneButtonClicked:(id)sender{
    
    
    NSLog(@"phoneStr:%@",self.myOrderVO.auntPhone);

     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",self.myOrderVO.auntPhone]]];
}

- (void)complaintBtnClicked:(id)sender{//评价
    if ([self.delegate respondsToSelector:@selector(complaintBtnClickedWithMyOrderTVC:)]) {
        [self.delegate complaintBtnClickedWithMyOrderTVC:self];
    }
}


- (void)cancelBtnClicked:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定要取消订单吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 88;
    [alert show];
    
 }

- (void)zhifuBtnClicked:(id)sender{
    if ([self.delegate respondsToSelector:@selector(zhifuBtnClickedWithMyOrderTVC:)]) {
        [self.delegate zhifuBtnClickedWithMyOrderTVC:self];
    }
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%li",(long)buttonIndex);
    
    if (alertView.tag == 88 && buttonIndex == 1) {
        
        
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
