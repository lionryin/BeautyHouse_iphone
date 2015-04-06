//
//  ChooseAddressCell.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ChooseAddressCell.h"

@implementation ChooseAddressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    //_xiaoquLabel.text = [_addressDic objectForKey:@"xq"];
    //_detailAddress.text = [_addressDic objectForKey:@"detail"];
    _xiaoquLabel.text = _address.cellName;
    _detailAddress.text = _address.detailAddress;
}

@end
