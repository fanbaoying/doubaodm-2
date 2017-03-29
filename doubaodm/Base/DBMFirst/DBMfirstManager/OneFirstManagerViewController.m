//
//  OneFirstManagerViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/3/21.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "OneFirstManagerViewController.h"
#import "Nav.h"

#import "FirstTableViewCell.h"
#import "BusinessViewController.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

#import "FirstManagerViewController.h"
@interface OneFirstManagerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@property(strong,nonatomic)NSArray *titleArr;

@property(strong,nonatomic)NSArray *contentArr;

@end

@implementation OneFirstManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
    self.myTable.showsVerticalScrollIndicator = NO;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.scrollEnabled = NO;
    [self.view addSubview:_myTable];
    
    //    self.titleArr = @[@"张三商户",@"李四商户",@"李五商户",@"李六商户",@"李七商户",@"李八商户"];
    //    self.contentArr = @[@"[合同]请问一下怎么添加上架商品",@"[合同]阅读并提交合同条款",@"[合同]阅读并提交合同条款",@"[合同]阅读并提交合同条款",@"[合同]阅读并提交合同条款",@"[合同]阅读并提交合同条款"];
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"经理圈" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenid objectForKey:@"tokenid"];
    
    NSLog(@"%@",token);
    
    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
    NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
    NSString *grade = [gradeid objectForKey:@"gradeid"];
    
    NSLog(@"%@",grade);
    int intString = [grade intValue];
    
    if (intString == 0) {
        
//                mutdic[@"token"] = token;
        mutdic[@"token"] = @"f9d8b97d22164820992c2912d689111a";
        
    }
    
    //网络请求
    FBYHomeService *service1 = [[FBYHomeService alloc]init];
    
    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getSalesManList andSuccess:^(NSDictionary *dic) {
        
                                NSLog(@"%@",dic);
        
        NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
        
        if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {
            
            self.dataArr = [dic objectForKey:@"data"];
            if ([_dataArr isEqual:[NSNull null]]) {
                
            }else{
                
                [self.myTable reloadData];
                
            }
            
        }
        
    } andFailure:^(int fail) {
        
    }];
    
}

//导航栏返回
- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
    return 0;
    
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FirstManagerViewController *lvc = [[FirstManagerViewController alloc]init];
    
    lvc.managerStr = [_dataArr[indexPath.row] objectForKey:@"token"];
    
    [self.navigationController pushViewController:lvc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[FirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.codeImg.image = [UIImage imageNamed:@"sweep"];
    cell.codeNameLab.text = [_dataArr[indexPath.row] objectForKey:@"fullname"];
    //    cell.codeNumLab.text = [_dataArr[indexPath.row] objectForKey:@"lastmessage"];
    
    //    cell.codeNameLab.text = _titleArr[indexPath.row];
    //    cell.codeNumLab.text = _contentArr[indexPath.row];
    
    return cell;
}
@end
