//
//  ManagerSearchSalesmanViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/16.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "ManagerSearchSalesmanViewController.h"
#import "TransportNav.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

#import "ManagerSearch.h"
#import "MJExtension.h"

#import "ManagerSearchSalesmanTableViewCell.h"

#import "TransportBusinessToSalesmanViewController.h"

@interface ManagerSearchSalesmanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)TransportNav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@property (strong,nonatomic) NSMutableArray *sourceArr;

@property(strong,nonatomic)UIView *headView;

@property(strong,nonatomic)UILabel *titleLab;

@property(strong,nonatomic)UITextField *nameTextField;

@property(strong,nonatomic)UIButton *searchBtn;

@end

@implementation ManagerSearchSalesmanViewController

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
    
    if (!_sourceArr) {
        _sourceArr = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.dataArr = @[@{@"salesmanname":@"业务员张"},
                         @{@"salesmanname":@"业务员王"},
                         @{@"salesmanname":@"业务员李"},
                         @{@"salesmanname":@"业务员赵"},
                         @{@"salesmanname":@"业务员钱"}
                         ];
        
        for (NSDictionary *dic in _dataArr){
            
            ManagerSearch *model = [ManagerSearch mj_objectWithKeyValues:dic];
            [_sourceArr addObject:model];
            [self.myTable reloadData];
        }
    }
    
    self.nav = [[TransportNav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"搜索" andWithRightBtn:@"提交" andWithBgImg:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.nav.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [_myTable addGestureRecognizer:myTap];
    
}

- (void)scrollTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
    
}

- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)rightBtn:(UIButton *)sender{
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _sourceArr.count;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return SCREEN_HEIGHT/6;
    
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/6)];
    self.headView.backgroundColor = [UIColor whiteColor];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, SCREEN_HEIGHT/6-10)];
    headView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    headView.layer.cornerRadius = 5.0;
    headView.clipsToBounds = YES;
    
    [self.headView addSubview:headView];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH/2, 30)];
    self.titleLab.font = [UIFont systemFontOfSize:14.0];
    self.titleLab.text = @"归属到业务员：";
    [headView addSubview:_titleLab];
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH*2/3, 35)];
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.nameTextField.font = [UIFont systemFontOfSize:12.0];
    self.nameTextField.placeholder = @"请输入业务员ID／手机号";
    [headView addSubview:_nameTextField];
    
    self.searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/3+20, 40, 40, 30)];
    self.searchBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.searchBtn addTarget:self action:@selector(searchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBtn setTitle:@"搜索" forState:0];
    
    [headView addSubview:_searchBtn];
    
    return _headView;
}

- (void)searchBtn:(UIButton *)sender{

    TransportBusinessToSalesmanViewController *tbsvc = [[TransportBusinessToSalesmanViewController alloc]init];
    
    tbsvc.str = _nameTextField.text;
    
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
