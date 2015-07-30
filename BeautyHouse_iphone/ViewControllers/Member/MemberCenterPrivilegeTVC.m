//
//  MemberCenterPrivilegeTVC.m
//  BeautyHouse
//
//  Created by Roy on 15/3/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MemberCenterPrivilegeTVC.h"

@implementation MemberPrivilegeVO

@end


@interface MemberCenterPrivilegeTVC ()

@property (nonatomic, strong) UIView *lView;
@property (nonatomic, strong) UIImageView *lImageView;
@property (nonatomic, strong) UILabel *lTitle;
@property (nonatomic, strong) UILabel *lDetail;

@property (nonatomic, strong) UIView *rView;
@property (nonatomic, strong) UIImageView *rImageView;
@property (nonatomic, strong) UILabel *rTitle;
@property (nonatomic, strong) UILabel *rDetail;


@property (nonatomic, strong) UIView *verticalLine;
@property (nonatomic, strong) UIView *horizontalLine;


@end

@implementation MemberCenterPrivilegeTVC

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //左
        self.lView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 100)];
        
        [self.contentView addSubview:self.lView];
        
        self.lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 40, 40)];
        [self.lView addSubview:self.lImageView];
        
        self.lTitle = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 100, 25)];
        self.lTitle.backgroundColor =[UIColor clearColor];
        self.lTitle.textAlignment = NSTextAlignmentLeft;
        self.lTitle.font = [UIFont systemFontOfSize:14];
        self.lTitle.textColor =[UIColor darkGrayColor];
        [self.lView addSubview:self.lTitle];
        
        self.lDetail = [[UILabel alloc]initWithFrame:CGRectMake(60, 55, 100, 15)];
        self.lDetail.backgroundColor =[UIColor clearColor];
        self.lDetail.textAlignment = NSTextAlignmentLeft;
        self.lDetail.font = [UIFont systemFontOfSize:11];
        self.lDetail.textColor =[UIColor grayColor];
        [self.lView addSubview:self.lDetail];
        
        
        //
        self.verticalLine = [[UIView alloc]initWithFrame:CGRectMake(159, 0, 1, 100)];
        self.verticalLine.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
        [self.lView addSubview:self.verticalLine];
        
        
        //右
        self.rView  = [[UIView alloc]initWithFrame:CGRectMake(160, 0, 160, 100)];
        
        [self.contentView addSubview:self.rView];
        
        self.rImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 40, 40)];
        [self.rView addSubview:self.rImageView];
        
        self.rTitle = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 100, 25)];
        self.rTitle.backgroundColor =[UIColor clearColor];
        self.rTitle.textAlignment = NSTextAlignmentLeft;
        self.rTitle.font = [UIFont systemFontOfSize:14];
        self.rTitle.textColor =[UIColor darkGrayColor];
        [self.rView addSubview:self.rTitle];
        
        self.rDetail = [[UILabel alloc]initWithFrame:CGRectMake(60, 55, 100, 15)];
        self.rDetail.backgroundColor =[UIColor clearColor];
        self.rDetail.textAlignment = NSTextAlignmentLeft;
        self.rDetail.font = [UIFont systemFontOfSize:11];
        self.rDetail.textColor =[UIColor grayColor];
        [self.rView addSubview:self.rDetail];
        
        
        self.horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, 99, self.frame.size.width, 1)];
        self.horizontalLine.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.horizontalLine];
        
        
    }
    
    return self;
}


- (void)updateCellWithLPrivilegeVO:(MemberPrivilegeVO *)lVO andRPrivilegeVO:(MemberPrivilegeVO *)rVO{
    
    [self.lImageView setImage:[UIImage imageNamed:lVO.imageName]];
    self.lTitle.text = lVO.title;
    self.lDetail.text = lVO.detail;
    
    [self.rImageView setImage:[UIImage imageNamed:rVO.imageName]];
    self.rTitle.text = rVO.title;
    self.rDetail.text = rVO.detail;
    
}

@end
