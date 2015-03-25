//
//  AllServiceCell.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AllServiceCell.h"

@implementation AllServiceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonPressed:(id)sender{
    UIButton *button = (UIButton *)sender;
    
    if (button.tag == 1) {
        [self.delegate AllServiceCellButtonPressed:sender andMzbService:_childService1];
    }
    else if (button.tag == 2){
        [self.delegate AllServiceCellButtonPressed:sender andMzbService:_childService2];
    }
    
}

- (void)layoutSubviews{
    
    [_button1 setTitle:_childService1.serviceName forState:UIControlStateNormal];
    
    NSString *imageUrl1 = [NSString stringWithFormat:@"%@%@",imageURLPrefix,_childService1.servicePhoto];
    
    [_button1 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl1] placeholderImage:[UIImage imageNamed:@""]];
    
    if (_childService2) {
        [_button2 setHidden:NO];
        [_button2 setTitle:_childService2.serviceName forState:UIControlStateNormal];
        
        NSString *imageUrl2 = [NSString stringWithFormat:@"%@%@",imageURLPrefix,_childService2.servicePhoto];
        
        [_button2 setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl2] placeholderImage:[UIImage imageNamed:@""]];

    }
    else{
        [_button2 setHidden: YES];
    }
    
}

@end
