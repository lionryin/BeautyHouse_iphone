//
//  XiaohaopinVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/3/30.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "XiaohaopinVC.h"

@interface XiaohaopinVC ()

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

- (IBAction)button1Pressed:(id)sender;
- (IBAction)button2Pressed:(id)sender;
- (IBAction)button3Pressed:(id)sender;

@end

@implementation XiaohaopinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_selectedXhpTag == _imageView1.tag || _selectedBjtcTag == _imageView1.tag) {
        _imageView1.highlighted = YES;
    }
    else if (_selectedXhpTag == _imageView2.tag || _selectedBjtcTag == _imageView2.tag){
        _imageView2.highlighted = YES;
    }
    else if (_selectedXhpTag == _imageView3.tag || _selectedBjtcTag == _imageView3.tag){
        _imageView3.highlighted = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction

- (IBAction)button1Pressed:(id)sender {
    _imageView1.highlighted = !_imageView1.highlighted;
    if (_imageView1.highlighted) {
        _imageView2.highlighted = NO;
        _imageView3.highlighted = NO;
        [self.delegate xiaohaopinVCIsXhpOrBjtc:self.title andContent:_label1.text andSelectedImageViewTag:_imageView1.tag];
    }
    else{
        [self.delegate xiaohaopinVCIsXhpOrBjtc:self.title andContent:@"" andSelectedImageViewTag:0];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)button2Pressed:(id)sender {
    _imageView2.highlighted = !_imageView2.highlighted;
    if (_imageView2.highlighted) {
        _imageView1.highlighted = NO;
        _imageView3.highlighted = NO;
        [self.delegate xiaohaopinVCIsXhpOrBjtc:self.title andContent:_label2.text andSelectedImageViewTag:_imageView2.tag];
    }
    else{
        [self.delegate xiaohaopinVCIsXhpOrBjtc:self.title andContent:@"" andSelectedImageViewTag:0];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)button3Pressed:(id)sender {
    _imageView3.highlighted = !_imageView3.highlighted;
    if (_imageView3.highlighted) {
        _imageView1.highlighted = NO;
        _imageView2.highlighted = NO;
        [self.delegate xiaohaopinVCIsXhpOrBjtc:self.title andContent:_label3.text andSelectedImageViewTag:_imageView3.tag];
    }
    else{
        [self.delegate xiaohaopinVCIsXhpOrBjtc:self.title andContent:@"" andSelectedImageViewTag:0];
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
