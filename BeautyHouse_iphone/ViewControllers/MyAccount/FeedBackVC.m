//
//  FeedBackVC.m
//  BeautyHouse_iphone
//
//  Created by Roy on 15/3/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "FeedBackVC.h"
#import "MZBWebService.h"


@interface FeedBackVC ()<UITextViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UILabel *tipLabel1;
@property (nonatomic,strong)UILabel *tipLabel2;


@property (nonatomic,strong)UITextView *feedTV;

@end

@implementation FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self initMainUI];
    // Do any additional setup after loading the view.
}

- (void)initMainUI{
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(320, 540);
    
    [self.view addSubview:self.scrollView];
    


    
    _tipLabel2=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
    _tipLabel2.textColor=[UIColor darkGrayColor];
    _tipLabel2.backgroundColor=[UIColor clearColor];
    _tipLabel2.font=[UIFont systemFontOfSize:14];
    _tipLabel2.textAlignment=NSTextAlignmentLeft;
    _tipLabel2.text=@"建议";
    [self.scrollView addSubview:_tipLabel2];
    
    self.feedTV=[[UITextView alloc]initWithFrame:CGRectMake(10, 30, 300, 100)];
    self.feedTV.text=@"请在此输入你的建议...";
    self.feedTV.textColor=[UIColor lightGrayColor];
    self.feedTV.font=[UIFont systemFontOfSize:14.0];
    self.feedTV.delegate=self;
    self.feedTV.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.feedTV.keyboardType=UIKeyboardTypeDefault;
    [self.scrollView addSubview:self.feedTV];
    
    
    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setFrame:CGRectMake(10, 130+20, 300, 38)];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [submitBtn setBackgroundColor:[UIColor orangeColor]];
    submitBtn.layer.cornerRadius = 4;
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:submitBtn];

    
    
}

- (NSString *)getUserId{
    NSString *userId = nil;
    
    
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:UserGlobalKey];
    
    userId = [userDic objectForKey:UserLoginId];
    
    return userId;
}

- (void)submitBtnClicked:(id)sender{
    
    
    if (!self.feedTV.text.length) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写意见反馈" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        
        [av show];
        return;
    }
    
    if (![self getUserId].length) {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先登录" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        
        [av show];
        return;
    }
    
    
    NSString *jsonParam = [NSString stringWithFormat:@"{\"menberId\":\"%@\",\"feedback\":%@}",[self getUserId],[self.feedTV.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *opration = [MZBWebService saveMenberFeedBackWithParameter:jsonParam];
    
    [opration start];
    
    [opration setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData* data = [[NSData alloc] initWithBytes:[responseObject bytes] length:[responseObject length]];
        NSString* result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",result);
        
        MyPaser *parser = [[MyPaser alloc] initWithContent:result];
        [parser BeginToParse];

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[parser.result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
        
        
        
        NSNumber *rst = dic[@"result"];
        if (rst.integerValue == 0) {
            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"提交反馈成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [av show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}


- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"请在此输入你的建议..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
    
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.feedTV resignFirstResponder];
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
