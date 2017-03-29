//
//  TransportViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "TransportViewController.h"
#import "TransportNav.h"

#import "TransportTableViewCell.h"

#import "Transport.h"
#import "MJExtension.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

@interface TransportViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)TransportNav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@property (strong,nonatomic) NSMutableArray *sourceArr;

@end

@implementation TransportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-94)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
    self.myTable.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_myTable];
    
    if (!_sourceArr) {
        _sourceArr = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.dataArr = @[@{@"title":@"招商客户",
                           @"content":@[@"资料客户",@"潜在客户",@"意向客户"],
                           },
                         @{@"title":@"电子签约",
                           @"content":@[@"条款确认",@"资质审核",@"待审核"],
                           },
                         @{@"title":@"设备实施",
                           @"content":@[@"设备预约商户",@"审核成功商户",@"设备安装商户"],
                           },
                         @{@"title":@"后期维护",
                           @"content":@[@"一级维护",@"二级维护",@"三级维护"],
                           }
                         ];
        
        
        for (NSDictionary *dic in _dataArr){
            
            Transport *model = [Transport mj_objectWithKeyValues:dic];
            [_sourceArr addObject:model];
            [self.myTable reloadData];
        }
    }
    
    self.nav = [[TransportNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"移动" andWithRightBtn:@"提交" andWithBgImg:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nav.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
}

- (void)back:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightBtn:(UIButton *)sender{
    
    for (int i=0; i<self.sourceArr.count ; i++) {
        Transport *model = self.sourceArr[i];
        if (model.isAccept) {
            
            NSArray *arr = [NSArray mj_objectArrayWithKeyValuesArray:model.content];
            NSString *str = arr[model.isTag-1000];
//            NSLog(@"提交=====%@",str);
            
            NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
            NSString *token = [tokenid objectForKey:@"tokenid"];
            
//            NSLog(@"%@",token);
            
            NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
            mutdic[@"token"] = token;
            mutdic[@"businessid"] = _str;
            mutdic[@"stepstate"] = str;
            
            //网络请求
            FBYHomeService *service1 = [[FBYHomeService alloc]init];
            
            [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:AddBusinessmanToSalesmanList andSuccess:^(NSDictionary *dic) {
                
                NSLog(@"%@",dic);
                
                        NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
                
                        if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {
                                        
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"移动成功" preferredStyle:UIAlertControllerStyleAlert];
                                        
                            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                            
                                            
                            }];
                                        
                            [alert addAction:action1];
                            [self presentViewController:alert animated:YES completion:nil];
                            
                            }

                
            } andFailure:^(int fail) {
                
            }];
            
            return ;
        }else{
            
        }
    }
    
//    NSLog(@"请选择");

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _sourceArr.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    
    TransportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (cell == nil) {
        cell = [[TransportTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    Transport *model = self.sourceArr[indexPath.row];
    
    cell.model = model;

        cell.accept = ^(BOOL isAccept, NSInteger tag ){
            
            [weakSelf updateIndexPathRowStatusSelected:isAccept section:indexPath tag:tag];
            [weakSelf.myTable reloadData];
            
        };

    return cell;
}

//跟新确认键 //全选中改变状态
- (void)updateIndexPathRowStatusSelected:(BOOL)isSelected section:(NSIndexPath *)indexPath tag:(NSInteger)tag{
        
        //    NegoModel *model = self.sourceArr[indexPath.row];
        for (int i=0; i<self.sourceArr.count; i++) {
            Transport *model = self.sourceArr[i];
            if (indexPath.row ==i) {
                model.isAccept = isSelected;
                model.isTag = tag;
            }else{
                model.isAccept = NO;
                model.isTag = 4;
            }
        }
        
        
        
}

@end
