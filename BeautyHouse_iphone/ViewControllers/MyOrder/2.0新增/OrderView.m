//
//  OrderView.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "OrderView.h"
#import "MenuHrizontal.h"
#import "ScrollPageView.h"

#define MENUHEIHT 30

@interface OrderView() <MenuHrizontalDelegate, ScrollPageViewDelegate>

@property (strong, nonatomic) MenuHrizontal  *mMenuHriZontal;
@property (strong, nonatomic) ScrollPageView *mScrollPageView;

@end

@implementation OrderView

- (id)initWithFrame:(CGRect)frame {
    self                 = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commInit];
    }
    return self;
}

#pragma mark UI初始化
-(void)commInit{
    self.backgroundColor = [UIColor clearColor];

    int itemWith = (int)(self.frame.size.width/6);
    
    NSArray *vButtonItemArray = @[@{NOMALKEY: @"normal.png",
                                    HEIGHTKEY:@"helight.png",
                                    TITLEKEY:@"全部",
                                    TITLEWIDTH:[NSNumber numberWithInt:itemWith]
                                    },
                                  @{NOMALKEY: @"normal.png",
                                    HEIGHTKEY:@"helight.png",
                                    TITLEKEY:@"待分配",
                                    TITLEWIDTH:[NSNumber numberWithInt:itemWith]
                                    },
                                  @{NOMALKEY: @"normal",
                                    HEIGHTKEY:@"helight",
                                    TITLEKEY:@"已分配",
                                    TITLEWIDTH:[NSNumber numberWithInt:itemWith]
                                    },
                                  @{NOMALKEY: @"normal",
                                    HEIGHTKEY:@"helight",
                                    TITLEKEY:@"已支付",
                                    TITLEWIDTH:[NSNumber numberWithInt:itemWith]
                                    },
                                  @{NOMALKEY: @"normal",
                                    HEIGHTKEY:@"helight",
                                    TITLEKEY:@"已评价",
                                    TITLEWIDTH:[NSNumber numberWithInt:itemWith]
                                    },
                                  @{NOMALKEY: @"normal",
                                    HEIGHTKEY:@"helight",
                                    TITLEKEY:@"已取消",
                                    TITLEWIDTH:[NSNumber numberWithInt:itemWith]
                                    }
                                    ];
    
    if (_mMenuHriZontal == nil) {
        _mMenuHriZontal = [[MenuHrizontal alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, MENUHEIHT) ButtonItems:vButtonItemArray];
        _mMenuHriZontal.delegate = self;
    }
    //初始化滑动列表
    NSArray *status = @[@{StatusKey:@"", NextPageKey:@""}, @{StatusKey:@"32", NextPageKey:@""}, @{StatusKey:@"33", NextPageKey:@""}, @{StatusKey:@"34", NextPageKey:@""}, @{StatusKey:@"35", NextPageKey:@""}, @{StatusKey:@"78", NextPageKey:@""}];
    if (_mScrollPageView == nil) {
        _mScrollPageView = [[ScrollPageView alloc] initWithFrame:CGRectMake(0, MENUHEIHT, self.frame.size.width, self.frame.size.height - MENUHEIHT)    statusOfPage:status];
        _mScrollPageView.delegate = self;
    }
    [_mScrollPageView setContentOfTables:vButtonItemArray.count];
    //默认选中第一个button
    [_mMenuHriZontal clickButtonAtIndex:0];
    //-------
    [self addSubview:_mScrollPageView];
    [self addSubview:_mMenuHriZontal];
}

#pragma mark MenuHrizontalDelegate
-(void)didMenuHrizontalClickedButtonAtIndex:(NSInteger)aIndex{
    NSLog(@"第%ld个Button点击了",(long)aIndex);
    [_mScrollPageView moveScrollowViewAthIndex:aIndex];
}

#pragma mark ScrollPageViewDelegate
-(void)didScrollPageViewChangedPage:(NSInteger)aPage{
    NSLog(@"CurrentPage:%ld",(long)aPage);
    [_mMenuHriZontal changeButtonStateAtIndex:aPage];
    //    if (aPage == 3) {
    //刷新当页数据
    [_mScrollPageView freshContentTableAtIndex:aPage];
    //    }
}

- (void)commentOrder:(NSDictionary *)orderItem {
    if ([self.delegate respondsToSelector:@selector(orderViewCommentOrder:)]) {
        [self.delegate orderViewCommentOrder:orderItem];
    }
}

- (void)zhifuOrder:(NSDictionary *)orderItem {
    if ([self.delegate respondsToSelector:@selector(orderviewZhifuOrder:)]) {
        [self.delegate orderviewZhifuOrder:orderItem];
    }
}


@end
