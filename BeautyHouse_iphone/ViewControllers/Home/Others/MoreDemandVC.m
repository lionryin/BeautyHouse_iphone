//
//  MoreDemandVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MoreDemandVC.h"

@interface MoreDemandVC ()
@property (weak, nonatomic) IBOutlet UITextView *demandTextView;

- (IBAction)buttonPressed:(id)sender;

- (IBAction)quedingButtonPressed:(id)sender;

@end

@implementation MoreDemandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"更多个性需求";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _demandTextView.text = _moreDemand;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_demandTextView resignFirstResponder];
}

#pragma mark - IBAction
- (IBAction)buttonPressed:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    _demandTextView.text = [NSString stringWithFormat:@"%@%@",_demandTextView.text,button.titleLabel.text];
}

- (IBAction)quedingButtonPressed:(id)sender {
    [self.delegate moreDemandVCGetDemand:_demandTextView.text];
    [self.navigationController popViewControllerAnimated:YES];
}



@end
