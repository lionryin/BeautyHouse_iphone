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
        
        self.lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 50, 50)];
        
    }
    
    return self;
}

@end
