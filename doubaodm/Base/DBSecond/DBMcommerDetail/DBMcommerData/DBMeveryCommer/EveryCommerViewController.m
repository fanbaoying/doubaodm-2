//
//  EveryCommerViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/22.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "EveryCommerViewController.h"
#import "TransportNav.h"
#import "LeaveTableViewCell.h"

#import "TransportViewController.h"

#import "FBYHomeService.h"
#import "AFNetworking.h"

@interface EveryCommerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)TransportNav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@property(strong,nonatomic)UIView *headView;

@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *timeLab;
@property(strong,nonatomic)UILabel *lab;

@property(strong,nonatomic)UILabel *AllLab;

@property(strong,nonatomic)NSArray *contentArr;

@property(strong,nonatomic)NSString *sexStr;

@end

@implementation EveryCommerViewController

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

    self.nav = [[TransportNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"商户详情" andWithRightBtn:@"移动" andWithBgImg:nil];
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.nav.rightBtn addTarget:self action:@selector(transport:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];

}

- (void)back:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenid objectForKey:@"tokenid"];
    
    NSLog(@"%@",token);
    
    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
    mutdic[@"token"] = token;
    mutdic[@"userid"] = _userIdStr;
    //网络请求
    FBYHomeService *service1 = [[FBYHomeService alloc]init];
    
    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getBusinessInfo andSuccess:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        
                        NSLog(@"%@",[dic objectForKey:@"msg"]);
        
        NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
        
        if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {
            
            self.dataArr = [dic objectForKey:@"data"];
            if ([_dataArr isEqual:[NSNull null]]) {
                
            }else{
                NSString *str1 = [NSString stringWithFormat:@"姓名：%@",[_dataArr[0] objectForKey:@"fullname"]];
                NSString *sexStr = [_dataArr[0] objectForKey:@"gender"];
                int intString = [sexStr intValue];
                if (intString == 1) {
                    _sexStr = [NSString stringWithFormat:@"性别：男"];
                }else{
                    _sexStr = [NSString stringWithFormat:@"性别：女"];
                }
                
                NSString *str3 = [NSString stringWithFormat:@"年龄：%@岁",[_dataArr[0] objectForKey:@"age"]];
                NSString *str4 = [NSString stringWithFormat:@"编号：%@",[_dataArr[0] objectForKey:@"userid"]];
                NSString *str5 = [NSString stringWithFormat:@"类型：%@",[_dataArr[0] objectForKey:@"businessType"]];
                NSString *str6 = [NSString stringWithFormat:@"电话：%@",[_dataArr[0] objectForKey:@"phone"]];
                NSString *str7 = [NSString stringWithFormat:@"邮箱：%@",[_dataArr[0] objectForKey:@"email"]];
                
                self.contentArr = @[str1,_sexStr,str3,str4,str5,str6,str7];
                [self.myTable reloadData];
            }
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            
            [alert addAction:action1];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
    } andFailure:^(int fail) {
        
    }];
    
}

- (void)transport:(UIButton *)sender{
    
    TransportViewController *tvc = [[TransportViewController alloc]init];
    
    tvc.str = _contentArr[3];
    
    [self.navigationController pushViewController:tvc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
    
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

    [cell.headBtn setTitle:[_dataArr[indexPath.row] objectForKey:@"username"] forState:UIControlStateNormal];
    cell.contentLab.text = [_dataArr[indexPath.row] objectForKey:@"constactStatus"];
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
    
    NSString *timeStr = [_dataArr[0] objectForKey:@"ctime"];
    
    NSTimeInterval interval=[timeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    self.timeLab.text = currentDateStr;
    self.timeLab.numberOfLines = 0;
    [header addSubview:_timeLab];
    
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

@end
