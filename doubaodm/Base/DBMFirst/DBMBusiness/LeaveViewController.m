//
//  LeaveViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/20.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "LeaveViewController.h"
#import "Nav.h"
#import "LeaveTableViewCell.h"
#import "AFNetworking.h"

//下拉刷新
#import "MJRefresh.h"

#import "AFNetworking.h"
#import "FBYHomeService.h"

#import "OtherDataViewController.h"

@interface LeaveViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *titleArr;

@property(assign,nonatomic)int pageNum;

@property(strong,nonatomic)NSMutableArray *contentArr;
@property(strong,nonatomic)NSMutableArray *nameArr;

@property(strong,nonatomic)UITextView *myTextView;

@property(strong,nonatomic)UIButton *okBtn;

@property(strong,nonatomic)UIView *foodView;

@property(strong,nonatomic)UIView *headView;

@property(strong,nonatomic)UIView *headView1;

@property(strong,nonatomic)UIView *headView2;

@property(assign,nonatomic)BOOL head;

@property(strong,nonatomic)NSArray *dataArr;

@property(strong,nonatomic)NSString *nameString;

@end

@implementation LeaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    self.headView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_headView];
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-114)];
    self.myTable.backgroundColor = [UIColor whiteColor];
    self.myTable.delegate = self;
    self.myTable.dataSource =self;
//    self.myTable.showsVerticalScrollIndicator = NO;
    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myTable];
    
    self.contentArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.nameArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:_nameStr andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
    
    self.myTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 40)];//这里特意让UITextView处于屏幕右下角,这样如果self.view不上移,肯定会被键盘挡住的
//    self.myTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
//    self.myTextView.keyboardType = UIKeyboardTypeASCIICapable;
    self.myTextView.returnKeyType = UIReturnKeySend;
    self.myTextView.layer.cornerRadius = 5.0;
    self.myTextView.clipsToBounds = YES;
    [self.myTextView setFont:[UIFont systemFontOfSize:15]];
    self.myTextView.returnKeyType = UIReturnKeySend;
    self.myTextView.delegate = self;
    self.myTextView.backgroundColor = [UIColor lightGrayColor];

    
    self.foodView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
    self.foodView.backgroundColor = [UIColor clearColor];
    
    //MJRefresh下拉加载
    self.myTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(MJRefresh_header)];

    //添加通知
    //键盘出现时发起一个通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘出现是发起一个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //界面滑动时键盘消失
    self.myTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //添加手势，点击界面是键盘消失
    [self.myTable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)]];

    
    
    [self.foodView addSubview:self.myTextView];
    [self.view addSubview:_foodView];
    
    self.head = NO;
    
}

