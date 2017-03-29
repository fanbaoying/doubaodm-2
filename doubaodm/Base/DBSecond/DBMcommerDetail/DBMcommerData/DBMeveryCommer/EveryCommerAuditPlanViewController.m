//
//  EveryCommerAuditPlanViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/3/6.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "EveryCommerAuditPlanViewController.h"
#import "TransportNav.h"
#import "LeaveTableViewCell.h"

#import "TransportViewController.h"

#import "BusinessAuditPlanViewController.h"

@interface EveryCommerAuditPlanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)TransportNav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)UIView *headView;
@property(strong,nonatomic)UIButton *transportBtn;

@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *timeLab;
@property(strong,nonatomic)UILabel *lab;

@property(strong,nonatomic)UILabel *AllLab;

@property(strong,nonatomic)NSArray *contentArr;

@end

@implementation EveryCommerAuditPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
    self.myTable.showsVerticalScrollIndicator = NO;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.myTable.scrollEnabled = NO;
    [self.view addSubview:_myTable];
    
    NSString *str1 = [NSString stringWithFormat:@"姓名：张三"];
    NSString *str2 = [NSString stringWithFormat:@"性别：男"];
    NSString *str3 = [NSString stringWithFormat:@"年龄：40岁"];
    NSString *str4 = [NSString stringWithFormat:@"编号：01"];
    NSString *str5 = [NSString stringWithFormat:@"类型：意向商户"];
    NSString *str6 = [NSString stringWithFormat:@"电话：123456698"];
    NSString *str7 = [NSString stringWithFormat:@"邮箱：446613148@qq.com"];
    
    self.contentArr = @[str1,str2,str3,str4,str5,str6,str7];
    
    self.nav = [[TransportNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"商户详情" andWithRightBtn:@"审核进度" andWithBgImg:nil];
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.nav.rightBtn addTarget:self action:@selector(auditPlan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
    
}

- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)auditPlan:(UIButton *)sender{
    
    BusinessAuditPlanViewController *bapvc = [[BusinessAuditPlanViewController alloc]init];
    
    [self.navigationController pushViewController:bapvc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 290;
    
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LeaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[LeaveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    [cell.headBtn setTitle:@"商户张三" forState:UIControlStateNormal];
    cell.contentLab.text = @"聊天气泡";
    cell.lookMoreLab.hidden = YES;
    
    return cell;
}

//添加头部内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 290)];
    self.headView.backgroundColor = [UIColor whiteColor];
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 240)];
    header.backgroundColor = [UIColor colorWithRed:230/250.0 green:230/255.0 blue:230/255.0 alpha:1];
    header.layer.cornerRadius = 5.0;
    header.clipsToBounds = YES;
    [self.headView addSubview:header];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH/5, 30)];
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.font = [UIFont systemFontOfSize:14.0];
    self.titleLab.text = @"基本信息";
    [header addSubview:_titleLab];
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5+20, 0, SCREEN_WIDTH/2, 30)];
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    self.timeLab.font = [UIFont systemFontOfSize:14.0];
    self.timeLab.text = @"2017-02-14 17:04创建";
    self.timeLab.numberOfLines = 0;
    [header addSubview:_timeLab];
    
    self.transportBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30-SCREEN_WIDTH/6, 10, SCREEN_WIDTH/6, 30)];
    self.transportBtn.layer.borderWidth = 1.0;
    self.transportBtn.layer.borderColor = [UIColor colorWithRed:174/255.0 green:109/255.0 blue:45/255.0 alpha:1].CGColor;
    self.transportBtn.layer.cornerRadius = 5.0;
    self.transportBtn.clipsToBounds = YES;
    self.transportBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.transportBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.transportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.transportBtn setTitle:@"移动" forState:UIControlStateNormal];
    [self.transportBtn addTarget:self action:@selector(transportBtn:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:_transportBtn];
    
    self.lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, SCREEN_WIDTH*2/3, 1)];
    self.lab.textColor = [UIColor lightGrayColor];
    [header addSubview:_lab];
    
    for (int i = 1; i < 8; i++) {
        
        self.AllLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 30*i, SCREEN_WIDTH*2/3, 30)];
        self.AllLab.textAlignment = NSTextAlignmentLeft;
        self.AllLab.text = _contentArr[i-1];
        self.AllLab.font = [UIFont systemFontOfSize:14.0];
        self.AllLab.numberOfLines = 0;
        [header addSubview:_AllLab];
        
    }
    
    UIView *fooder = [[UIView alloc]initWithFrame:CGRectMake(10, 260, SCREEN_WIDTH-20, 30)];
    fooder.backgroundColor = [UIColor colorWithRed:230/250.0 green:230/255.0 blue:230/255.0 alpha:1];
    fooder.layer.cornerRadius = 5.0;
    fooder.clipsToBounds = YES;
    [self.headView addSubview:fooder];
    
    UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 30)];
    message.textAlignment = NSTextAlignmentLeft;
    message.text = @"留言圈";
    message.font = [UIFont systemFontOfSize:14.0];
    [fooder addSubview:message];
    
    
    return _headView;
    
}

- (void)transportBtn:(UIButton *)sender{
    
    TransportViewController *tvc = [[TransportViewController alloc]init];
    
    tvc.str = _contentArr[3];
    
    [self.navigationController pushViewController:tvc animated:YES];
    
}

@end
