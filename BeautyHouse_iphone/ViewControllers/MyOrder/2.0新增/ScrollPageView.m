//
//  ScrollPageView.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ScrollPageView.h"

#import "MZBHttpService.h"

#import "OrderPayVC.h"
#import "CommentAunt.h"

@implementation ScrollPageView

- (id)initWithFrame:(CGRect)frame statusOfPage:(NSArray *)status{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _statusOfPage = [status mutableCopy];
        _freshPage0 = NO;
        _freshPage1 = NO;
        _freshPage2 = NO;
        _freshPage3 = NO;
        _freshPage4 = NO;
        _freshPage5 = NO;
        [self commInit];
    }
    return self;
}

-(void)commInit{
    
    if (_hud == nil) {
        _hud = [[MBProgressHUD alloc] initWithView:self];
    }
    [self addSubview:_hud];
    
    if (_contentItems == nil) {
        _contentItems = [[NSMutableArray alloc] init];
    }
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        NSLog(@"ScrollViewFrame:(%f,%f)",self.frame.size.width,self.frame.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    [self addSubview:_scrollView];
}

#pragma mark 添加ScrollowViewd的ContentView
-(void)setContentOfTables:(NSInteger)aNumerOfTables{
    for (int i = 0; i < aNumerOfTables; i++) {
        CustomTableView *vCustomTableView = [[CustomTableView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        vCustomTableView.delegate = self;
        vCustomTableView.dataSource = self;
        //为table添加嵌套HeadderView
        //[self addLoopScrollowView:vCustomTableView];
        [_scrollView addSubview:vCustomTableView];
        [_contentItems addObject:vCustomTableView];
    }
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width * aNumerOfTables, self.frame.size.height)];
}

#pragma mark 移动ScrollView到某个页面
-(void)moveScrollowViewAthIndex:(NSInteger)aIndex{

    CGRect vMoveRect = CGRectMake(self.frame.size.width * aIndex, 0, self.frame.size.width, self.frame.size.width);
    [_scrollView scrollRectToVisible:vMoveRect animated:YES];
    _mCurrentPage= aIndex;
    if ([_delegate respondsToSelector:@selector(didScrollPageViewChangedPage:)]) {
        [_delegate didScrollPageViewChangedPage:_mCurrentPage];
    }
}

#pragma mark 刷新某个页面


//是否强制刷新
- (BOOL)isFreshPageWithAIndex:(NSInteger)aIndex {
    if (aIndex == 0 && _freshPage0) {
        return YES;
    }
    else if (aIndex == 1 && _freshPage1){
        return YES;
    }
    else if (aIndex == 2 && _freshPage2){
        return YES;
    }
    else if (aIndex == 3 && _freshPage3){
        return YES;
    }
    else if (aIndex == 4 && _freshPage4){
        return YES;
    }
    else if (aIndex == 5 && _freshPage5){
        return YES;
    }
    else {
        return NO;
    }
}

-(void)freshContentTableAtIndex:(NSInteger)aIndex{
    NSLog(@"aIndex:%li",aIndex);
    
    if (_contentItems.count < aIndex) {
        return;
    }
    CustomTableView *vTableContentView =(CustomTableView *)[_contentItems objectAtIndex:aIndex];
    if (vTableContentView.tableInfoArray.count == 0 || [self isFreshPageWithAIndex:aIndex]) {
        [vTableContentView setupRefresh:[NSString stringWithFormat:@"%li",(long)aIndex]];
        
        if (aIndex == 0) {
            _freshPage0 = NO;
        }
        else if (aIndex == 1) {
            _freshPage1 = NO;
        }
        else if (aIndex == 2) {
            _freshPage2 = NO;
        }
        else if (aIndex == 3) {
            _freshPage3 = NO;
        }
        else if (aIndex == 4) {
            _freshPage4 = NO;
        }
        else if (aIndex == 5) {
            _freshPage5 = NO;
        }
    }
   
}


#pragma mark - UIScrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/self.frame.size.width;
    
    if (_mCurrentPage == page) {
        return;
    }
    _mCurrentPage= page;
    if ([_delegate respondsToSelector:@selector(didScrollPageViewChangedPage:)]) {
        [_delegate didScrollPageViewChangedPage:_mCurrentPage];
    }
}

#pragma mark - CustomTableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView FromView:(CustomTableView *)aView {
    return aView.tableInfoArray.count;
}
-(NSInteger)numberOfRowsInTableView:(UITableView *)aTableView InSection:(NSInteger)section FromView:(CustomTableView *)aView{
    return 1;
}

