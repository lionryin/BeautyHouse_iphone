//
//  OrderPayVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "OrderPayVC.h"

@interface OrderPayVC ()<UITextFieldDelegate>
- (IBAction)payButtonSelecked:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;

@end

@implementation OrderPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"订单支付";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)payButtonSelecked:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 1:{//支付宝
            _imageView1.highlighted = !_imageView1.highlighted;
            _imageView2.highlighted = NO;
            _imageView3.highlighted = NO;
            _imageView4.highlighted = NO;
            
            break;
        }
        case 2:{//现金
            
            _imageView2.highlighted = !_imageView2.highlighted;
            _imageView1.highlighted = NO;
            _imageView3.highlighted = NO;
            _imageView4.highlighted = NO;
            
            break;
        }
        case 3:{//微信
            
            _imageView3.highlighted = !_imageView3.highlighted;
            _imageView2.highlighted = NO;
            _imageView1.highlighted = NO;
            _imageView4.highlighted = NO;
            
            break;
        }
        case 4:{//余额
            
            _imageView4.highlighted = !_imageView4.highlighted;
            _imageView2.highlighted = NO;
            _imageView3.highlighted = NO;
            _imageView1.highlighted = NO;
            
            break;
        }
        default:
            break;
    }
}



#pragma mark - TextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
