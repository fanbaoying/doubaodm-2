//
//  NewLoginViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/15.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "NewLoginViewController.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "FBYHomeService.h"

#import "SecondViewController.h"
#import "Nav.h"


//#import "MQGuideView.h"

@interface NewLoginViewController ()
@property (assign,nonatomic) BOOL isFirstLaunch;
//@property (strong,nonatomic) MQGuideView *guideView;

@property(strong,nonatomic)UILabel *numLabel;

@property(strong,nonatomic)UILabel *pwLabel;

@property(strong,nonatomic)UITextField *numText;

@property(strong,nonatomic)UITextField *pwText;

@property(strong,nonatomic)UIButton *registerBtn;

@property(strong,nonatomic)UIButton *loginBtn;

@property(strong,nonatomic)UIView *myView;

@property(strong,nonatomic)UIButton *ForgetPasswordBtn;

@end

@implementation NewLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-113)];
    self.myView.backgroundColor = [UIColor clearColor];

    self.numText = [[UITextField alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/2-130, SCREEN_WIDTH-60, 40)];
    self.numText.placeholder = @"请输入账号";
    [self.numText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.numText.keyboardType = 4;
    self.numText.font = [UIFont systemFontOfSize:12.0];
    
    //线
    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-94, SCREEN_WIDTH-60, 0.5)];
    self.numLabel.backgroundColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1];
    
    
    self.pwText = [[UITextField alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-80, SCREEN_WIDTH-60, 40)];
    self.pwText.placeholder = @"请输入密码";
    self.pwText.secureTextEntry = YES;
    [self.pwText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.pwText.keyboardType = 1;
    self.pwText.font = [UIFont systemFontOfSize:12.0];
    
    //线
    self.pwLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-44, SCREEN_WIDTH-60, 0.5)];
    self.pwLabel.backgroundColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1];
    
    //注册按钮
//    self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-44, (SCREEN_WIDTH-90)/2, 40)];
//    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [self.registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //    [self.registerBtn.layer setBorderWidth:0.5];
//    //    self.registerBtn.layer.borderColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1].CGColor;
//    [self.registerBtn.layer setCornerRadius:5.0];
//    self.registerBtn.titleLabel.font  = [UIFont systemFontOfSize:12.0];
    //点击事件
//    [self.registerBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //忘记密码按钮
    self.ForgetPasswordBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH-90)/2, SCREEN_HEIGHT/2-44, (SCREEN_WIDTH-90)/2, 40)];
    [self.ForgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.ForgetPasswordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.ForgetPasswordBtn.titleLabel.font  = [UIFont systemFontOfSize:12.0];
    [self.ForgetPasswordBtn addTarget:self action:@selector(forgetpassword:) forControlEvents:UIControlEventTouchUpInside];
    
    //登录按钮
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT/2+26, SCREEN_WIDTH-40, 40)];
    self.loginBtn.backgroundColor = [UIColor lightGrayColor];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginBtn.layer setCornerRadius:5.0];
    self.loginBtn.titleLabel.font  = [UIFont systemFontOfSize:14.0];
    [self.loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //键盘的显示和退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.view addSubview:_myView];
    [self.myView addSubview:_ForgetPasswordBtn];
    [self.myView addSubview:_loginBtn];
//    [self.myView addSubview:_registerBtn];
    
    [self.myView addSubview:_numLabel];
    [self.myView addSubview:_pwLabel];
    [self.myView addSubview:_numText];
    [self.myView addSubview:_pwText];
    
    
}
//限制手机号输入
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.numText) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    
    if (textField == self.pwText) {
        if (textField.text.length > 5 & textField.text.length < 21) {
            
            self.loginBtn.backgroundColor = [UIColor colorWithRed:174/255.0 green:109/255.0 blue:45/255.0 alpha:1];
            
            //点击事件
            [self.loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else
            if (textField.text.length > 20){
                
                textField.text = [textField.text substringToIndex:20];
            }else{
                
                self.loginBtn.backgroundColor = [UIColor lightGrayColor];
                
            }
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

//pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.myView.transform = CGAffineTransformMakeTranslation(0, - ty + 170);
    }];
    
}
//pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.myView.transform = CGAffineTransformIdentity;
    }];
}

