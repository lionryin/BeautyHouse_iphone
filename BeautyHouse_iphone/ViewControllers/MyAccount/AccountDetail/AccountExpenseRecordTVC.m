//
//  AccountExpenseRecordTVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AccountExpenseRecordTVC.h"

@interface AccountExpenseRecordTVC ()

@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *moneyLabel;
@property (nonatomic,strong)UILabel *timeLabel;

@end
@implementation AccountExpenseRecordTVC

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        self.typeLabel = [self createLabelWithFrame:CGRectMake(10, 5, 150, 30)];
        self.typeLabel.font = [UIFont systemFontOfSize:15];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 30, self.frame.size.width, 1)];
        view.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:view];
        
        
        
        UILabel *moneyStr = [self createLabelWithFrame:CGRectMake(10, 40, 120, 25)];
        moneyStr.text =@"交易金额";
        [self.contentView addSubview:moneyStr];
        
        self.moneyLabel = [self createLabelWithFrame:CGRectMake(150, 40, 100, 25)];
        [self.contentView addSubview:self.moneyLabel];
        
        
        UILabel *timeStr = [self createLabelWithFrame:CGRectMake(10, 65, 120, 25)];
        timeStr.text =@"交易时间";
        [self.contentView addSubview:timeStr];
        
        self.timeLabel = [self createLabelWithFrame:CGRectMake(150, 65, 130, 25)];
        [self.contentView addSubview:self.timeLabel];
        
        
        
        
    }
    
    
    return self;
}


- (void)updateCellWithDictionary:(NSDictionary *)dic{
    
    NSDictionary *subdic = [dic objectForKey:@"cashType"];
    
    self.typeLabel.text = subdic[@"keyName"];
    
    self.moneyLabel.text = dic[@"money"];
    self.timeLabel.text = dic[@"tradingDate"];
    
}


- (UILabel *)createLabelWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    return label;
}
@end
