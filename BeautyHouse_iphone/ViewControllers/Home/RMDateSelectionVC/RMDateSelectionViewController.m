//
//  RMDateSelectionVC.m
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#define RM_DATE_SELECTION_VIEW_HEIGHT_PORTAIT 330
#define RM_DATE_SELECTION_VIEW_HEIGHT_LANDSCAPE 275

#define RM_DATE_SELECTION_VIEW_WIDTH_PORTRAIT 300
#define RM_DATE_SELECTION_VIEW_WIDTH_LANDSCAPE 548

#define RM_DATE_SELECTION_VIEW_MARGIN 10

#define RM_DATE_PICKER_HEIGHT_PORTRAIT 216
#define RM_DATE_PICKER_HEIGHT_LANDSCAPE 162


#import "RMDateSelectionViewController.h"

@interface RMDateSelectionViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, weak) UIViewController *rootViewController;

@property (nonatomic, weak) NSLayoutConstraint *xConstraint;
@property (nonatomic, weak) NSLayoutConstraint *yConstraint;
@property (nonatomic, weak) NSLayoutConstraint *widthConstraint;
@property (nonatomic, weak) NSLayoutConstraint *heightConstraint;

@property (weak) IBOutlet UIButton *nowButton;

@property (weak) IBOutlet UIView *datePickerContainer;
//@property (weak, readwrite) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *pickerHeightConstraint;

@property (weak) IBOutlet UIView *cancelAndSelectButtonContainer;
@property (weak) IBOutlet UIButton *cancelButton;
@property (weak) IBOutlet UIButton *selectButton;

@property (nonatomic, strong) UIView *backgroundView;

@property (strong, nonatomic) NSString *selectedTime;
@property (strong, nonatomic) NSDate *nowDate;


@end

@implementation RMDateSelectionViewController
#pragma mark - Class
+ (instancetype)dateSelectionController {
    return [[RMDateSelectionViewController alloc] initWithNibName:@"RMDateSelectionViewController" bundle:nil];
}