-(UITableViewCell *)cellForRowInTableView:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView{
    static NSString *vCellIdentify = @"homeCell";
    
    MyOrderTVC *cell = [aTableView dequeueReusableCellWithIdentifier:vCellIdentify];
    if (cell == nil) {
        cell = [[MyOrderTVC alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:vCellIdentify];
    }
    cell.delegate = self;
    cell.cellEdge = 10;
    cell.orderItem = aView.tableInfoArray[aIndexPath.section];
    //MyOrderVO *orderVO = [self.orderList objectAtIndex:indexPath.section];
    //cell.myOrderVO = orderVO;
    //[cell updateMyOrderTVC];
    return cell;
}

#pragma mark CustomTableViewDelegate
-(float)heightForRowAthIndexPath:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView{
    
    NSDictionary *dic = aView.tableInfoArray[aIndexPath.section];
    
    NSNumber *code =[dic[@"status"] objectForKey:@"code"];
    
    if ([code integerValue] == 32 || [code integerValue] == 78) {
        return 195;
    }
    else{
        return 60+195;
    }

}

-(void)didSelectedRowAthIndexPath:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView{
    
}

- (void)refreshHeaderData:(void (^)())complete FromView:(CustomTableView *)aView {
    
    [self getDataInfoFromHttpIsHeader:YES WithBlock:^(NSArray *items, NSError *error) {
        
        if (!error ) {
            if (items) {
                aView.tableInfoArray = [items mutableCopy];
            }
            else {
                
            }
        }
        else {
            
        }
        
        if (complete) {
            complete();
        }
    }];
}

- (void)reFreshFooterData:(void (^)())complete FromView:(CustomTableView *)aView {
    
    NSMutableDictionary *cStatus = [_statusOfPage[_mCurrentPage] mutableCopy];
    // NSString *nextPage = cStatus[NextPageKey];
    //NSString *statusCode = cStatus[StatusKey];
    
    NSNumber *nextPageIndex = cStatus[NextPageKey];
    
    if (nextPageIndex.doubleValue == -1) {
         [self showHudOnlyMsg:@"已全部加载完成"];
         
        if (complete) {
            complete();
        }
        
         return;
     }

    
    [self getDataInfoFromHttpIsHeader:NO WithBlock:^(NSArray *items, NSError *error) {
        if (!error ) {
            if (items) {
                [aView.tableInfoArray addObjectsFromArray:items];
            }
            else {
                
            }
        }
        else {
            
        }
        
        if (complete) {
            complete();
        }

    }];
}
#pragma mark - HUD
-(void)showHudOnlyMsg:(NSString*)msg {
    
    [self bringSubviewToFront:self.hud];
    self.hud.mode      = MBProgressHUDModeText;
    self.hud.labelText = msg;
    [self.hud show:YES];
    [self.hud hide:YES afterDelay:2.0];
}


#pragma mark - HTTP Request
- (void)getDataInfoFromHttpIsHeader:(BOOL)isHeader WithBlock:(void (^)(NSArray *items, NSError *error))block {
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    NSString *userId = [userDic objectForKey:UserLoginId];
    NSString *token = [userDic objectForKey:UserToken];
    

    NSMutableDictionary *cStatus = [_statusOfPage[_mCurrentPage] mutableCopy];
   // NSString *nextPage = cStatus[NextPageKey];
    //NSString *statusCode = cStatus[StatusKey];
    
    //NSNumber *nextPageIndex = cStatus[NextPageKey];
    
    /*if (nextPageIndex.doubleValue == -1) {
        [self showHudOnlyMsg:@"已全部加载完成"];
        
        if (block) {
            block(nil, nil);
        }
        
        return;
    }*/
    
    NSLog(@"nextPageIndex:%@",cStatus[NextPageKey]);
    
    NSString *nextPage = isHeader ? @"" : cStatus[NextPageKey];
    
    [[MZBHttpService shareInstance] getOrderListWithUserId:userId andToken:token andNextPageIndex:nextPage andOrderStatusCode:cStatus[StatusKey] WithBlock:^(NSDictionary *result, NSError *error) {
        
       // NSLog(@"result:%@",result);
        
        if (!error) {
            if ( ((NSNumber *)result[@"status"]).boolValue ) {
                NSArray *itemsArray = [result[@"data"] objectForKey:@"items"];
                
                NSString *nextPage = [result[@"data"] objectForKey:@"nextPageIndex"];
                NSLog(@"nextPage:%@",nextPage);
                
        
                [cStatus setObject:nextPage forKey:NextPageKey];
                _statusOfPage[_mCurrentPage] = cStatus;
                
                
                if (block) {
                    block(itemsArray, nil);
                }
                
            }
            else {
                NSLog(@"errorMsg:%@",result[@"message"]);
                if (block) {
                    block(nil, nil);
                }
            }
            
            
        }
        else {
            NSLog(@"error:%@",[error description]);
            if (block) {
                block(nil, error);
            }
            
        }

    }];
}

#pragma mark - myOrderTVC delegate
- (void)complaintBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell{
    
    
    if ([self.delegate respondsToSelector:@selector(commentOrder:)]) {
        [self.delegate commentOrder:cell.orderItem];
    }
}


- (void)cancelBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell{//取消成功
    //[self setupRefresh:@"current"];
    CustomTableView *vTableContentView =(CustomTableView *)[_contentItems objectAtIndex:_mCurrentPage];
    
    [vTableContentView setupRefresh:[NSString stringWithFormat:@"%li",(long)_mCurrentPage]];


    
}

- (void)zhifuBtnClickedWithMyOrderTVC:(MyOrderTVC *)cell{
   
    
    if ([self.delegate respondsToSelector:@selector(zhifuOrder:)]) {
        [self.delegate zhifuOrder:cell.orderItem];
    }
}


@end
