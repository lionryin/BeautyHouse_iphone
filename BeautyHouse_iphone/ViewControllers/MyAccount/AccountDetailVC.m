//
//  AccountDetailVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AccountDetailVC.h"
#import "AccountFamilyStewardVC.h"
#import "AccountRechargeRecordVC.h"
#import "AccountRechargeVC.h"
#import "AccountExpenseRecordVC.h"

#import "MZBWebService.h"


@interface AccountDetailVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
//@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic,assign)CGFloat balance;



@end

@implementation AccountDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户详情";
    self.balance = 0.00;
    [self initMainUI];
    
    [self getCashBalance];
    // Do any additional setup after loading the view.
}

- (void)initMainUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [UIColor clearColor];

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [self.view addSubview:self.collectionView];
    
}

- (NSString *)getUserLoginId{
    NSString *userId = nil;
    
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    userId = [userDic objectForKey:UserLoginId];
    
    return userId;
}

- (void)getCashBalance{
    
    if ([self getUserLoginId]) {
        NSString *jsonParam = [NSString stringWithFormat:@"{\"id\":\"%@\"}",[self getUserLoginId]];
        AFHTTPRequestOperation *opration = [MZBWebService getUserBalanceWithParameter:jsonParam];
        
        [opration start];
        
        [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
            NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            
            MyPaser *parser = [[MyPaser alloc] initWithContent:result];
            [parser BeginToParse];
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@",dic);
            NSNumber *rst = dic[@"result"];
            if (rst.integerValue == 0) {
                
                NSNumber *balanceNumber = dic[@"resultInfo"];
                self.balance = balanceNumber.floatValue;
                
                [self.collectionView reloadData];
                
            }else{
                
                //                UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:dic[@"resultInfo"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                //
                //                [av show];
            }
            
            
            
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            
        }];
        
    }else{
        
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请返回个人中心登录" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
    }

    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(36, 20, 37, 35)];
    [cell.contentView addSubview:iv];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, cell.frame.size.width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor darkGrayColor];
    [cell.contentView addSubview:label];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-0.5, cell.frame.size.width, 0.5)];
    bottomLine.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1.0];
    [cell.contentView addSubview:bottomLine];
    
    UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(cell.frame.size.width-0.5, 0, 0.5, cell.frame.size.height)];
    rightLine.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1.0];
    [cell.contentView addSubview:rightLine];
    
    switch (indexPath.row) {
        case 0:
        {
            [iv setImage:[UIImage imageNamed:@"accountDetail01"]];
            label.text = @"家庭管家";
        
            break;
        }
        case 1:
        {
            
            [iv setImage:[UIImage imageNamed:@"accountDetail02"]];
            label.text = @"消费记录";
            break;
        }
        case 2:
        {
            [iv setImage:[UIImage imageNamed:@"accountDetail03"]];
            label.text = @"在线充值";
            
            break;
        }
        case 3:
        {
            
            [iv setImage:[UIImage imageNamed:@"accountDetail04"]];
            label.text = @"充值记录";
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                           withReuseIdentifier:@"Header"
                                                                                  forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        
        for (UIView *view in header.subviews) {
            [view removeFromSuperview];
        }
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, header.frame.size.width, header.frame.size.height)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor darkTextColor];
        [header addSubview:label];
        
        label.text = [NSString stringWithFormat:@"     账户余额:         %.2f",self.balance];
        
        UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, header.frame.size.height-0.5, header.frame.size.width, 0.5)];
        bottomLine.backgroundColor = [UIColor colorWithRed:210.0/255 green:210.0/255 blue:210.0/255 alpha:1.0];
        [header addSubview:bottomLine];
        
        
        return header;
        
    }
    
    return nil;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            AccountFamilyStewardVC *vc = [AccountFamilyStewardVC new];
            [self.navigationController pushViewController:vc animated:YES];

            break;
        }
        case 1:
        {

            AccountExpenseRecordVC *vc = [AccountExpenseRecordVC new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {

           AccountRechargeVC *vc = [AccountRechargeVC new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {

            AccountRechargeRecordVC *vc = [AccountRechargeRecordVC new];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }

    
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/3.0, self.view.frame.size.width/3.0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.frame.size.width, 44);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
