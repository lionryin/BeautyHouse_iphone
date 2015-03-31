//
//  NurseVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "NurseVC.h"

@interface NurseVC ()<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *xingTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;

- (IBAction)xingTFClicked:(id)sender;
- (IBAction)ageTFClicked:(id)sender;

@end

@implementation NurseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)xingTFClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"一星",@"二星",@"三星",@"四星",@"五星", nil];
    actionSheet.tag = 999;
    [actionSheet showInView:self.view];
}

- (IBAction)ageTFClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"30~35",@"35~40",@"40~45", nil];
    actionSheet.tag = 1000;
    [actionSheet showInView:self.view];
}

#pragma mark - actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 999) {
        NSLog(@"%li",(long)buttonIndex);
        if (buttonIndex == 0) {
            _xingTF.text = @"一星";
        }
        else if (buttonIndex == 1){
            _xingTF.text = @"二星";
        }
        else if (buttonIndex == 2){
            _xingTF.text = @"三星";
        }
        else if (buttonIndex == 3){
            _xingTF.text = @"四星";
        }
        else if (buttonIndex == 4){
            _xingTF.text = @"五星";
        }
    }
    else if (actionSheet.tag == 1000){
        NSLog(@"%li",(long)buttonIndex);
        if (buttonIndex == 0) {
            _ageTF.text = @"30~35";
        }
        else if (buttonIndex == 1){
            _ageTF.text = @"35~40";
        }
        else if (buttonIndex == 2){
            _ageTF.text = @"40~45";
        }

    }
}

@end
