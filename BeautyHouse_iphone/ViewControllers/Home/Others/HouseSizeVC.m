//
//  HouseSizeVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "HouseSizeVC.h"

@interface HouseSizeVC ()

@property (weak, nonatomic) IBOutlet UITextField *sizeTF;
- (IBAction)quedingButtonPressed:(id)sender;

@end

@implementation HouseSizeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"房屋平米数";
    
    if (_houseSize) {
        _sizeTF.text = _houseSize;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [_sizeTF becomeFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_sizeTF resignFirstResponder];
}

#pragma mark - IBAction

- (IBAction)quedingButtonPressed:(id)sender {
    if (_sizeTF.text.length == 0) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"房屋大小不能为空" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
        return;
    }
    else{
        [self.delegate houseSizeVCGetHouseSize:_sizeTF.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
