//
//  CleanerVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CleanerVC.h"
#import "XiaohaopinVC.h"

@interface CleanerVC ()<XiaohaopinVCDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *xiaohaopinImageView;
- (IBAction)xiaohaopinButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *bjtcImageView;
- (IBAction)bjtcButtonPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *moreDemandImageView;

@property (nonatomic) NSInteger slectedXhpTag;
@property (nonatomic) NSInteger slectedBjtcTag;

@property (weak, nonatomic) IBOutlet UILabel *xhpLabel;
@property (strong, nonatomic) NSString *xhp;
@property (weak, nonatomic) IBOutlet UILabel *bjtcLabel;
@property (strong, nonatomic) NSString *bjtc;
@property (strong, nonatomic) NSString *moreDemand;


@end

@implementation CleanerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _slectedXhpTag = 0;
    _slectedBjtcTag = 0;
    _xhp = @"";
    _bjtc = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)spliceJsonParam{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSLog(@"userId:%@",userId);
    
    return [NSString stringWithFormat:@"{\"sex\":null,\"orderDateTime\":null,\"serviceDate\":\"%@\",\"memo\":null,\"deductions\":null,\"houseSize\":null,\"ageInterval\":null,\"registeredUser\":null,\"checkOrderInfo\":null,\"auntInfo\":null,\"auntId\":null,\"orderDateTimeStart\":null,\"dictionarys\":null,\"id\":null,\"orderDateTimeEnd\":null,\"level\":null,\"serviceUser\":null,\"consumables\":null,\"otherNeed\":\"%@\",\"registeredUserId\":\"%@\",\"serviceCategory\":{\"sign\":null,\"id\":\"%@\",\"urllink\":null,\"parentId\":null,\"price\":null,\"level\":null,\"description\":null,\"priceDescription\":null,\"servicePhoto\":null,\"serviceName\":null},\"cleaningKit\":null,\"orderStatue\":null,\"completeTime\":null,\"serviceAddress\":{\"id\":\"%@\",\"registeredUserId\":null,\"cellName\":null,\"memo\":null,\"regionalInfo\":null,\"detailAddress\":null}}", self.timeTF.text,_moreDemand,userId,self.serviceInfo[@"id"],self.mzbAddress.addressID];

}

#pragma mark - IBAction

- (IBAction)xiaohaopinButtonPressed:(id)sender {
    XiaohaopinVC *xiaohaopinVC = [[XiaohaopinVC alloc] initWithNibName:@"XiaohaopinVC" bundle:nil];
    xiaohaopinVC.delegate = self;
    xiaohaopinVC.title = @"消耗品";
    xiaohaopinVC.selectedXhpTag = _slectedXhpTag;
    xiaohaopinVC.selectedBjtcTag = 0;
    [self.navigationController pushViewController:xiaohaopinVC animated:YES];
}
- (IBAction)bjtcButtonPressed:(id)sender {
    XiaohaopinVC *xiaohaopinVC = [[XiaohaopinVC alloc] initWithNibName:@"XiaohaopinVC" bundle:nil];
    xiaohaopinVC.delegate = self;
    xiaohaopinVC.title = @"保洁套餐";
    xiaohaopinVC.selectedBjtcTag = _slectedBjtcTag;
    xiaohaopinVC.selectedXhpTag = 0;
    [self.navigationController pushViewController:xiaohaopinVC animated:YES];
}

- (IBAction)moreDemondButtonPressed:(id)sender{
    MoreDemandVC *moreDemandVC = [[MoreDemandVC alloc] initWithNibName:@"MoreDemandVC" bundle:nil];
    moreDemandVC.delegate = self;
    moreDemandVC.moreDemand = _moreDemand;
    [self.navigationController pushViewController:moreDemandVC animated:YES];
}

#pragma mark - XiaohaopinVCDelegate
- (void)xiaohaopinVCIsXhpOrBjtc:(NSString *)name andContent:(NSString *)content andSelectedImageViewTag:(NSInteger)imageViewtag{
    
    if ([name isEqualToString:@"消耗品"]) {
        _xhp = content;
        _slectedXhpTag = imageViewtag;
        if ([content isEqualToString:@""]) {
            _xiaohaopinImageView.highlighted = NO;
            _xhpLabel.text = @"消耗品";
        }
        else{
            _xiaohaopinImageView.highlighted = YES;
            _xhpLabel.text = content;
        }
    }
    else if ([name isEqualToString:@"保洁套餐"]){
        _bjtc = content;
        _slectedBjtcTag = imageViewtag;
        if ([content isEqualToString:@""]) {
            _bjtcImageView.highlighted = NO;
            _bjtcLabel.text = @"保洁套餐";
        }
        else{
            _bjtcImageView.highlighted = YES;
            _bjtcLabel.text = content;
        }

    }
    
}

#pragma mark - MoreDemandVCDelegate
- (void)moreDemandVCGetDemand:(NSString *)demand{
    _moreDemand = demand;
    
    if ([demand isEqualToString:@""] || demand == nil) {
        _moreDemandImageView.highlighted = NO;
    }
    else{
        _moreDemandImageView.highlighted = YES;
    }
}


@end