#pragma mark - 键盘显示  通知发生的方法
-(void)keyboardWillShow:(NSNotification *)sender{
    CGFloat keyboardHeight=[[sender.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue].size.height;
    if ((self.myTable.frame.size.height-keyboardHeight)>self.myTable.contentSize.height) {
        self.myTable.transform=CGAffineTransformMakeTranslation(0, -keyboardHeight);
        self.myTextView.transform=CGAffineTransformMakeTranslation(0, -keyboardHeight);//当tableView的内容高度大于
    }else{
        self.myTable.transform=CGAffineTransformMakeTranslation(0, -keyboardHeight);
        self.myTextView.transform=CGAffineTransformMakeTranslation(0, -keyboardHeight);
    }
    [self.view layoutSubviews];
}
#pragma 点击视图键盘隐藏
-(void)keyboardHide{
    [self.myTextView resignFirstResponder];//取消第一响应者键盘消失
}
#pragma mark - 键盘隐藏  通知发生的方法
-(void)keyboardWillHide:(NSNotification *)sender{
    self.myTable.transform=CGAffineTransformMakeTranslation(0, 0);
    self.myTextView.transform=CGAffineTransformMakeTranslation(0, 0);
    [self.view layoutSubviews];
}
#pragma mark - 通知移除
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


//输入框高度自适应

//发送输入内容
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSLog(@"%@",text);

    if ([text isEqualToString:@"\n"]) {

    if (self.myTextView.text == nil) {
        
    }else{
        
        NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
        NSString *token = [tokenid objectForKey:@"tokenid"];
        
//        NSLog(@"%@",token);
        
        NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
        
        mutdic[@"token"] = token;
        mutdic[@"businessid"] = _str;
        mutdic[@"content"] = _myTextView.text;
        
        //网络请求
        FBYHomeService *service1 = [[FBYHomeService alloc]init];
        
        [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:sendMerchantMessage andSuccess:^(NSDictionary *dic) {
            
            NSLog(@"%@",dic);
            NSString *msg = [dic objectForKey:@"msg"];
            
            NSLog(@"%@",msg);
            NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
            
            if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {

                    NSDictionary *dataDic = [dic objectForKey:@"data"];
                    
                    if ([_dataArr isEqual:[NSNull null]]) {
                        
                    }else{
                        
                    NSArray *contentarr = @[[dataDic objectForKey:@"content"]];
                    
                        NSMutableArray *dataArr = [[NSMutableArray alloc]initWithCapacity:0];
                        [dataArr addObjectsFromArray:_contentArr];
                    
                        [self.contentArr removeAllObjects];
                        [self.contentArr addObjectsFromArray:contentarr];
                        [self.contentArr addObjectsFromArray:dataArr];
                        
                        _nameString = [dataDic objectForKey:@"merchantUserName"];
                    NSArray *namearr = @[_nameString];
                        NSMutableArray *dataNameArr = [[NSMutableArray alloc]initWithCapacity:0];
                        [dataNameArr addObjectsFromArray:_nameArr];
                        
                        [self.nameArr removeAllObjects];
                        [self.nameArr addObjectsFromArray:namearr];
                        [self.nameArr addObjectsFromArray:dataNameArr];
//                    [self.nameArr addObjectsFromArray:namearr];
                    [self.myTable reloadData];
                    
                    if (_contentArr.count <= 5) {
                        self.myTable.mj_header.hidden = YES;
                    }else{
                        
                        self.myTable.mj_header.hidden = NO;
                    }
                    
                    [self.myTable setContentOffset:CGPointMake(0, self.myTable.contentSize.height -self.myTable.bounds.size.height) animated:YES];
                    
                    self.myTextView.text = nil;
                        
                    }
                    
            }
            
        } andFailure:^(int fail) {
            
        }];

        }
    }
    
    return YES;
}


- (void)applicationDidEnterBackground:(NSNotification *)paramNotification
{
    NSLog(@"应用已经进入后台,%@", paramNotification);
    [self.myTextView resignFirstResponder];
}

//下拉刷新
- (void)MJRefresh_header{
    
    [self.myTable.mj_header beginRefreshing];
    
    //    网络监控句柄
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if ((long)status == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络不给力" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"请检查网络" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            [alert addAction:action1];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        //status:
        //AFNetworkReachabilityStatusUnknown          = -1,  未知
        //AFNetworkReachabilityStatusNotReachable     = 0,   未连接
        //AFNetworkReachabilityStatusReachableViaWWAN = 1,   3G
        //AFNetworkReachabilityStatusReachableViaWiFi = 2,   无线连接
        //            NSLog(@"%ldhahahhahh", (long)status);
    }];
    
    self.pageNum++;
    
    NSString *str = [NSString stringWithFormat:@"%d",_pageNum];

    
    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenid objectForKey:@"tokenid"];
    
    //    NSLog(@"%@",token);
    
    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
    
    mutdic[@"token"] = @"f9d8b97d22164820992c2912d689111a";
