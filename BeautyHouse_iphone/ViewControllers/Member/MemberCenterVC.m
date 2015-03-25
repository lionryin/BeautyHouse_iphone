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
    [self.view addSubview:self.tableView];
}

- (void)initData{
    if (self.memberList == nil) {
        self.memberList = [[NSMutableArray alloc]init];
    }
    
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
    [self.memberList addObject:memberVO3];
    
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
        return 3;
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
        JoinMemberVO *memberVO = [self.memberList objectAtIndex:indexPath.row];
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
    return 110;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
