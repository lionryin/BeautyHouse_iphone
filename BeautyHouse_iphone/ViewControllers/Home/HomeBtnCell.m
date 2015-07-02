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
    
    _button1.hidden = YES;
    _button2.hidden = YES;
    _button3.hidden = YES;
    [self setButtonInfoFrom:_cellServices];
}

- (void)setButtonInfoFrom:(NSArray *)infos{
    NSLog(@"infos:%lu",(unsigned long)infos.count);
    
    for (int i = 0; i< infos.count; i++) {
        
        HomeButton *button = (HomeButton *)[self viewWithTag:i+1];
        button.hidden = NO;
        
        
        //MzbService *aService = [infos objectAtIndex:i];
        NSDictionary *aService = [infos objectAtIndex:i];
        [button setTitle:aService[@"name"] forState:UIControlStateNormal];
        
        NSString *serviceId = aService[@"id"];
        if ([serviceId isEqualToString:allServiceInfoID]) {//全部服务
            [button setImage:[UIImage imageNamed:@"logo_item_more.png"] forState:UIControlStateNormal];
        }
        else {
            NSString *imageUrl = [NSString stringWithFormat:@"%@%@",imageURLPrefix,aService[@"mini_logo_uri"]];
            
            [button setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
        }
        
    }
}

- (IBAction)buttonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [self.delegate HomeBtnCellButtonPressedWithServiceInfo:_cellServices[button.tag-1]];
}

@end
