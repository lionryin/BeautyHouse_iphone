//
//  RMDateSelectionVC.h
//  BeautyHouse
//
//  Created by MacAir2 on 15/3/23.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMDateSelectionViewController;

@protocol RMDateSelectionViewControllerDelegate <NSObject>

/**
 This delegate method is called when the user selects a certain date.
 
 @param vc The date selection view controller that just finished selecting a date.
 
 @param aDate The selected date.
 */
- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate;

/**
 This delegate method is called when the user selects the cancel button.
 
 @param vc The date selection view controller that just canceled.
 */
- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc;

@end


@interface RMDateSelectionViewController : UIViewController

/**
 Will return the instance of UIDatePicker that is used. This property will be nil until -[RMDateSelectionViewController show] or -[RMDateSelectionViewController showFromViewController:] is called.
 */
@property (weak, readonly) UIDatePicker *datePicker;

/**
 Used to set the delegate.
 
 The delegate must conform to the `RMDateSelectionViewControllerDelegate` protocol.
 */
@property (weak) id<RMDateSelectionViewControllerDelegate> delegate;

/// @name Class Methods

/**
 This returns a new instance of `RMDateSelectionViewController`. Always use this class method to get an instance. Do not initialize an instance yourself.
 
 @return Returns a new instance of `RMDateSelectionViewController`
 */
+ (instancetype)dateSelectionController;

/// @name Instance Methods

/**
 This shows the date selection view controller as child view controller of the root view controller of the current key window.
 
 The content of the rootview controller will be darkened and the date selection view controller will be shown on top.
 */
- (void)show;

/**
 This shows the date selection view controller as child view controller of aViewController.
 
 The content of aViewController will be darkened and the date selection view controller will be shown on top.
 
 @param aViewController The date selection view controller will be displayed as a child view controller of this view controller.
 */
- (void)showFromViewController:(UIViewController *)aViewController;

/**
 This will remove the date selection view controller from whatever view controller it is currently shown in.
 */
- (void)dismiss;


@end
