//
//  StatisticalChartViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/16.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "StatisticalChartViewController.h"
#import "Nav.h"

@interface StatisticalChartViewController ()
@property(strong,nonatomic)Nav *nav;
@end

@implementation StatisticalChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"统计" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}

- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
