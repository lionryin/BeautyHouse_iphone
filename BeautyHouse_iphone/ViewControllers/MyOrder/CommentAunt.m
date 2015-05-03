//
//  CommentAunt.m
//  BeautyHouse_iphone
//
//  Created by MacAir2 on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "CommentAunt.h"
#import "SelectStarView.h"
#import "AFNetworking.h"

@interface CommentAunt ()<UITextViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet SelectStarView *starView1;
@property (weak, nonatomic) IBOutlet SelectStarView *starView2;
@property (weak, nonatomic) IBOutlet SelectStarView *starView3;
@property (weak, nonatomic) IBOutlet SelectStarView *starView4;
@property (weak, nonatomic) IBOutlet SelectStarView *starView5;

@property (weak, nonatomic) IBOutlet UITextView *backgroundTV;
@property (weak, nonatomic) IBOutlet UITextView *commentTV;
- (IBAction)button1Pressed:(id)sender;
- (IBAction)button2Pressed:(id)sender;
- (IBAction)button3Pressed:(id)sender;

- (IBAction)submitButtonPressed:(id)sender;

@end

@implementation CommentAunt

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"评价阿姨";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _myScrollView.contentSize = CGSizeMake(_myScrollView.frame.size.width, 646);
    
    ///button
    [_button1 setBackgroundImage:[UIImage imageNamed:@"btn_selected.png"] forState:UIControlStateSelected];
    [_button2 setBackgroundImage:[UIImage imageNamed:@"btn_selected.png"] forState:UIControlStateSelected];
    [_button3 setBackgroundImage:[UIImage imageNamed:@"btn_selected.png"] forState:UIControlStateSelected];
    _button3.selected = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - slider up

- (void)slideFrame:(BOOL )up
{
    const int movementDistance = 240; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


#pragma mark - TextView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(![text isEqualToString:@""])
    {
        [_backgroundTV setHidden:YES];
    }
    if([text isEqualToString:@""] && range.length==1 && range.location==0){
        [_backgroundTV setHidden:NO];
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [self slideFrame:YES ];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [self slideFrame:NO ];
    return YES;
}

#pragma mark - IBAction

- (IBAction)button1Pressed:(id)sender {
    _button1.selected = !_button1.selected;
    if (_button1.selected ) {
        _button2.selected = NO;
        _button3.selected = NO;
    }
}

- (IBAction)button2Pressed:(id)sender {
    _button2.selected = !_button2.selected;
    if (_button2.selected ) {
        _button1.selected = NO;
        _button3.selected = NO;
    }
}

- (IBAction)button3Pressed:(id)sender {
    _button3.selected = !_button3.selected;
    if (_button3.selected ) {
        _button2.selected = NO;
        _button1.selected = NO;
    }
}

- (IBAction)submitButtonPressed:(id)sender {
    [self submitService];
}

#pragma mark - submit
- (void)submitService{
    
    NSString *totalScore = @"3";

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.mrchabo.com/Service/Order/Evaluation/add.do?auntId=%@&orderId=%@&totalEvaluationScore=%@&evaluationIds=1,2,3,4,5&evaluationScores=%@,%@,%@,%@,%@&remarks=good",_orderVO.auntID,_orderVO.orderID,totalScore,@"1",@"2",@"3",@"4",@"5"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *html = operation.responseString;
        //NSLog(@"html:%@",html);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[html dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
        if ([[dic objectForKey:@"result"] isEqualToString:@"true"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"评价成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alert.tag = 88;
                [alert show];
            });
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发生未知错误！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    }];
    [operation start];

}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 88) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
