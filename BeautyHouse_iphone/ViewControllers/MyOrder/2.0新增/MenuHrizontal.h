//
//  MenuHrizontal.h
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NOMALKEY   @"normalKey"
#define HEIGHTKEY  @"helightKey"
#define TITLEKEY   @"titleKey"
#define TITLEWIDTH @"titleWidth"
#define TOTALWIDTH @"totalWidth"

@protocol MenuHrizontalDelegate <NSObject>

@optional
-(void)didMenuHrizontalClickedButtonAtIndex:(NSInteger)aIndex;
@end


@interface MenuHrizontal : UIView

@property (nonatomic,assign) id <MenuHrizontalDelegate> delegate;


/**
 *  初始化菜单
 *
 *  @param frame
 *  @param aItemsArray
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame ButtonItems:(NSArray *)aItemsArray;

/**
 *  选中某个button
 *
 *  @param aIndex
 */
-(void)clickButtonAtIndex:(NSInteger)aIndex;

/**
 *  改变第几个button为选中状态，不发送delegate
 *
 *  @param aIndex
 */
-(void)changeButtonStateAtIndex:(NSInteger)aIndex;


@end
