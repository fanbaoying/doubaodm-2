//
//  FirstSearchViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/15.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "FirstSearchViewController.h"
#import "AddNav.h"
#import "LeaveTableViewCell.h"
#import "BusinessMessageRecordViewController.h"

@interface FirstSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(strong,nonatomic)AddNav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@property(strong,nonatomic)UIView *foodView;

@end

@implementation FirstSearchViewController

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
    
    self.nav = [[AddNav alloc]initWithLeftBtn:@"back" andWithTitleText:nil andWithLab:nil andWithBgImg:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nav.titleText.returnKeyType = UIReturnKeySearch;
    self.nav.titleText.delegate = self;
    self.nav.titleText.placeholder = @"请输入关键字";
    
    [self.view addSubview:_nav];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
    
}

- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 45;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (section == 0) {
        return 10;
    }else{
    
        return 0;
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
        
    }else{
    
    BusinessMessageRecordViewController *bmrvc = [[BusinessMessageRecordViewController alloc]init];
    
    bmrvc.str = @"商户张三";
    
    [self.navigationController pushViewController:bmrvc animated:YES];
    
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LeaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (cell == nil) {
        cell = [[LeaveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.headBtn.hidden = NO;
    cell.contentLab.hidden = NO;
    [cell.headBtn setTitle:@"商户张三" forState:UIControlStateNormal];
    cell.contentLab.text = @"5条与“关键词”相关记录";
    
    if (indexPath.section == 0) {
        cell.lookMoreLab.text = nil;
        if (indexPath.row == 3) {
            cell.headBtn.hidden = YES;
            cell.contentLab.hidden = YES;
            cell.lookMoreLab.text = @"查看更多";
        }
        
    }else if (indexPath.section == 1){
        cell.lookMoreLab.text = nil;
        if (indexPath.row == 3) {
            cell.headBtn.hidden = YES;
            cell.contentLab.hidden = YES;
            cell.lookMoreLab.text = @"查看更多";
        }
        
    }
    return cell;
}

//添加头部内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    header.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-10, 44)];
    if (section == 0) {
        titleLab.text = @"商户留言记录";
    }else if(section == 1){
        titleLab.text = @"部门留言记录";
    }
    titleLab.font = [UIFont systemFontOfSize:14.0];
    [header addSubview:titleLab];

    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 1)];
    lab.backgroundColor = [UIColor lightGrayColor];
    [header addSubview:lab];
   
    return header;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    
//    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
//    NSString *token = [tokenid objectForKey:@"tokenid"];
//    
//    //    NSLog(@"%@",token);
//    //    NSLog(@"%@",self.nav.titleText.text);
//    
//    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
//    mutdic[@"token"] = token;
//    //    mutdic[@"token"] = self.nav.titleText.text;
//    mutdic[@"phone"] = @"15002486985";
//    
//    //网络请求
//    FBYHomeService *service1 = [[FBYHomeService alloc]init];
//    
//    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getSalesmanSearchBusinessman andSuccess:^(NSDictionary *dic) {
//        
//        NSLog(@"%@",dic);
//        
//        NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
//        
//        if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {
//            
//            self.dataArr = [dic objectForKey:@"data"];
//            if ([_dataArr isEqual:[NSNull null]]) {
//                
//            }else{
//                
//                if (!_sourceArr) {
//                    _sourceArr = [[NSMutableArray alloc]initWithCapacity:0];
//                    
//                    
//                    for (NSDictionary *dic in _dataArr){
//                        
//                        NegoModel *model = [NegoModel mj_objectWithKeyValues:dic];
//                        [_sourceArr addObject:model];
//                        [self.myTable reloadData];
//                    }
//                }
//            }
//            
//        }else{
//            
//            
//            
//        }
//        
//    } andFailure:^(int fail) {
//        
//    }];
    
    return YES;
}

@end
