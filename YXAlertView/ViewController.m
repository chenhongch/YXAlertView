//
//  ViewController.m
//  YXAlertView
//
//  Created by jokechen on 2018/4/4.
//  Copyright © 2018年 陈红. All rights reserved.
//

#import "ViewController.h"
#import "YXAlertView.h"

@interface ViewController ()<YXAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 200, 200);
    btn.center = self.view.center;
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnAction{
    
    YXAlertView *alter = [[YXAlertView alloc]initWithTitle:@"你已签到成功" icon:[UIImage imageNamed:@"icon1"] message:@"+1积分" mode:YXAlertViewModeLargeIcon delegate:self buttonTitles:@"确定",nil];
    [alter show];
// [UIImage imageNamed:@"icon1"]
}

- (void)alertView:(YXAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"=====点击==%ld",buttonIndex);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
