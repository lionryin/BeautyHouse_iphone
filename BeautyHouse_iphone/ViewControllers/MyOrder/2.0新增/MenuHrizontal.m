//
//  MenuHrizontal.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "MenuHrizontal.h"


@interface MenuHrizontal()

@property (strong, nonatomic) NSMutableArray *mButtonArray;
@property (strong, nonatomic) NSMutableArray *mItemInfoArray;
@property (strong, nonatomic) UIScrollView   *mScrollView;
@property (nonatomic        ) float          mTotalWidth;

@end

@implementation MenuHrizontal

- (id)initWithFrame:(CGRect)frame ButtonItems:(NSArray *)aItemsArray {
    self = [super initWithFrame:frame];
    if (self) {
        if (_mButtonArray == nil) {
            _mButtonArray = [[NSMutableArray alloc] init];
        }
        if (_mScrollView == nil) {
            _mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            _mScrollView.showsHorizontalScrollIndicator = NO;
        }
        if (_mItemInfoArray == nil) {
            _mItemInfoArray = [[NSMutableArray alloc]init];
        }
        
        [_mItemInfoArray removeAllObjects];
        [self createMenuItems:aItemsArray];
    }
    return self;
}

-(void)createMenuItems:(NSArray *)aItemsArray{
    int i = 0;
    float menuWidth = 0.0;
    for (NSDictionary *lDic in aItemsArray) {
        NSString *vNormalImageStr = [lDic objectForKey:NOMALKEY];
        NSString *vHeligtImageStr = [lDic objectForKey:HEIGHTKEY];
        NSString *vTitleStr = [lDic objectForKey:TITLEKEY];
        float vButtonWidth = [[lDic objectForKey:TITLEWIDTH] floatValue];
        UIButton *vButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [vButton setBackgroundImage:[UIImage imageNamed:vNormalImageStr] forState:UIControlStateNormal];
        [vButton setBackgroundImage:[UIImage imageNamed:vHeligtImageStr] forState:UIControlStateSelected];
        [vButton setTitle:vTitleStr forState:UIControlStateNormal];
        [vButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [vButton setTitleColor:[UIColor colorWithRed:0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateSelected];
        [vButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vButton setTag:i];
        [vButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [vButton setFrame:CGRectMake(menuWidth, 0, vButtonWidth, self.frame.size.height)];
        [_mScrollView addSubview:vButton];
        [_mButtonArray addObject:vButton];
        
        menuWidth += vButtonWidth;
        i++;
        
        //保存button资源信息，同时增加button.oringin.x的位置，方便点击button时，移动位置。
        NSMutableDictionary *vNewDic = [lDic mutableCopy];
        [vNewDic setObject:[NSNumber numberWithFloat:menuWidth] forKey:TOTALWIDTH];
        [_mItemInfoArray addObject:vNewDic];
    }
    
    [_mScrollView setContentSize:CGSizeMake(menuWidth, self.frame.size.height)];
    [self addSubview:_mScrollView];
    // 保存menu总长度，如果小于屏幕宽度则不需要移动，方便点击button时移动位置的判断
    _mTotalWidth = menuWidth;
}

#pragma mark - action
-(void)menuButtonClicked:(UIButton *)aButton{
    [self changeButtonStateAtIndex:aButton.tag];
    if ([_delegate respondsToSelector:@selector(didMenuHrizontalClickedButtonAtIndex:)]) {
        [_delegate didMenuHrizontalClickedButtonAtIndex:aButton.tag];
    }
}


#pragma mark - 其他辅助功能
//取消所有button点击状态
-(void)changeButtonsToNormalState{
    for (UIButton *vButton in _mButtonArray) {
        vButton.selected = NO;
    }
}

//选中第某个button
-(void)clickButtonAtIndex:(NSInteger)aIndex{
    UIButton *vButton = [_mButtonArray objectAtIndex:aIndex];
    [self menuButtonClicked:vButton];
}

//改变第几个button为选中状态，不发送delegate
-(void)changeButtonStateAtIndex:(NSInteger)aIndex{
    UIButton *vButton = [_mButtonArray objectAtIndex:aIndex];
    [self changeButtonsToNormalState];
    vButton.selected = YES;
    [self moveScrolViewWithIndex:aIndex];
}

#pragma mark 移动button到可视的区域
-(void)moveScrolViewWithIndex:(NSInteger)aIndex{
    if (_mItemInfoArray.count < aIndex) {
        return;
    }
    //宽度小于self的宽度肯定不需要移动
    if (_mTotalWidth <= self.frame.size.width) {
        return;
    }
    NSDictionary *vDic = [_mItemInfoArray objectAtIndex:aIndex];
    float vButtonOrigin = [[vDic objectForKey:TOTALWIDTH] floatValue];
    if (vButtonOrigin >= 300) {
        if ((vButtonOrigin + 180) >= _mScrollView.contentSize.width) {
            [_mScrollView setContentOffset:CGPointMake(_mScrollView.contentSize.width - 320, _mScrollView.contentOffset.y) animated:YES];
            return;
        }
        
        float vMoveToContentOffset = vButtonOrigin - 180;
        if (vMoveToContentOffset > 0) {
            [_mScrollView setContentOffset:CGPointMake(vMoveToContentOffset, _mScrollView.contentOffset.y) animated:YES];
        }
        //        NSLog(@"scrollwOffset.x:%f,ButtonOrigin.x:%f,mscrollwContentSize.width:%f",mScrollView.contentOffset.x,vButtonOrigin,mScrollView.contentSize.width);
    }else{
        [_mScrollView setContentOffset:CGPointMake(0, _mScrollView.contentOffset.y) animated:YES];
        return;
    }
}


@end
