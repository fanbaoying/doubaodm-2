//
//  ViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/18.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "ViewController.h"
#import "FirstNav.h"
#import "FirstTableViewCell.h"
#import "BusinessViewController.h"
#import "FamilyViewController.h"

#import "MySelfViewController.h"
#import "FirstSearchViewController.h"

#import "OneFirstManagerViewController.h"
#import "FirstSalesmanViewController.h"
#import "FirstManagerViewController.h"

#import "FBYHomeService.h"
#import "AFNetworking.h"

@interface ViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)FirstNav *nav;

//搜索框
@property(strong,nonatomic)UISearchBar *searchBar;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *titleArr;

@property(strong,nonatomic)NSArray *contentArr;

@property(strong,nonatomic)NSMutableArray *dataArr;
@property(strong,nonatomic)NSArray *dataArrs;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH, 130)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
    self.myTable.showsVerticalScrollIndicator = NO;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.scrollEnabled = NO;
    
    NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
    NSString *grade = [gradeid objectForKey:@"gradeid"];
    
    //    NSLog(@"%@",grade);
    
    int intString = [grade intValue];
    if (intString == 0){
        self.titleArr = @[@"经理留言",@"部门留言"];
    }else if (intString == 1) {
        self.titleArr = @[@"主管留言",@"部门留言"];
    }else if (intString == 2){
        self.titleArr = @[@"业务员留言",@"部门留言"];
    }else if (intString == 3){
        self.titleArr = @[@"商户留言",@"部门留言"];
    }
    
    
    self.contentArr = @[@"[合同]请问一下怎么添加上架商品",@"[合同]阅读并提交合同条款"];
    
    self.nav = [[FirstNav alloc]initWithLeftBtn:nil andWithTitleLab:@"留言圈" andWithRightBtn:@"mySelf" andWithRightLeftBtn:@"search" andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.rightLeftBtn addTarget:self action:@selector(rightLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nav.rightBtn addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
    //搜索框
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
    self.searchBar.backgroundColor = [UIColor whiteColor];
    
    //    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.searchBar.placeholder = @"搜索商户／部门";
    
    self.searchBar.delegate = self;
    self.searchBar.tag = 1002;
    
    [self.view addSubview:_searchBar];
    
    [self.view addSubview:_myTable];
    
    //    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uitableViewTap:)];
    //
    //    [_myTable addGestureRecognizer:myTap];
    
}

//- (void)uitableViewTap:(id)sender{
//
//    [self.view endEditing:YES];
//
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

//我的页面跳转
- (void)right:(UIButton *)sender{
    
    MySelfViewController *msvc = [[MySelfViewController alloc]init];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController pushViewController:msvc animated:YES];
    
}

//搜索页面跳转
- (void)rightLeftBtn:(UIButton *)sender{
    
    FirstSearchViewController *fsvc = [[FirstSearchViewController alloc]init];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController pushViewController:fsvc animated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
    
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
    
    if (indexPath.row == 0) {
        
        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
        NSString *grade = [gradeid objectForKey:@"gradeid"];
        
        NSLog(@"%@",grade);
        int intString = [grade intValue];
        if (intString == 0) {
            OneFirstManagerViewController *ofmvc = [[OneFirstManagerViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:ofmvc animated:YES];
        }else if (intString == 1) {
            FirstManagerViewController *fmvc = [[FirstManagerViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:fmvc animated:YES];
        }else if (intString == 2){
            
            FirstSalesmanViewController *fsvc = [[FirstSalesmanViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:fsvc animated:YES];
            
        }else if (intString == 3){
            
            BusinessViewController *bvc = [[BusinessViewController alloc]init];
            
            self.tabBarController.tabBar.hidden = YES;
            
            [self.navigationController pushViewController:bvc animated:YES];
            
        }
        
        
    }else{
        NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
        NSString *token = [tokenid objectForKey:@"tokenid"];
        
        NSLog(@"%@",token);
        
        NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
        mutdic[@"token"] = @"047f528b28174892905f5c923c9596ec";
        mutdic[@"pageIndex"] = @"1";
        
        //网络请求
        FBYHomeService *service1 = [[FBYHomeService alloc]init];
        
        [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getCircleList andSuccess:^(NSDictionary *dic) {
            //            NSLog(@"%@",dic);
            //            NSLog(@"%@",[dic objectForKey:@"msg"]);
            NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
            
            if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {
                
                self.dataArrs = [dic objectForKey:@"data"];
                if ([_dataArrs isEqual:[NSNull null]]) {
                    
                }else{
                    
                    self.dataArr = [[NSMutableArray alloc]initWithCapacity:0];
                    
//                    NSDictionary *data;
                    for (int i = 0; i < _dataArrs.count; i++) {
                        
                        NSMutableDictionary *data=[NSMutableDictionary dictionaryWithCapacity:0];
                        
                        data[@"icon"] = [_dataArrs[i] objectForKey:@"adminUserName"];
                        //                        NSLog(@"%@",[_dataArrs[i] objectForKey:@"adminUserName"]);
                        data[@"name"] = [_dataArrs[i] objectForKey:@"adminUserName"];
                        data[@"shuoshuoText"] = [_dataArrs[i] objectForKey:@"content"];
                        
                        NSString *timeStr1 = [_dataArrs[i] objectForKey:@"ctime"];
                        NSTimeInterval interval1=[timeStr1 doubleValue] / 1000.0;
                        NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:interval1];
                        //实例化一个NSDateFormatter对象
                        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
                        //设定时间格式,这里可以设置成自己需要的格式
                        [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSString *currentDateStr1 = [dateFormatter1 stringFromDate:date1];
                        data[@"time"] = currentDateStr1;
                        
                        NSArray *commentListArr = [_dataArrs[i] objectForKey:@"commentList"];
                        NSMutableArray *AllCommentArr = [[NSMutableArray alloc]initWithCapacity:0];
                        NSLog(@"%lu",(unsigned long)commentListArr.count);
                        for (int j = 0; j < commentListArr.count; j++) {
                            
                            NSString *nameStr = [commentListArr[j] objectForKey:@"adminUserName"];
                            NSString *contentStr = [commentListArr[j] objectForKey:@"content"];
                            NSString *str = [NSString stringWithFormat:@"%@:%@",nameStr,contentStr];
                            NSArray *contentArr = @[str];
                            NSLog(@"%@",str);
                            [AllCommentArr addObjectsFromArray:contentArr];
                            
                            
                        }
                        
                        NSArray *arr = AllCommentArr;
                        
                        data[@"replys"] = arr;
                        NSArray *moreArr = @[data];
                        [_dataArr addObjectsFromArray:moreArr];
                        NSLog(@"%@",_dataArr);
                    }
                    
                    FamilyViewController *fvc = [[FamilyViewController alloc]init];
                    
                    fvc.arr = _dataArr;
                    
                    self.tabBarController.tabBar.hidden = YES;
                    
                    [self.navigationController pushViewController:fvc animated:YES];
                }
                
            }else{
                
                
                
            }
            
        } andFailure:^(int fail) {
            
        }];
        
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[FirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.codeImg.image = [UIImage imageNamed:@"sweep"];
    cell.codeNameLab.text = _titleArr[indexPath.row];
    cell.codeNumLab.text = _contentArr[indexPath.row];
    
    return cell;
}

@end
