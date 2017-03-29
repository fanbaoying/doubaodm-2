//
//  CommerDataViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/21.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "CommerDataViewController.h"
#import "Nav.h"
#import "CommerDataTableViewCell.h"
#import "EveryCommerViewController.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

@interface CommerDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@end

@implementation CommerDataViewController

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
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:_str andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenid objectForKey:@"tokenid"];
    
//    NSLog(@"%@",token);
    
    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
    mutdic[@"token"] = token;
    mutdic[@"stepstate"] = _str;
    
    //网络请求
    FBYHomeService *service1 = [[FBYHomeService alloc]init];
    
    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getSalesmanBusinessFilterByStepstateList andSuccess:^(NSDictionary *dic) {
        
//        NSLog(@"%@",dic);
        
//        NSLog(@"%@",[dic objectForKey:@"msg"]);
        
        NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
        
        if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {

            self.dataArr = [dic objectForKey:@"data"];
            if ([_dataArr isEqual:[NSNull null]]) {
                
            }else{
                
                [self.myTable reloadData];
            }
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"移动成功" preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                
//                
//            }];
//            
//            [alert addAction:action1];
//            [self presentViewController:alert animated:YES completion:nil];
//            
        }
     
        
    } andFailure:^(int fail) {
        
    }];
    
}

- (void)back:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}


//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EveryCommerViewController *cdvc = [[EveryCommerViewController alloc]init];
    
    
    [self.navigationController pushViewController:cdvc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommerDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];

    
    if (cell == nil) {
        cell = [[CommerDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.headeImg.image = [UIImage imageNamed:@"sweep"];
    cell.titleLab.text = [_dataArr[indexPath.row] objectForKey:@"stepstate"];
    cell.contentLab.text = [_dataArr[indexPath.row] objectForKey:@"fullname"];
    
    return cell;
}

@end