//- (void)viewWillAppear:(BOOL)animated{
//    
//    [super viewWillAppear:animated];
//    
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLaunch"]) {
//        _isFirstLaunch = YES;
//        [[NSUserDefaults standardUserDefaults] setBool:_isFirstLaunch forKey:@"isFirstLaunch"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        _guideView = [[MQGuideView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        _guideView.delegate = self;
//        [self.view addSubview:_guideView];
//    }
//}

//- (void)onPassButtonPressed{
//    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        _guideView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [_guideView removeFromSuperview];
//    }];
//}

- (void)forgetpassword:(UIButton *)sender{
    
//    ForgetPasswordViewController *fpvc = [[ForgetPasswordViewController alloc]init];
//    
//    [self presentViewController:fpvc animated:YES completion:nil];
    
}

- (void)loginBtn:(UIButton *)sender{
    
    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
    
//        mutdic[@"phone"] = _numText.text;
//        mutdic[@"password"] = _pwText.text;

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择身份" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"CEO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        mutdic[@"phone"] = @"15656880001";
        mutdic[@"password"] = @"888888";
        
        //网络请求
        FBYHomeService *service1 = [[FBYHomeService alloc]init];
        
        [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:loginOrRegister andSuccess:^(NSDictionary *dic) {
            
            NSLog(@"%@",dic);
            NSString *str = [dic objectForKey:@"status"];
            
            int intString = [str intValue];
            
            if (intString == 0) {
                NSDictionary *dic1 = [dic objectForKey:@"data"];
                if ([dic1 isEqual:[NSNull null]]) {
                    
                }else{
                    NSDictionary *dic2 = [dic1 objectForKey:@"adminUser"];
                    NSDictionary *dic3 = [dic1 objectForKey:@"userRole"];
                    
                    NSString *token = [dic2 objectForKey:@"token"];
                    
                    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
                    [tokenid setObject:token forKey:@"tokenid"];
                    [tokenid synchronize];
                    
                    NSString *grade = [dic3 objectForKey:@"roleName"];
                    NSLog(@"%@",grade);
                    
                    if ([grade isEqualToString:[NSString stringWithFormat:@"业务员"]]) {
                        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                        [gradeid setObject:@"3" forKey:@"gradeid"];
                        [gradeid synchronize];
                    }else if ([grade isEqualToString:[NSString stringWithFormat:@"主管"]]){
                        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                        [gradeid setObject:@"2" forKey:@"gradeid"];
                        [gradeid synchronize];
                    }else if ([grade isEqualToString:[NSString stringWithFormat:@"经理"]]){
                        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                        [gradeid setObject:@"1" forKey:@"gradeid"];
                        [gradeid synchronize];
                    }else if ([grade isEqualToString:[NSString stringWithFormat:@"CEO"]]){
                        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                        [gradeid setObject:@"0" forKey:@"gradeid"];
                        [gradeid synchronize];
                    }
                    
                    ViewController *vc = [[ViewController alloc]init];
                    SecondViewController *sc = [[SecondViewController alloc]init];
                    
                    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc];
                    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:sc];;
                    
                    //选中与未被选中图片的渲染
                    nav1.tabBarItem.title = @"留言";
                    //    nav1.tabBarItem.image = [UIImage imageNamed:@"TAG.jpg"];
                    nav1.tabBarItem.image = [[UIImage imageNamed:@"first"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"firsts"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    
                    nav2.tabBarItem.title = @"工作";
                    nav2.tabBarItem.image = [[UIImage imageNamed:@"second"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    //    nav2.tabBarItem.image = [[UIImage imageNamed:@""]];
                    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"seconds"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    
                    self.tabBar = [[UITabBarController alloc]init];
                    self.tabBar.viewControllers = @[nav1,nav2];
                    
                    //隐藏导航栏
                    nav1.navigationBarHidden = YES;
                    nav2.navigationBarHidden = YES;
                    
                    [self presentViewController:_tabBar animated:NO completion:nil];
                }
            }else if(intString == 1){
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                
                [alert addAction:action1];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        } andFailure:^(int fail) {
            
        }];
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"经理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        mutdic[@"phone"] = @"15996602085";//经理
        mutdic[@"password"] = @"888888";
        
        //网络请求
        FBYHomeService *service1 = [[FBYHomeService alloc]init];
        
        [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:loginOrRegister andSuccess:^(NSDictionary *dic) {
            
            NSLog(@"%@",dic);
            NSString *str = [dic objectForKey:@"status"];
            
            int intString = [str intValue];
            
            if (intString == 0) {
                NSDictionary *dic1 = [dic objectForKey:@"data"];
                if ([dic1 isEqual:[NSNull null]]) {
                    
                }else{
                    NSDictionary *dic2 = [dic1 objectForKey:@"adminUser"];
                    NSDictionary *dic3 = [dic1 objectForKey:@"userRole"];
                    
                    NSString *token = [dic2 objectForKey:@"token"];
                    
                    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
                    [tokenid setObject:token forKey:@"tokenid"];
                    [tokenid synchronize];
                    
                    NSString *grade = [dic3 objectForKey:@"roleName"];
                    NSLog(@"%@",grade);
                    
                    if ([grade isEqualToString:[NSString stringWithFormat:@"业务员"]]) {
                        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                        [gradeid setObject:@"3" forKey:@"gradeid"];
                        [gradeid synchronize];
                    }else if ([grade isEqualToString:[NSString stringWithFormat:@"主管"]]){
                        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                        [gradeid setObject:@"2" forKey:@"gradeid"];
                        [gradeid synchronize];
                    }else if ([grade isEqualToString:[NSString stringWithFormat:@"经理"]]){
                        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                        [gradeid setObject:@"1" forKey:@"gradeid"];
                        [gradeid synchronize];
                    }
                    
                    ViewController *vc = [[ViewController alloc]init];
                    SecondViewController *sc = [[SecondViewController alloc]init];
                    
                    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc];
                    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:sc];;
                    
                    //选中与未被选中图片的渲染
                    nav1.tabBarItem.title = @"留言";
                    //    nav1.tabBarItem.image = [UIImage imageNamed:@"TAG.jpg"];
                    nav1.tabBarItem.image = [[UIImage imageNamed:@"first"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"firsts"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    
                    nav2.tabBarItem.title = @"工作";
                    nav2.tabBarItem.image = [[UIImage imageNamed:@"second"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    //    nav2.tabBarItem.image = [[UIImage imageNamed:@""]];
                    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"seconds"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    
                    self.tabBar = [[UITabBarController alloc]init];
                    self.tabBar.viewControllers = @[nav1,nav2];
                    
                    //隐藏导航栏
                    nav1.navigationBarHidden = YES;
                    nav2.navigationBarHidden = YES;
                    
                    [self presentViewController:_tabBar animated:NO completion:nil];
                }
            }else if(intString == 1){
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                
                [alert addAction:action1];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        } andFailure:^(int fail) {
            
        }];
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"主管" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        mutdic[@"phone"] = @"15170047544";
        mutdic[@"password"] = @"888888";
        
        //网络请求
        FBYHomeService *service1 = [[FBYHomeService alloc]init];
        
        [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:loginOrRegister andSuccess:^(NSDictionary *dic) {
            
            NSLog(@"%@",dic);
            NSString *str = [dic objectForKey:@"status"];
            
            int intString = [str intValue];
            
            if (intString == 0) {
            NSDictionary *dic1 = [dic objectForKey:@"data"];
                if ([dic1 isEqual:[NSNull null]]) {
                    
                }else{
            NSDictionary *dic2 = [dic1 objectForKey:@"adminUser"];
            NSDictionary *dic3 = [dic1 objectForKey:@"userRole"];
            
            NSString *token = [dic2 objectForKey:@"token"];
            
            NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
            [tokenid setObject:token forKey:@"tokenid"];
            [tokenid synchronize];
            
            NSString *grade = [dic3 objectForKey:@"roleName"];
            NSLog(@"%@",grade);
            
            if ([grade isEqualToString:[NSString stringWithFormat:@"业务员"]]) {
                NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                [gradeid setObject:@"3" forKey:@"gradeid"];
                [gradeid synchronize];
            }else if ([grade isEqualToString:[NSString stringWithFormat:@"主管"]]){
                NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                [gradeid setObject:@"2" forKey:@"gradeid"];
                [gradeid synchronize];
            }else if ([grade isEqualToString:[NSString stringWithFormat:@"经理"]]){
                NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                [gradeid setObject:@"1" forKey:@"gradeid"];
                [gradeid synchronize];
            }
            
            ViewController *vc = [[ViewController alloc]init];
            SecondViewController *sc = [[SecondViewController alloc]init];
            
            UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc];
            UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:sc];;
            
            //选中与未被选中图片的渲染
            nav1.tabBarItem.title = @"留言";
            //    nav1.tabBarItem.image = [UIImage imageNamed:@"TAG.jpg"];
            nav1.tabBarItem.image = [[UIImage imageNamed:@"first"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"firsts"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            nav2.tabBarItem.title = @"工作";
            nav2.tabBarItem.image = [[UIImage imageNamed:@"second"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            //    nav2.tabBarItem.image = [[UIImage imageNamed:@""]];
            nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"seconds"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            self.tabBar = [[UITabBarController alloc]init];
            self.tabBar.viewControllers = @[nav1,nav2];
            
            //隐藏导航栏
            nav1.navigationBarHidden = YES;
            nav2.navigationBarHidden = YES;

            [self presentViewController:_tabBar animated:NO completion:nil];
                }
            }else if(intString == 1){
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                
                [alert addAction:action1];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        } andFailure:^(int fail) {
            
        }];
        
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"业务员" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
//        mutdic[@"phone"] = @"13127815581";
        mutdic[@"phone"] = @"18306131899";
        mutdic[@"password"] = @"123456";
        
        //网络请求
        FBYHomeService *service1 = [[FBYHomeService alloc]init];
        
        [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:loginOrRegister andSuccess:^(NSDictionary *dic) {
            
            NSLog(@"%@",dic);
            NSString *str = [dic objectForKey:@"status"];
            
            int intString = [str intValue];
            
            if (intString == 0) {
                NSDictionary *dic1 = [dic objectForKey:@"data"];
                if ([dic1 isEqual:[NSNull null]]) {
                    
                }else{
                    NSDictionary *dic2 = [dic1 objectForKey:@"adminUser"];
                    NSDictionary *dic3 = [dic1 objectForKey:@"userRole"];
                    
                    NSString *token = [dic2 objectForKey:@"token"];
                    NSLog(@"%@",token);
                    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
                    [tokenid setObject:token forKey:@"tokenid"];
                    [tokenid synchronize];
                    
                    NSString *grade = [dic3 objectForKey:@"roleName"];
                    NSLog(@"%@",grade);
                    
                    if ([grade isEqualToString:[NSString stringWithFormat:@"业务员"]]) {
                        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                        [gradeid setObject:@"3" forKey:@"gradeid"];
                        [gradeid synchronize];
                    }else if ([grade isEqualToString:[NSString stringWithFormat:@"主管"]]){
                        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                        [gradeid setObject:@"2" forKey:@"gradeid"];
                        [gradeid synchronize];
                    }else if ([grade isEqualToString:[NSString stringWithFormat:@"经理"]]){
                        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
                        [gradeid setObject:@"1" forKey:@"gradeid"];
                        [gradeid synchronize];
                    }
                    
                    ViewController *vc = [[ViewController alloc]init];
                    SecondViewController *sc = [[SecondViewController alloc]init];
                    
                    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc];
                    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:sc];;
                    
                    //选中与未被选中图片的渲染
                    nav1.tabBarItem.title = @"留言";
                    //    nav1.tabBarItem.image = [UIImage imageNamed:@"TAG.jpg"];
                    nav1.tabBarItem.image = [[UIImage imageNamed:@"first"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"firsts"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    
                    nav2.tabBarItem.title = @"工作";
                    nav2.tabBarItem.image = [[UIImage imageNamed:@"second"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                    //    nav2.tabBarItem.image = [[UIImage imageNamed:@""]];
                    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"seconds"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                    
                    self.tabBar = [[UITabBarController alloc]init];
                    self.tabBar.viewControllers = @[nav1,nav2];
                    
                    //隐藏导航栏
                    nav1.navigationBarHidden = YES;
                    nav2.navigationBarHidden = YES;
                    
                    [self presentViewController:_tabBar animated:NO completion:nil];
                }
            }else if(intString == 1){
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"msg"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                }];
                
                [alert addAction:action1];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        } andFailure:^(int fail) {
            
        }];
        
    }];
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [alert addAction:action4];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}

@end
