//
//  AddBusinessViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "AddBusinessViewController.h"
#import "AddBusinessTableViewCell.h"
#import "AddNav.h"

#import "NegoModel.h"
#import "MJExtension.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

#import "TransportViewController.h"

#import "ManagerSearchSalesmanViewController.h"

@interface AddBusinessViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(strong,nonatomic)AddNav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@property (strong,nonatomic) NSMutableArray *sourceArr;

@property(strong,nonatomic)NSString *businessidStr;

@end

@implementation AddBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
    self.myTable.showsVerticalScrollIndicator = NO;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTable];
    
    self.nav = [[AddNav alloc]initWithLeftBtn:@"back" andWithTitleText:nil andWithLab:nil andWithBgImg:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nav.titleText.returnKeyType = UIReturnKeySearch;
    self.nav.titleText.delegate = self;
    self.nav.titleText.placeholder = @"请输入手机号查找";
    
    [self.view addSubview:_nav];
    
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [_myTable addGestureRecognizer:myTap];
}

- (void)scrollTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _sourceArr.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 240;
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    
    AddBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (cell == nil) {
        cell = [[AddBusinessTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }

    NegoModel *model = self.sourceArr[indexPath.row];
    
    cell.model = model;
    
    cell.accept = ^(BOOL isAccept){
        
        [weakSelf updateIndexPathRowStatusSelected:isAccept section:indexPath];
        
    };

    return cell;
}

//跟新确认键 //全选中改变状态

- (void)updateIndexPathRowStatusSelected:(BOOL)isSelected section:(NSIndexPath *)indexPath{
    
    NegoModel *model = self.sourceArr[indexPath.row];
    model.isAccept = isSelected;

    NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
    NSString *grade = [gradeid objectForKey:@"gradeid"];
    
    NSLog(@"%@",grade);
    
    int intString = [grade intValue];
    
    if (intString == 1) {
        
        ManagerSearchSalesmanViewController *mssvc = [[ManagerSearchSalesmanViewController alloc]init];
        
//        tvc.str = [_dataArr[indexPath.row] objectForKey:@"businessid"];
        
        [self.navigationController pushViewController:mssvc animated:YES];
        
    }else if (intString == 2){
        
        ManagerSearchSalesmanViewController *mssvc = [[ManagerSearchSalesmanViewController alloc]init];
        
//        tvc.str = [_dataArr[indexPath.row] objectForKey:@"businessid"];
        
        [self.navigationController pushViewController:mssvc animated:YES];
        
    }else if (intString == 3){
        
        TransportViewController *tvc = [[TransportViewController alloc]init];
        
        tvc.str = [_dataArr[indexPath.row] objectForKey:@"businessid"];
        
        [self.navigationController pushViewController:tvc animated:YES];
        
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenid objectForKey:@"tokenid"];
    
//    NSLog(@"%@",token);
//    NSLog(@"%@",self.nav.titleText.text);
    
    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
    mutdic[@"token"] = token;
//    mutdic[@"token"] = self.nav.titleText.text;
    mutdic[@"phone"] = @"15002486985";
    
    //网络请求
    FBYHomeService *service1 = [[FBYHomeService alloc]init];
    
    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getSalesmanSearchBusinessman andSuccess:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        
        NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
        
        if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {
            
            self.dataArr = [dic objectForKey:@"data"];
            if ([_dataArr isEqual:[NSNull null]]) {
                
            }else{
                
                if (!_sourceArr) {
                    _sourceArr = [[NSMutableArray alloc]initWithCapacity:0];
                    
                    
                    for (NSDictionary *dic in _dataArr){
                        
                        NegoModel *model = [NegoModel mj_objectWithKeyValues:dic];
                        [_sourceArr addObject:model];
                        [self.myTable reloadData];
                    }
                }
            }
            
        }else{
        
            
            
        }
        
    } andFailure:^(int fail) {
        
    }];
    
    return YES;
}

@end
