//
//  SecondViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/18.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "SecondViewController.h"
#import "Nav.h"
#import "SecondTableViewCell.h"

#import "CommerDetailViewController.h"
#import "SignCommerViewController.h"
#import "EquipmentViewController.h"
#import "SetUpViewController.h"

#import "AddBusinessViewController.h"

#import "BusinessAllocationViewController.h"
#import "StatisticalChartViewController.h"
#import "BusinessAuditViewController.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *titleArr;

@property(strong,nonatomic)UILabel *titleLabStr;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-93)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
    self.myTable.showsVerticalScrollIndicator = NO;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.scrollEnabled = NO;
    [self.view addSubview:_myTable];
    
    NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
    NSString *grade = [gradeid objectForKey:@"gradeid"];
    
    NSLog(@"%@",grade);
    
    int intString = [grade intValue];
    if (intString == 0) {
        self.titleArr = @[@"商户数据处理-分配到某经理",@"全图商户签约详情"];
    }else if (intString == 1) {
        self.titleArr = @[@"商户数据处理-分配到某业务员",@"商户签约详情(主管一)",@"全图商户签约详情"];
    }else if (intString == 2){
        
        self.titleArr = @[@"商户数据处理-分配到某业务员",@"商户审核",@"商户签约详情(主管一)",@"全图商户签约详情"];
    }else if (intString == 3){
        
        self.titleArr = @[@"招商商户",@"电子签约",@"设备实施",@"后期维护"];
    }
    
    
    
    self.nav = [[Nav alloc]initWithLeftBtn:nil andWithTitleLab:@"斗宝招商" andWithRightBtn:@"add" andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.rightBtn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
}

- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)addBtn:(UIButton *)sender{
    
    AddBusinessViewController *abvc = [[AddBusinessViewController alloc]init];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController pushViewController:abvc animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
    NSString *grade = [gradeid objectForKey:@"gradeid"];
    
    NSLog(@"%@",grade);
    
    int intString = [grade intValue];
    if (intString == 0) {
        
        if (indexPath.row == 0) {
            BusinessAllocationViewController *bavc = [[BusinessAllocationViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:bavc animated:YES];
        }else if (indexPath.row == 1){
            
            StatisticalChartViewController *scvc = [[StatisticalChartViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:scvc animated:YES];
            
        }
    }else if (intString == 1) {
        
        if (indexPath.row == 0) {
            BusinessAllocationViewController *bavc = [[BusinessAllocationViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:bavc animated:YES];
        }else if (indexPath.row == 1){
            
            StatisticalChartViewController *scvc = [[StatisticalChartViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:scvc animated:YES];
            
        }else if (indexPath.row == 2){
            
            StatisticalChartViewController *scvc = [[StatisticalChartViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:scvc animated:YES];
            
        }
        
    }else if (intString == 2){
        
        if (indexPath.row == 0) {
            BusinessAllocationViewController *bavc = [[BusinessAllocationViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:bavc animated:YES];
        }else if (indexPath.row == 1){
            
            BusinessAuditViewController *bavc = [[BusinessAuditViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:bavc animated:YES];
            
        }else if (indexPath.row == 2){
            
            StatisticalChartViewController *scvc = [[StatisticalChartViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:scvc animated:YES];
            
        }else if (indexPath.row == 3){
            
            StatisticalChartViewController *scvc = [[StatisticalChartViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:scvc animated:YES];
            
        }
        
    }else if (intString == 3){
        
        if (indexPath.row == 0) {
            CommerDetailViewController *ccvc = [[CommerDetailViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:ccvc animated:YES];
        }else if (indexPath.row == 1){
            
            SignCommerViewController *scvc = [[SignCommerViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:scvc animated:YES];
            
        }else if (indexPath.row == 2){
            
            EquipmentViewController *evc = [[EquipmentViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:evc animated:YES];
            
        }else if (indexPath.row == 3){
            
            SetUpViewController *suvc = [[SetUpViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:suvc animated:YES];
            
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[SecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.contentLab.text = _titleArr[indexPath.row];
    
    return cell;
}

//添加头部内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    header.backgroundColor = [UIColor whiteColor];
    
    self.titleLabStr = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
    
    NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
    NSString *grade = [gradeid objectForKey:@"gradeid"];
    
    NSLog(@"%@",grade);
    
    int intString = [grade intValue];
    if (intString == 0) {
        self.titleLabStr.text = @"商户管理";
    }else if (intString == 1) {
        self.titleLabStr.text = @"商户管理";
    }else if (intString == 2){
        self.titleLabStr.text = @"商户管理";
    }else if (intString == 3){
        self.titleLabStr.text = @"工作动态";
    }
    
    [header addSubview:_titleLabStr];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    lab.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    [header addSubview:lab];
    
    return header;
    
}

@end
