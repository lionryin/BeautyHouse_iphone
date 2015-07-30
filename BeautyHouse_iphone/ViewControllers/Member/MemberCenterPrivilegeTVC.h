//
//  MemberCenterPrivilegeTVC.h
//  BeautyHouse
//
//  Created by Roy on 15/3/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface MemberPrivilegeVO : NSObject
@property (nonatomic,strong)NSString *imageName;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *detail;
@end




@interface MemberCenterPrivilegeTVC : BaseTVC


- (void)updateCellWithLPrivilegeVO:(MemberPrivilegeVO *)lVO andRPrivilegeVO:(MemberPrivilegeVO *)rVO;



@end
