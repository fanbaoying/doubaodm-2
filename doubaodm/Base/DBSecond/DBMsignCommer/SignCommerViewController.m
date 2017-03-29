//
//  SignCommerViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/21.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "SignCommerViewController.h"
#import "Nav.h"
#import "SecondTableViewCell.h"

#import "CommerDataViewController.h"

#import "BusinessAuditViewController.h"

@interface SignCommerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *titleArr;

@end

@implementation SignCommerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-94)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
    self.myTable.showsVerticalScrollIndicator = NO;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.myTable.scrollEnabled = NO;
    [self.view addSubview:_myTable];
    
    self.titleArr = @[@"条款确认",@"资质上传",@"待审批"];
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"签约商户" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}
- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
    if (indexPath.row == 2) {
        
        BusinessAuditViewController *bavc = [[BusinessAuditViewController alloc]init];
        
        [self.navigationController pushViewController:bavc animated:YES];
        
    }else{
        
        CommerDataViewController *cdvc = [[CommerDataViewController alloc]init];
        
        cdvc.str = _titleArr[indexPath.row];
        
        [self.navigationController pushViewController:cdvc animated:YES];
        
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
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
    titleLab.text = @"商户动态";
    
    [header addSubview:titleLab];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    lab.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    [header addSubview:lab];
    
    return header;
    
}
@end
