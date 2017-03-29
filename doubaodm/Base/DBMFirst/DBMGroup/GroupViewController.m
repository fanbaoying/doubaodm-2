//
//  GroupViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/20.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "GroupViewController.h"
#import "Nav.h"
#import "FriendGroupViewController.h"
#import "GroupTableViewCell.h"

#import "UILabel+LabelHeightAndWidth.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

@interface GroupViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@property(assign,nonatomic)int count;

@property(strong,nonatomic)NSArray *contentArr;

@property(strong,nonatomic)UIView *headView;

@property(strong,nonatomic)UIButton *bgBtn;

@property(strong,nonatomic)UILabel *nameLab;

@property(strong,nonatomic)UIButton *headBtn;

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    self.headView.backgroundColor = [UIColor lightGrayColor];
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, -SCREEN_HEIGHT/8, SCREEN_WIDTH, SCREEN_HEIGHT+SCREEN_HEIGHT/8)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
//    self.myTable.showsVerticalScrollIndicator = NO;
    //    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.myTable.scrollEnabled = NO;
    
    self.myTable.tableHeaderView = _headView;
    [self.view addSubview:_myTable];
    
    self.bgBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2-40)];
    self.bgBtn.backgroundColor = [UIColor purpleColor];
    
    [self.headView addSubview:_bgBtn];
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3/5, SCREEN_HEIGHT/2-70, SCREEN_WIDTH/5, 30)];
    self.nameLab.text = @"FBY";
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    
    [self.headView addSubview:_nameLab];
    
    self.headBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*4/5, SCREEN_HEIGHT/2-SCREEN_WIDTH/5-SCREEN_WIDTH/32, SCREEN_WIDTH/5-SCREEN_WIDTH/32, SCREEN_WIDTH/5-SCREEN_WIDTH/32)];
    self.headBtn.backgroundColor = [UIColor redColor];
    
    [self.headView addSubview:_headBtn];
    
    
    self.contentArr = @[@"聊天气泡",@"聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡",@"聊天气泡",@"聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡",@"聊天气泡聊天气泡",@"聊天气泡",@"聊天气泡聊天气泡聊天气泡聊天气泡",@"聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡聊天气泡"];
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"部门圈" andWithRightBtn:@"add" andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.nav.rightBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
}

//导航栏返回
- (void)back:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

//编辑
- (void)add:(UIButton *)sender{
    
    FriendGroupViewController *fgvc = [[FriendGroupViewController alloc]init];
    
    [self.navigationController pushViewController:fgvc animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
//    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
//    NSString *token = [tokenid objectForKey:@"tokenid"];
//    
//    NSLog(@"%@",token);
//    
//    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
//    
//    mutdic[@"token"] = token;
//    mutdic[@"pageIndex"] = @"1";
//    
//    //广告网络请求
//    FBYHomeService *service1 = [[FBYHomeService alloc]init];
//    
//    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getSalesmanCommentMessageList andSuccess:^(NSDictionary *dic) {
//        
//        NSLog(@"%@",dic);
//        
//        if (dic == nil) {
//            
//        }else{
//            
//            NSString *msg = [dic objectForKey:@"msg"];
//            
//            NSLog(@"%@",msg);
//
//            if ([msg isEqualToString:@"获取部门评论信息成功"]) {
//
//                self.dataArr = [dic objectForKey:@"data"];
//                
//                if ([_dataArr isEqual:[NSNull null]]) {
//                    
//                }else{
//
//                    self.nameLab = [_dataArr[0] objectForKey:@"fullname"];
//                    
//                    [self.myTable reloadData];
//                }
//                
//            }else{
//                
//            }
//        }
//        
//    } andFailure:^(int fail) {
//        
//    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return _dataArr.count;
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    根据内容计算高度
    CGRect rect = [_contentArr[indexPath.row] boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-120, MAXFLOAT)
                                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    //再加上其他控件的高度得到cell的高度
    
    NSLog(@"%f",rect.size.height);
    
    return rect.size.height + 60;
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[GroupTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
//    [cell.headBtn setTitle:[_dataArr[indexPath.row] objectForKey:@"fullname"] forState:UIControlStateNormal];
//    cell.contentLab.text = [_dataArr[indexPath.row] objectForKey:@"message"];
    
    [cell.headBtn setTitle:@"张三" forState:UIControlStateNormal];
    cell.contentLab.text = _contentArr[indexPath.row];
    
    cell.timeLab.text = @"12小时前";
//    [cell.messageBtn setTitle:[_dataArr[indexPath.row] objectForKey:@"fullname"] forState:UIControlStateNormal];
    
    return cell;
}


@end
