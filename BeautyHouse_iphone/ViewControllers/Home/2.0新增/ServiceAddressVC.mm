//
//  ServiceAddressVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/6/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "ServiceAddressVC.h"
#import "SearchListTableVC.h"
#import <BaiduMapAPI/BMapKit.h>

@interface ServiceAddressVC ()<SearchListTableVCDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *detailAddressView;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressField;

@property (strong, nonatomic) SearchListTableVC *ddList;
@property (strong, nonatomic) NSString *searchStr;

@end

@implementation ServiceAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"添加服务地址";
    
    _ddList = [[SearchListTableVC alloc] initWithStyle:UITableViewStylePlain];
    _ddList.delegate = self;
    [_ddList.view setFrame:CGRectMake(0, 108, self.view.frame.size.width, 0)];
    [self.view addSubview:_ddList.view];
    
    self.detailAddressView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - myself

- (void)setDDListHidden:(BOOL)hidden {
    NSInteger height = hidden ? 0 : 180;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    [_ddList.view setFrame:CGRectMake(0, 108, self.view.frame.size.width, height)];
    [UIView commitAnimations];
}
#pragma mark -
#pragma mark SearchListTableVCDelegate
- (void)passValue:(NSString *)value{
    if (value) {
        _searchBar.text = value;
        [self searchBarSearchButtonClicked:_searchBar];
    }
    else {
        
    }
}

#pragma mark -
#pragma mark SearchBar Delegate Methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] != 0) {
        _ddList.searchText = searchText;
        [_ddList updateData];
        [self setDDListHidden:NO];
    }
    else {
        [self setDDListHidden:YES];
    }
}

//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    searchBar.text = @"";
//}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    if (![_searchBar.text isEqualToString:@""]) {
        _detailAddressView.hidden = NO;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self setDDListHidden:YES];
    self.searchStr = searchBar.text;
    [searchBar resignFirstResponder];
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;    
}

#pragma mark - UITableView delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
