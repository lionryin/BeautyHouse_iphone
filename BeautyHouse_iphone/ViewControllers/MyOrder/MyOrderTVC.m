//
//  MyOrderTVC.m
//  BeautyHouse
//
//  Created by Roy on 15/3/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MyOrderTVC.h"

@interface MyOrderTVC ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *status;

@property (nonatomic, strong) UIButton *complaintBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong)UIView  *verticalLine1;
@property (nonatomic, strong)UIView  *verticalLine2;
@property (nonatomic, strong)UIView  *verticalLine3;

@end

@implementation MyOrderTVC

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *firstIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        [firstIV setImage:[UIImage imageNamed:@"icon_home"]];
        [self.contentView addSubview:firstIV];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(45, 10, 160, 20)];
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
        [self.contentView addSubview:self.complaintBtn];
        
        
        self.verticalLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 300, 1)];
        self.verticalLine1.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.verticalLine1];
        
        UIImageView *secondIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 45, 30, 30)];
        [secondIV setImage:[UIImage imageNamed:@"icon_time"]];
        [self.contentView addSubview:secondIV];
        
        self.time = [[UILabel alloc]initWithFrame:CGRectMake(45, 50, 200, 20)];
        self.time.font = [UIFont systemFontOfSize:14];
        self.time.textColor = [UIColor darkGrayColor];
        self.time.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.time];
        
        self.verticalLine2 = [[UIView alloc]initWithFrame:CGRectMake(0, 80, 300, 1)];
        self.verticalLine2.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.verticalLine2];
        
        UIImageView *thirdIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 85, 30, 30)];
        [thirdIV setImage:[UIImage imageNamed:@"icon_adress"]];
        [self.contentView addSubview:thirdIV];
        
        self.address = [[UILabel alloc]initWithFrame:CGRectMake(45, 90, 200, 20)];
        self.address.font = [UIFont systemFontOfSize:14];
        self.address.textColor = [UIColor darkGrayColor];
        self.address.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.address];
        
        
        self.verticalLine3 = [[UIView alloc]initWithFrame:CGRectMake(0, 120, 300, 1)];
        self.verticalLine3.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.verticalLine3];
        
        self.status = [[UILabel alloc]initWithFrame:CGRectMake(10, 135, 160, 25)];
        self.status.font = [UIFont systemFontOfSize:14];
        self.status.textColor = [UIColor darkGrayColor];
        self.status.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.status];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn setFrame:CGRectMake(180, 135, 100, 30)];
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
    if ([self.delegate respondsToSelector:@selector(cancelBtnClickedWithMyOrderTVC:)]) {
        [self.delegate cancelBtnClickedWithMyOrderTVC:self];
    }
}

@end
