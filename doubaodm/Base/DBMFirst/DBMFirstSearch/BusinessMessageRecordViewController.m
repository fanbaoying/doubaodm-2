//
//  BusinessMessageRecordViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/15.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "BusinessMessageRecordViewController.h"
#import "Nav.h"
#import "LeaveTableViewCell.h"
#import "LeaveViewController.h"

@interface BusinessMessageRecordViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@end

@implementation BusinessMessageRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
    self.myTable.showsVerticalScrollIndicator = NO;
    //    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTable];
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:_str andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}

- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 45;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LeaveViewController *lvc = [[LeaveViewController alloc]init];
    
//    lvc.str = [_dataArr[indexPath.row] objectForKey:@"businessid"];
//    lvc.nameStr = [_dataArr[indexPath.row] objectForKey:@"name"];
    
    lvc.str = @"46";
    lvc.nameStr = _str;
    
    [self.navigationController pushViewController:lvc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LeaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (cell == nil) {
        cell = [[LeaveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.lookMoreLab.hidden = NO;
    [cell.headBtn setTitle:_str forState:UIControlStateNormal];
    cell.contentLab.text = @"好的，我知道怎么做了";
    return cell;
}

//添加头部内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    header.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10, 44)];
    titleLab.text = @"共有5条“好的”相关的留言记录";
    titleLab.font = [UIFont systemFontOfSize:14.0];
    [header addSubview:titleLab];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    lab.backgroundColor = [UIColor lightGrayColor];
    [header addSubview:lab];
    
    return header;
    
}

@end
