//
//  UserGuidVC.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/7/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "UserGuidVC.h"
#import "AppDelegate.h"
#import "HomeTableVC.h"


#define SW self.view.bounds.size.width
#define SH self.view.bounds.size.height

@interface UserGuidVC ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView  *mScrollView;
@property (strong, nonatomic) UIPageControl *mPageControl;
@property (strong, nonatomic) UIButton      *mButton;

@end

@implementation UserGuidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SW, SH)];
    _mScrollView.pagingEnabled = YES;
    _mScrollView.showsHorizontalScrollIndicator = NO;
    _mScrollView.delegate = self;
    [self.view addSubview:_mScrollView];
    
    _mPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(60, SH-20, SW-120, 37)];
    [_mPageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    //[self.view addSubview:_mPageControl];//图片上自带pageControl
    
    _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton.frame = CGRectMake((SW-180)/2, SH-140, 180, 40);
    [_mButton addTarget:self action:@selector(startButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_mButton setImage:[UIImage imageNamed:@"guide-4-button.png"] forState:UIControlStateNormal];
    _mButton.hidden = YES;
    [self.view addSubview:_mButton];
    
     /*////////////////////////////////////////////////////////*/
      NSArray *imageArray = @[@"guide-1.png",
      @"guide-2.png",
      @"guide-3.png",
      @"guide-4.png"];
    
      _mPageControl.numberOfPages = imageArray.count;
      _mPageControl.currentPage = 0;
      
      _mScrollView.contentSize = CGSizeMake(imageArray.count*SW, SH);
      
      NSLog(@"size:w %f\t h%f",self.view.frame.size.width, self.view.frame.size.height);
      
      CGFloat x=0;
      for (int i = 0 ; i < imageArray.count; i++,x+=SW) {
      
          UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, SW, SH)];
          imageView.image = [UIImage imageNamed:imageArray[i]];
          
          [_mScrollView addSubview:imageView];
      }
    
    /*////////////////*/
     AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate] ;
    [delegate getCities:_citiesBlock];
     
}

- (void)getCities:(CitiesBlock)block {
    self.citiesBlock = block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pageTurn:(UIPageControl *)aPageControl
{
    NSInteger whichPage = aPageControl.currentPage;
    
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.5f];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [_mScrollView setContentOffset:CGPointMake(SW * whichPage, 0.0f) animated:YES];
    
    [UIView commitAnimations];
}

- (void)startButtonClicked:(id)sender {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController * vc = [story instantiateViewControllerWithIdentifier:@"MainTabBarController"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - ScorllView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _mPageControl.currentPage = scrollView.contentOffset.x/SW;
    
    if (_mPageControl.currentPage == 3) {
        _mButton.hidden = NO;
    }
}
@end
