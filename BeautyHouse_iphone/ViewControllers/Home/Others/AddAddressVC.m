//
//  AddAddressVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AddAddressVC.h"
#import "QuyuVC.h"

@interface AddAddressVC ()<QuyuVCDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *quyuTF;
- (IBAction)quyuButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *xiaoquTF;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTF;
- (IBAction)querenButtonClicked:(id)sender;

@end

@implementation AddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加服务地址";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_xiaoquTF resignFirstResponder];
    [_detailAddressTF resignFirstResponder];
}

#pragma mark - IBAction
- (IBAction)quyuButtonClicked:(id)sender {
    QuyuVC *quyuVC = [[QuyuVC alloc] init];
    quyuVC.delegate = self;
    [self.navigationController pushViewController:quyuVC animated:YES];
}

- (IBAction)querenButtonClicked:(id)sender {
    
    if (_quyuTF.text == nil || [_quyuTF.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择一个区域" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_xiaoquTF.text == nil || [_xiaoquTF.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入小区名称" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (_detailAddressTF.text == nil || [_detailAddressTF.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入详细地址" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        [self.delegate AddAddressVCAddAddressQuyu:_quyuTF.text andXiaoqu:_xiaoquTF.text andDetailAddress:_detailAddressTF.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - quyuVC delegate
- (void)quyuVCSelectedQuyu:(NSString *)quyu{
    self.quyuTF.text = quyu;
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}


@end
