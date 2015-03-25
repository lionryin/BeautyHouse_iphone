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
@property (nonatomic, strong) UIImageView *lImageView;
@property (nonatomic, strong) UILabel *lTitle;
@property (nonatomic, strong) UILabel *lDetail;

@property (nonatomic, strong) UIImageView *rImageView;
@property (nonatomic, strong) UILabel *rTitle;
@property (nonatomic, strong) UILabel *rDetail;


@end

@implementation MemberCenterPrivilegeTVC

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //左
        self.lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 40, 40)];
        [self.contentView addSubview:self.lImageView];
        
        self.lTitle = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 100, 25)];
        self.lTitle.backgroundColor =[UIColor clearColor];
        self.lTitle.textAlignment = NSTextAlignmentLeft;
        self.lTitle.font = [UIFont systemFontOfSize:14];
        self.lTitle.textColor =[UIColor darkGrayColor];
        [self.contentView addSubview:self.lTitle];
        
        self.lDetail = [[UILabel alloc]initWithFrame:CGRectMake(60, 55, 100, 15)];
        self.lDetail.backgroundColor =[UIColor clearColor];
        self.lDetail.textAlignment = NSTextAlignmentLeft;
        self.lDetail.font = [UIFont systemFontOfSize:11];
        self.lDetail.textColor =[UIColor grayColor];
        [self.contentView addSubview:self.lDetail];
        
        
        
        
        //右
        self.rImageView = [[UIImageView alloc]initWithFrame:CGRectMake(160+10, 30, 40, 40)];
        [self.contentView addSubview:self.rImageView];
        
        self.rTitle = [[UILabel alloc]initWithFrame:CGRectMake(160+60, 30, 100, 25)];
        self.rTitle.backgroundColor =[UIColor clearColor];
        self.rTitle.textAlignment = NSTextAlignmentLeft;
        self.rTitle.font = [UIFont systemFontOfSize:14];
        self.rTitle.textColor =[UIColor darkGrayColor];
        [self.contentView addSubview:self.rTitle];
        
        self.rDetail = [[UILabel alloc]initWithFrame:CGRectMake(160+60, 55, 100, 15)];
        self.rDetail.backgroundColor =[UIColor clearColor];
        self.rDetail.textAlignment = NSTextAlignmentLeft;
        self.rDetail.font = [UIFont systemFontOfSize:11];
        self.rDetail.textColor =[UIColor grayColor];
        [self.contentView addSubview:self.rDetail];
        
        
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
