//
//  FriendGroupViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/22.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "FriendGroupViewController.h"
#import "SweepNav.h"

@interface FriendGroupViewController ()

@property(strong,nonatomic)SweepNav *nav;

@property(strong,nonatomic)UITextView *myText;

@end

@implementation FriendGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myText = [[UITextView alloc]initWithFrame:CGRectMake(0, 74, SCREEN_WIDTH, SCREEN_HEIGHT*2/3)];
    self.myText.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:222/255.0];
    [self.view addSubview:_myText];
    
    self.nav = [[SweepNav alloc]initWithLeftBtn:@"back" andWithBgImg:nil andWithTitleLab:@"编辑" andWithRightBtn:@"发送"];
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.nav.rightBtn addTarget:self action:@selector(okBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}

- (void)back:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

//发送
- (void)okBtn:(UIButton *)sender{

    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}
@end
