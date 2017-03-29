//
//  TransportBusinessToSalesmanViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/16.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "TransportBusinessToSalesmanViewController.h"
#import "ManagerSearchSalesmanTableViewCell.h"

#import "TransportNav.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

#import "ManagerSearch.h"
#import "MJExtension.h"

@interface TransportBusinessToSalesmanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)TransportNav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@property (strong,nonatomic) NSMutableArray *sourceArr;

@end

@implementation TransportBusinessToSalesmanViewController

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

    self.nav = [[TransportNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"分配" andWithRightBtn:@"提交" andWithBgImg:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nav.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
}

- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//提交按钮
- (void)rightBtn:(UIButton *)sender{
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
    mutdic[@"Salesmanid"] = _str;
    mutdic[@"Phone"] = _str;
    
    //网络请求
    FBYHomeService *service1 = [[FBYHomeService alloc]init];
    
    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getSearchSalesmanList andSuccess:^(NSDictionary *dic) {
        
//                NSLog(@"%@",dic);
        
//                NSLog(@"%@",[dic objectForKey:@"msg"]);
        
        NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
        
        if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {
            
            self.dataArr = [dic objectForKey:@"data"];
            if ([_dataArr isEqual:[NSNull null]]) {
                
            }else{
                
                if (!_sourceArr) {
                    _sourceArr = [[NSMutableArray alloc]initWithCapacity:0];
                    
                    for (NSDictionary *dic in _dataArr){
                        
                        ManagerSearch *model = [ManagerSearch mj_objectWithKeyValues:dic];
                        [_sourceArr addObject:model];
                        [self.myTable reloadData];
                    }
                }
                
            }
        }
        
        
    } andFailure:^(int fail) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _sourceArr.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (void)searchBtn:(UIButton *)sender{
    
    TransportBusinessToSalesmanViewController *tbsvc = [[TransportBusinessToSalesmanViewController alloc]init];
    
    [self.navigationController pushViewController:tbsvc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    
    ManagerSearchSalesmanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (cell == nil) {
        cell = [[ManagerSearchSalesmanTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    ManagerSearch *model = self.sourceArr[indexPath.row];
    
    cell.model = model;
    
    cell.accept = ^(BOOL isAccept){
        
        [weakSelf updateIndexPathRowStatusSelected:isAccept section:indexPath];
        //        [weakSelf.myTable reloadData];
        
    };
    
    return cell;
}

//跟新确认键 //全选中改变状态
- (void)updateIndexPathRowStatusSelected:(BOOL)isSelected section:(NSIndexPath *)indexPath {
    
    //    NegoModel *model = self.sourceArr[indexPath.row];
    //    for (int i=0; i<self.sourceArr.count; i++) {
    //        Transport *model = self.sourceArr[i];
    //        if (indexPath.row ==i) {
    //            model.isAccept = isSelected;
    //            model.isTag = tag;
    //        }else{
    //            model.isAccept = NO;
    //            model.isTag = 4;
    //        }
    //    }
    
    
    
}

@end
