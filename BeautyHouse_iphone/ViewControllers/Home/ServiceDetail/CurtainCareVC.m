//
//  CurtainCareVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CurtainCareVC.h"

@interface CurtainCareVC ()

@property (nonatomic) NSInteger curtainNumbers;

- (IBAction)slectCutButtonPressed:(id)sender;
- (IBAction)slectPlusButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *curtainNumTF;

@end

@implementation CurtainCareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.curtainNumbers = 1;
    [self resetCurtainNumTFWithCurtainNunbers:self.curtainNumbers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)resetCurtainNumTFWithCurtainNunbers:(NSInteger)num{
    self.curtainNumTF.text = [NSString stringWithFormat:@"%ld",(long)num
                            ];
}

#pragma mark - IBAction

- (IBAction)slectCutButtonPressed:(id)sender {
    if (self.curtainNumbers > 0) {
        [self resetCurtainNumTFWithCurtainNunbers:--self.curtainNumbers];
    }
    
}

- (IBAction)slectPlusButtonPressed:(id)sender {
    [self resetCurtainNumTFWithCurtainNunbers:++self.curtainNumbers];
}


@end