+ (void)showDateSelectionViewController:(RMDateSelectionViewController *)aViewController fromViewController:(UIViewController *)rootViewController {
    aViewController.backgroundView.alpha = 0;
    [rootViewController.view addSubview:aViewController.backgroundView];
    
    [rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:aViewController.backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:rootViewController.view attribute:NSLayoutAttributeTop multiplier:0 constant:0]];
    [rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:aViewController.backgroundView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:rootViewController.view attribute:NSLayoutAttributeLeading multiplier:0 constant:0]];
    [rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:aViewController.backgroundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rootViewController.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [rootViewController.view addConstraint:[NSLayoutConstraint constraintWithItem:aViewController.backgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:rootViewController.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    [aViewController willMoveToParentViewController:rootViewController];
    [aViewController viewWillAppear:YES];
    
    [rootViewController addChildViewController:aViewController];
    [rootViewController.view addSubview:aViewController.view];
    
    [aViewController viewDidAppear:YES];
    [aViewController didMoveToParentViewController:rootViewController];
    
    CGFloat height = RM_DATE_SELECTION_VIEW_HEIGHT_PORTAIT;
    //CGFloat width = aViewController.view.frame.size.width-20;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        if(UIInterfaceOrientationIsLandscape(rootViewController.interfaceOrientation)) {
            height = RM_DATE_SELECTION_VIEW_HEIGHT_LANDSCAPE;
            //width = RM_DATE_SELECTION_VIEW_WIDTH_LANDSCAPE;
            
            aViewController.pickerHeightConstraint.constant = RM_DATE_PICKER_HEIGHT_LANDSCAPE;
        } else {
            height = RM_DATE_SELECTION_VIEW_HEIGHT_PORTAIT;
            //width = RM_DATE_SELECTION_VIEW_WIDTH_PORTRAIT;
            
            aViewController.pickerHeightConstraint.constant = RM_DATE_PICKER_HEIGHT_PORTRAIT;
        }
    }
    
    aViewController.xConstraint = [NSLayoutConstraint constraintWithItem:aViewController.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:rootViewController.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    aViewController.yConstraint = [NSLayoutConstraint constraintWithItem:aViewController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:rootViewController.view attribute:NSLayoutAttributeBottom multiplier:1 constant:height];
    //aViewController.widthConstraint = [NSLayoutConstraint constraintWithItem:aViewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:width];
    aViewController.widthConstraint = [NSLayoutConstraint constraintWithItem:aViewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rootViewController.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    aViewController.heightConstraint = [NSLayoutConstraint constraintWithItem:aViewController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:height];
    
    [rootViewController.view addConstraint:aViewController.xConstraint];
    [rootViewController.view addConstraint:aViewController.yConstraint];
    [rootViewController.view addConstraint:aViewController.widthConstraint];
    [rootViewController.view addConstraint:aViewController.heightConstraint];
    
    [rootViewController.view setNeedsUpdateConstraints];
    [rootViewController.view layoutIfNeeded];
    
    aViewController.yConstraint.constant = -10;
    [rootViewController.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.3 animations:^{
        aViewController.backgroundView.alpha = 1;
        
        [rootViewController.view layoutIfNeeded];
    }];
}

+ (void)dismissDateSelectionViewController:(RMDateSelectionViewController *)aViewController fromViewController:(UIViewController *)rootViewController {
    aViewController.yConstraint.constant = RM_DATE_SELECTION_VIEW_HEIGHT_PORTAIT;
    [rootViewController.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.3 animations:^{
        aViewController.backgroundView.alpha = 0;
        
        [rootViewController.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [aViewController willMoveToParentViewController:nil];
        [aViewController viewWillDisappear:YES];
        
        [aViewController.view removeFromSuperview];
        [aViewController removeFromParentViewController];
        
        [aViewController didMoveToParentViewController:nil];
        [aViewController viewDidDisappear:YES];
        
        [aViewController.backgroundView removeFromSuperview];
    }];
}

#pragma mark - Init and Dealloc
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.view.backgroundColor = [UIColor clearColor];
    
    self.view.layer.masksToBounds = YES;
    
    self.nowButton.layer.cornerRadius = 5;
    
    self.datePickerContainer.layer.cornerRadius = 5;
    self.datePicker.layer.cornerRadius = 5;
    
    self.cancelAndSelectButtonContainer.layer.cornerRadius = 5;
    self.cancelButton.layer.cornerRadius = 5;
    self.selectButton.layer.cornerRadius = 5;
    
    _nowDate = [NSDate date];
    self.selectedTime = [NSString stringWithFormat:@"%@ 08:00:00",[self getDateWithRow:0]];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation
- (void)didRotate {
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        if(UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            self.heightConstraint.constant = RM_DATE_SELECTION_VIEW_HEIGHT_LANDSCAPE;
            //self.widthConstraint.constant = RM_DATE_SELECTION_VIEW_WIDTH_LANDSCAPE;
            
            self.pickerHeightConstraint.constant = RM_DATE_PICKER_HEIGHT_LANDSCAPE;
        } else {
            self.heightConstraint.constant = RM_DATE_SELECTION_VIEW_HEIGHT_PORTAIT;
            //self.widthConstraint.constant = RM_DATE_SELECTION_VIEW_WIDTH_PORTRAIT;
            
            self.pickerHeightConstraint.constant = RM_DATE_PICKER_HEIGHT_PORTRAIT;
        }
        
        [self.datePicker setNeedsUpdateConstraints];
        [self.datePicker layoutIfNeeded];
        
        [self.rootViewController.view setNeedsUpdateConstraints];
        __weak RMDateSelectionViewController *blockself = self;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [blockself.rootViewController.view layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }
}

#pragma mark - Properties
- (UIView *)backgroundView {
    if(!_backgroundView) {
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _backgroundView;
}

#pragma mark - Presenting
- (void)show {
    [self showFromViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (void)showFromViewController:(UIViewController *)aViewController {
    self.rootViewController = aViewController;
    [RMDateSelectionViewController showDateSelectionViewController:self fromViewController:aViewController];
}

- (void)dismiss {
    [RMDateSelectionViewController dismissDateSelectionViewController:self fromViewController:self.rootViewController];
}

#pragma mark - Actions
- (IBAction)doneButtonPressed:(id)sender {
    //[self.delegate dateSelectionViewController:self didSelectDate:self.datePicker.date];
    [self.delegate dateSelectionViewController:self didSelectDate:self.selectedTime];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.1];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self.delegate dateSelectionViewControllerDidCancel:self];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.1];
}

- (IBAction)nowButtonPressed:(id)sender {
   // [self.datePicker setDate:[NSDate date] animated:YES];
}



#pragma mark - PickView delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return 7;
    }
    else if (component == 1){
        return 11;
    }
    else{
        return 2;
    }
}

- (NSString *)getDateWithRow:(NSInteger)row {
    //NSDate *nowDate = [NSDate date];
    
    NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
    NSDate *theDate = [_nowDate initWithTimeIntervalSinceNow:+oneDay*(row+1)];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yy-MM-dd";
    NSString *timeStr=[formatter stringFromDate:theDate];
    
    return timeStr;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [self getDateWithRow:row];
    }
    else if (component == 1){
        return [NSString stringWithFormat:@"%02ld:00",(8+row)];
    }
    else{
        return [NSString stringWithFormat:@"%02ld",30*row];;
    }

}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == 0) {
        return 120;
    }
    else if (component == 1){
        return 80;
    }
    else{
        return 80;
    }

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    ////
    
    self.selectedTime = [NSString stringWithFormat:@"%@ %02ld:%02ld:00",[self getDateWithRow:row],(8+row),30*row];
}

@end
