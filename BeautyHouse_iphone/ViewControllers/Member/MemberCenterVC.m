//
//  MemberCenterVC.m
//  BeautyHouse
//
//  Created by Roy on 15/3/22.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MemberCenterVC.h"
#import "MemberCenterJoinTVC.h"
#import "MemberCenterPrivilegeTVC.h"
#import "MemberVO.h"
#import "MZBWebService.h"

@interface MemberCenterVC ()<UITableViewDataSource,UITableViewDelegate,MemberCenterJoinTVCDelegate>


@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *memberList;
@property (nonatomic,strong)NSMutableArray *privilegeList;

@end

@implementation MemberCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"会员";
    
    [self initMainUI];
    [self initData];
    // Do any additional setup after loading the view.
}


- (void)initMainUI{
    
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)initData{
    if (self.memberList == nil) {
        self.memberList = [[NSMutableArray alloc]init];
    }
    
    AFHTTPRequestOperation *opration = [MZBWebService getAllMemberTypeWithParameter:nil];
    
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
            
            NSArray *list = dic[@"resultInfo"];
            
            for (NSDictionary *dic in list) {
                MemberVO *memberVO = [[MemberVO alloc]init];
                [memberVO parseWithDic:dic];
                [self.memberList addObject:memberVO];
            }
            
            [self.tableView reloadData];
            
        }
        
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];

    /*
    JoinMemberVO *memberVO1=[[JoinMemberVO alloc]init];
    memberVO1.title = @"金卡:";
    memberVO1.detail = @"充100(返50)";
    [self.memberList addObject:memberVO1];
    
    JoinMemberVO *memberVO2=[[JoinMemberVO alloc]init];
    memberVO2.title = @"白金卡:";
    memberVO2.detail = @"充200(返100)";
    [self.memberList addObject:memberVO2];
    
    JoinMemberVO *memberVO3=[[JoinMemberVO alloc]init];
    memberVO3.title = @"钻石卡:";
    memberVO3.detail = @"充500(返300)";
    [self.memberList addObject:memberVO3];*/
    
    if (self.privilegeList == nil) {
        self.privilegeList = [[NSMutableArray alloc] init];
    }
    MemberPrivilegeVO *privilegeVO1 = [[MemberPrivilegeVO alloc]init];
    privilegeVO1.imageName = @"join_04";
    privilegeVO1.title = @"充值赠送";
    privilegeVO1.detail = @"充得多,返的多";
    [self.privilegeList addObject:privilegeVO1];
    
    
    MemberPrivilegeVO *privilegeVO2 = [[MemberPrivilegeVO alloc]init];
    privilegeVO2.imageName = @"join_05";
    privilegeVO2.title = @"专属管家";
    privilegeVO2.detail = @"7x24小时,1对1服务";
    [self.privilegeList addObject:privilegeVO2];
    
    MemberPrivilegeVO *privilegeVO3 = [[MemberPrivilegeVO alloc]init];
    privilegeVO3.imageName = @"join_06";
    privilegeVO3.title = @"一卡通用";
    privilegeVO3.detail = @"一卡在手,家务无忧";
    [self.privilegeList addObject:privilegeVO3];
    
    MemberPrivilegeVO *privilegeVO4 = [[MemberPrivilegeVO alloc]init];
    privilegeVO4.imageName = @"join_07";
    privilegeVO4.title = @"会员支付";
    privilegeVO4.detail = @"安全,便捷,方便";
    [self.privilegeList addObject:privilegeVO4];
    
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.memberList.count;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *reuse = @"JoinTVC";
        
        MemberCenterJoinTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (cell == nil) {
            cell = [[MemberCenterJoinTVC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
            cell.delegate = self;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        MemberVO *memberVO = [self.memberList objectAtIndex:indexPath.row];
        [cell updateCellWithJoinMemberVO:memberVO];
        return cell;
        
    }else{
        
        static NSString *reuse = @"PrivilegeTVC";
        
        MemberCenterPrivilegeTVC *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
        if (cell == nil) {
            cell = [[MemberCenterPrivilegeTVC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        
        NSUInteger row = indexPath.row;
        
        MemberPrivilegeVO *lVO = [self.privilegeList objectAtIndex:2*row];
        MemberPrivilegeVO *rVO = [self.privilegeList objectAtIndex:2*row+1];
        
        [cell updateCellWithLPrivilegeVO:lVO andRPrivilegeVO:rVO];
        
        
        return cell;
        
    }
    
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 44;
    }
    return 100;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"加入会员";
    }else{
        return @"会员特权";
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 1) {
        return 20;
    }
    return 0.01;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MemberCenterPrivilegeTVC Delegate
- (void)joinBtnClickedWithMemberCenterJoinTVC:(MemberCenterJoinTVC *)cell{
    
}


#pragma mark - MemberCenterJoinTVC Delegate
@end