//    mutdic[@"token"] = token;
    mutdic[@"pageIndex"] = str;
    mutdic[@"businessid"] = _str;
    
    //网络请求
    FBYHomeService *service1 = [[FBYHomeService alloc]init];
    
    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getMerchantRecord andSuccess:^(NSDictionary *dic) {
        
                NSLog(@"%@",dic);
        
        NSString *str = [dic objectForKey:@"status"];
        
        int intString = [str intValue];
        
        if (intString == 0) {
            
            self.dataArr = [dic objectForKey:@"data"];
            if (_dataArr.count == 0) {
                self.pageNum--;
                
                NSLog(@"%d",_pageNum);
            }else{
                
                for (int i = 0;i < _dataArr.count; i++) {
                    
                    NSArray *contentarr = @[[_dataArr[i] objectForKey:@"content"]];
                    
                    [self.contentArr addObjectsFromArray:contentarr];
                    _nameString = [_dataArr[i] objectForKey:@"merchantUserName"];
                    NSArray *namearr = @[_nameString];
                    [self.nameArr addObjectsFromArray:namearr];
                    
                }
                NSLog(@"%@",_contentArr);
                [self.myTable reloadData];
                
                if (_contentArr.count <= 5) {
                    self.myTable.mj_header.hidden = YES;
                }else{
                    
                    self.myTable.mj_header.hidden = NO;
                }
                
                [self.myTable setContentOffset:CGPointMake(0, self.myTable.contentSize.height -self.myTable.bounds.size.height) animated:YES];
                
            }
            
        }else if(intString == 1){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"数据请求失败" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            
            [alert addAction:action1];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    } andFailure:^(int fail) {
        
    }];
    
    [self.myTable.mj_header endRefreshing];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self.view endEditing:YES];
}


- (void)back:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _contentArr.count;
    
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

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LeaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[LeaveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell.headBtn setTitle:_nameArr[_nameArr.count-1-indexPath.row] forState:UIControlStateNormal];
    [cell.headBtn addTarget:self action:@selector(headBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.contentLab.text = _contentArr[_contentArr.count-1-indexPath.row];
    cell.lookMoreLab.hidden = YES;
    
    return cell;
}

- (void)headBtn:(UIButton *)sender{

    OtherDataViewController *odvc = [[OtherDataViewController alloc]init];
    
    [self.navigationController pushViewController:odvc animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.pageNum = 1;
    
    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenid objectForKey:@"tokenid"];
    
    NSLog(@"%@",token);
    
    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
    
    mutdic[@"token"] = @"f9d8b97d22164820992c2912d689111a";
//    mutdic[@"token"] = token;
    mutdic[@"businessid"] = _str;
    mutdic[@"pageIndex"] = @"1";
    
    //广告网络请求
    FBYHomeService *service1 = [[FBYHomeService alloc]init];
    
    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getMerchantRecord andSuccess:^(NSDictionary *dic) {
        
                NSLog(@"%@",dic);
        NSLog(@"%@",[dic objectForKey:@"msg"]);
        
        NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
        
        if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {
            
            self.dataArr = [dic objectForKey:@"data"];
            if (_dataArr.count == 0) {
                
            }else{
                
                for (int i = 0;i < _dataArr.count; i++) {

                NSArray *contentarr = @[[_dataArr[i] objectForKey:@"content"]];
                
                [self.contentArr addObjectsFromArray:contentarr];
                _nameString = [_dataArr[i] objectForKey:@"merchantUserName"];
                NSArray *namearr = @[_nameString];
                [self.nameArr addObjectsFromArray:namearr];
                    
                }
                NSLog(@"%@",_contentArr);
                [self.myTable reloadData];
                
                if (_contentArr.count <= 5) {
                    self.myTable.mj_header.hidden = YES;
                }else{
                    
                    self.myTable.mj_header.hidden = NO;
                }
                
                [self.myTable setContentOffset:CGPointMake(0, self.myTable.contentSize.height -self.myTable.bounds.size.height) animated:YES];
                
            }
        }
        
        
        
    } andFailure:^(int fail) {
        
    }];
    
}


@end
