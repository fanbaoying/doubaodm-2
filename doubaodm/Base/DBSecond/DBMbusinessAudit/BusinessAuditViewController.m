//
//  BusinessAuditViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/3/6.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "BusinessAuditViewController.h"
#import "Nav.h"
#import "CommerDataTableViewCell.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

#import "EveryCommerAuditPlanViewController.h"

@interface BusinessAuditViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@end

@implementation BusinessAuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
    self.myTable.showsVerticalScrollIndicator = NO;
    //    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.myTable.scrollEnabled = NO;
    [self.view addSubview:_myTable];
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"待审核商户" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
}

- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}


//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EveryCommerAuditPlanViewController *ecapvc = [[EveryCommerAuditPlanViewController alloc]init];
    
    [self.navigationController pushViewController:ecapvc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommerDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    if (cell == nil) {
        cell = [[CommerDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.headeImg.image = [UIImage imageNamed:@"sweep"];
    //    cell.titleLab.text = [_dataArr[indexPath.row] objectForKey:@"stepstate"];
    //    cell.contentLab.text = [_dataArr[indexPath.row] objectForKey:@"fullname"];
    
    cell.titleLab.text = @"待审核商户";
    cell.contentLab.text = @"张三";
    
    return cell;
}

@end
