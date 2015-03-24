//
//  HomeBtnCell.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/18.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HomeBtnCell.h"
#import "MzbService.h"
#import "HomeButton.h"


@implementation HomeBtnCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setButtonInfoFrom:_serviceInfos];
}

- (void)setButtonInfoFrom:(NSArray *)infos{
    
    for (int i = 0; i< infos.count; i++) {
        HomeButton *button = (HomeButton *)[self viewWithTag:i+1];
        MzbService *aService = [infos objectAtIndex:i];
        [button setTitle:aService.serviceName forState:UIControlStateNormal];
        
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",imageURLPrefix,aService.servicePhoto];
        
        [button setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    }
}

- (IBAction)buttonPressed:(id)sender
{
    [self.delegate HomeBtnCellButtonPressed:sender andServiceInfos:_serviceInfos];
}

@end
