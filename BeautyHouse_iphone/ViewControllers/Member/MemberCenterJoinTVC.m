//
//  MemberCenterJoinTVC.m
//  BeautyHouse
//
//  Created by Roy on 15/3/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MemberCenterJoinTVC.h"

@implementation JoinMemberVO

@end



@interface MemberCenterJoinTVC ()

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UIButton *joinBtn;

@property (nonatomic, strong) UIView *horizontalLine;

@end



@implementation MemberCenterJoinTVC

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 80, 20)];
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.textColor = [UIColor darkGrayColor];
        self.title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.title];
        
        
        self.detail = [[UILabel alloc]initWithFrame:CGRectMake(100, 12, 140, 20)];
        self.detail.font = [UIFont systemFontOfSize:14];
        self.detail.textColor = [UIColor darkGrayColor];
        self.detail.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.detail];
        
        
        self.joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.joinBtn setFrame:CGRectMake(240, 5, 70, 30)];
        [self.joinBtn setTitle:@"开通" forState:UIControlStateNormal];
        self.joinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.joinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.joinBtn setBackgroundColor:[UIColor orangeColor]];
        self.joinBtn.layer.cornerRadius = 4;
        [self.joinBtn addTarget:self action:@selector(joinBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.joinBtn];
        
        self.horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, 43, self.frame.size.width, 1)];
        self.horizontalLine.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.horizontalLine];
        
    }
    
    return self;
}


- (void)updateCellWithJoinMemberVO:(JoinMemberVO *)joinMemberVO{
    self.title.text = joinMemberVO.title;
    self.detail.text = joinMemberVO.detail;
    
}

- (void)joinBtnClicked:(id)sender{
    if ([self.delegate respondsToSelector:@selector(joinBtnClicked:)]) {
        [self.delegate joinBtnClickedWithMemberCenterJoinTVC:self];
    }
}

@end
