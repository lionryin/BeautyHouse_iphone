//
//  MemberCenterJoinTVC.h
//  BeautyHouse
//
//  Created by Roy on 15/3/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "BaseTVC.h"

@interface JoinMemberVO : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *detail;
@end


@class MemberCenterJoinTVC;
@protocol MemberCenterJoinTVCDelegate <NSObject>

- (void)joinBtnClickedWithMemberCenterJoinTVC:(MemberCenterJoinTVC *)cell;


@end


@interface MemberCenterJoinTVC : BaseTVC

@property (nonatomic,weak)id<MemberCenterJoinTVCDelegate>delegate;

- (void)updateCellWithJoinMemberVO:(JoinMemberVO *)joinMemberVO;

@end
