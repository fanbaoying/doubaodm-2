//
//  LoginViewController.m
//  doubao
//
//  Created by 范保莹 on 2017/1/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

//#import "LoginViewController.h"
//#import "ViewController.h"
//#import "AFNetworking.h"
//#import "FBYHomeService.h"
//
//#import "SecondViewController.h"
//#import "Nav.h"
//
//@interface LoginViewController ()
//
//@property(strong,nonatomic)Nav *nav;
//
//@property(strong,nonatomic)UIImageView *MyImg;
//
//@property(strong,nonatomic)UILabel *numLabel;
//
//@property(strong,nonatomic)UILabel *pwLabel;
//
//@property(strong,nonatomic)UITextField *numText;
//
//@property(strong,nonatomic)UITextField *pwText;
//
//@property(strong,nonatomic)UIButton *registerBtn;
//
//@property(strong,nonatomic)UIButton *loginBtn;
//
//@property(strong,nonatomic)UIView *myView;
//
//@property(strong,nonatomic)UIButton *ForgetPasswordBtn;
//
//
//
//
//@property(strong,nonatomic)UIImageView *MyImg88;
//
//@property(strong,nonatomic)UILabel *numLabel88;
//
//@property(strong,nonatomic)UILabel *obtainLabel88;
//
//@property(strong,nonatomic)UITextField *numText88;
//
//@property(strong,nonatomic)UITextField *obtainText88;
//
//@property(strong,nonatomic)UIButton *obtainBtn88;
//
//@property(strong,nonatomic)UIButton *loginBtn88;
//
//@property(strong,nonatomic)UITextField *passwordText88;
//
//@property(strong,nonatomic)UILabel *passwordLabel88;
//
//@property(strong,nonatomic)UITextField *okpasswordText88;
//
//@property(strong,nonatomic)UILabel *okpasswordLab88;
//
//
//@property(strong,nonatomic)UIView *myView88;
//
//@property(strong,nonatomic)NSString *registerStr88;
//
//@end
//
//@implementation LoginViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//
//
//    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-113)];
//    self.myView.backgroundColor = [UIColor clearColor];
//    
//    self.MyImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH*1/2)];
//    //    self.MyImg.backgroundColor = [UIColor purpleColor];
//    self.MyImg.image = [UIImage imageNamed:@"bg.jpg"];
//    [self.view addSubview:_MyImg];
//    
//    self.numText = [[UITextField alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/2-130, SCREEN_WIDTH-60, 40)];
//    self.numText.placeholder = @"请输入账号";
//    [self.numText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    self.numText.keyboardType = 4;
//    self.numText.font = [UIFont systemFontOfSize:12.0];
//    
//    //线
//    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-94, SCREEN_WIDTH-60, 0.5)];
//    self.numLabel.backgroundColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1];
//    
//    
//    self.pwText = [[UITextField alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-80, SCREEN_WIDTH-60, 40)];
//    self.pwText.placeholder = @"请输入密码";
//    self.pwText.secureTextEntry = YES;
//    [self.pwText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    self.pwText.keyboardType = 1;
//    self.pwText.font = [UIFont systemFontOfSize:12.0];
//    
//    //线
//    self.pwLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2-44, SCREEN_WIDTH-60, 0.5)];
//    self.pwLabel.backgroundColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1];
//    
//    //注册按钮
////    self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2-44, (SCREEN_WIDTH-90)/2, 40)];
////    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
////    [self.registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//////    [self.registerBtn.layer setBorderWidth:0.5];
//////    self.registerBtn.layer.borderColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1].CGColor;
////    [self.registerBtn.layer setCornerRadius:5.0];
////    self.registerBtn.titleLabel.font  = [UIFont systemFontOfSize:12.0];
////    //点击事件
////    [self.registerBtn addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    //忘记密码按钮
//    self.ForgetPasswordBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-(SCREEN_WIDTH-90)/2, SCREEN_HEIGHT/2-44, (SCREEN_WIDTH-90)/2, 40)];
//    [self.ForgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [self.ForgetPasswordBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    self.ForgetPasswordBtn.titleLabel.font  = [UIFont systemFontOfSize:12.0];
////    [self.ForgetPasswordBtn addTarget:self action:@selector(forgetpassword:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //登录按钮
//    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT/2+26, SCREEN_WIDTH-40, 40)];
//    self.loginBtn.backgroundColor = [UIColor lightGrayColor];
//    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
//    [self.loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.loginBtn.layer setCornerRadius:5.0];
//    self.loginBtn.titleLabel.font  = [UIFont systemFontOfSize:14.0];
//    [self.loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    //键盘的显示和退出
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    
//    [self.view addSubview:_myView];
//    [self.myView addSubview:_ForgetPasswordBtn];
//    [self.myView addSubview:_loginBtn];
//    [self.myView addSubview:_registerBtn];
//    
//    [self.myView addSubview:_numLabel];
//    [self.myView addSubview:_pwLabel];
//    [self.myView addSubview:_numText];
//    [self.myView addSubview:_pwText];
//
//    
//    self.myView88 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-113)];
//    self.myView88.backgroundColor = [UIColor clearColor];
//    
////    self.MyImg88 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH,SCREEN_WIDTH*1/2)];
////    //    self.MyImg.backgroundColor = [UIColor purpleColor];
//////    self.MyImg88.image = [UIImage imageNamed:@"bg.jpg"];
////    [self.view addSubview:_MyImg];
//    
//    self.numText88 = [[UITextField alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/6, SCREEN_WIDTH-150, 40)];
//    self.numText88.placeholder = @"请输入手机号";
//        [self.numText88 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    self.numText88.keyboardType = 4;
//    self.numText88.font = [UIFont systemFontOfSize:12.0];
//    
//    //线
//    self.numLabel88 = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/6+40, SCREEN_WIDTH-60, 0.5)];
//    self.numLabel88.backgroundColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1];
//    
//    //获取验证码按钮
//    //按钮样式设置
//    self.obtainBtn88 = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.obtainBtn88.frame = CGRectMake(SCREEN_WIDTH-SCREEN_WIDTH/4-40, SCREEN_HEIGHT/6+70, SCREEN_WIDTH/4+10, 30);
//    [self.obtainBtn88 setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [self.obtainBtn88 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [self.obtainBtn88.layer setBorderWidth:0.5];
//    self.obtainBtn88.layer.borderColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1].CGColor;
//    [self.obtainBtn88.layer setCornerRadius:5.0];
//    self.obtainBtn88.titleLabel.font  = [UIFont systemFontOfSize:12.0];
//    
//    //点击事件
//    //    [self.obtainBtn addTarget:self action:@selector(obtainBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    
//    
//    self.obtainText88 = [[UITextField alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/6+60, SCREEN_WIDTH-60, 40)];
//    self.obtainText88.placeholder = @"请输入验证码";
//    self.obtainText88.keyboardType = 4;
//    self.obtainText88.font = [UIFont systemFontOfSize:12.0];
//    
//    //线
//    self.obtainLabel88 = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/6+100, SCREEN_WIDTH-60, 0.5)];
//    self.obtainLabel88.backgroundColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1];
//    
//    
//    self.passwordText88 = [[UITextField alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/6+120, SCREEN_WIDTH-150, 40)];
//    self.passwordText88.placeholder = @"请输入密码";
//        [self.passwordText88 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    self.passwordText88.keyboardType = 4;
//    self.passwordText88.font = [UIFont systemFontOfSize:12.0];
//    
//    //线
//    self.passwordLabel88 = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/6+160, SCREEN_WIDTH-60, 0.5)];
//    self.passwordLabel88.backgroundColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1];
//    
//    
//    self.okpasswordText88 = [[UITextField alloc]initWithFrame:CGRectMake(30,SCREEN_HEIGHT/6+180, SCREEN_WIDTH-150, 40)];
//    self.okpasswordText88.placeholder = @"请确认密码";
//        [self.okpasswordText88 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//    self.okpasswordText88.keyboardType = 4;
//    self.okpasswordText88.font = [UIFont systemFontOfSize:12.0];
//    
//    //线
//    self.okpasswordLab88 = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/6+220, SCREEN_WIDTH-60, 0.5)];
//    self.okpasswordLab88.backgroundColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1];
//    
//    
//    //注册按钮
//    self.loginBtn88 = [[UIButton alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT/2+26, SCREEN_WIDTH-60, 30)];
//    [self.loginBtn88 setTitle:@"完成" forState:UIControlStateNormal];
//    [self.loginBtn88 setTitleColor:[UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
//    [self.loginBtn88.layer setBorderWidth:0.5];
//    self.loginBtn88.layer.borderColor = [UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1].CGColor;
//    [self.loginBtn88.layer setCornerRadius:5.0];
//    self.loginBtn88.titleLabel.font  = [UIFont systemFontOfSize:12.0];
//    //点击事件
//    [self.loginBtn88 addTarget:self action:@selector(registerBtn:) forControlEvents:UIControlEventTouchUpInside];
//    
//    //键盘的显示和退出
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
////    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//    
//    [self.view addSubview:_myView88];
//    [self.myView88 addSubview:_obtainBtn88];
//    [self.myView88 addSubview:_loginBtn88];
//    
//    [self.myView88 addSubview:_numLabel88];
//    [self.myView88 addSubview:_numText88];
//    
//    [self.myView88 addSubview:_passwordText88];
//    [self.myView88 addSubview:_passwordLabel88];
//    
//    [self.myView88 addSubview:_okpasswordLab88];
//    [self.myView88 addSubview:_okpasswordText88];
//    
//    [self.myView88 addSubview:_obtainText88];
//    [self.myView88 addSubview:_obtainLabel88];
//    
//    self.myView88.hidden = YES;
//    self.obtainBtn88.hidden = YES;
//    self.loginBtn88.hidden = YES;
//    self.numLabel88.hidden = YES;
//    self.numText88.hidden = YES;
//    self.passwordText88.hidden = YES;
//    self.passwordLabel88.hidden = YES;
//    self.okpasswordLab88.hidden = YES;
//    self.okpasswordText88.hidden = YES;
//    self.obtainText88.hidden = YES;
//    self.obtainLabel88.hidden = YES;
//    
//}
////限制手机号输入
//- (void)textFieldDidChange:(UITextField *)textField
//{
//    if (textField == self.numText) {
//        if (textField.text.length > 11) {
//            textField.text = [textField.text substringToIndex:11];
//   
//        }else if (textField.text.length == 11){
//        
//        NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
//            
//            //    mutdic[@"phone"] = _numText.text;
//            //    mutdic[@"password"] = _pwText.text;
//            
//                mutdic[@"phone"] = self.numText.text;
//            
//                //广告网络请求
//                FBYHomeService *service1 = [[FBYHomeService alloc]init];
//            
//        [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:checkPhone andSuccess:^(NSDictionary *dic) {
//            
//                    NSLog(@"%@",dic);
//            
//            NSString *data = [dic objectForKey:@"data"];
//            int intString = [data intValue];
//            if ( intString == 1) {
//                
//                self.myView.hidden = NO;
//                self.ForgetPasswordBtn.hidden = NO;
//                self.loginBtn.hidden = NO;
//                self.registerBtn.hidden = NO;
//                self.numLabel.hidden = NO;
//                self.pwLabel.hidden = NO;
//                self.numText.hidden = NO;
//                self.pwText.hidden = NO;
//                
//                
//                self.myView88.hidden = YES;
//                self.obtainBtn88.hidden = YES;
//                self.loginBtn88.hidden = YES;
//                self.numLabel88.hidden = YES;
//                self.numText88.hidden = YES;
//                self.passwordText88.hidden = YES;
//                self.passwordLabel88.hidden = YES;
//                self.okpasswordLab88.hidden = YES;
//                self.okpasswordText88.hidden = YES;
//                self.obtainText88.hidden = YES;
//                self.obtainLabel88.hidden = YES;
//                
//            }else if (intString == 0){
//                
//                self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"注册" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
//                [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//                [self.view addSubview:_nav];
//                
//                self.myView.hidden = YES;
//                self.ForgetPasswordBtn.hidden = YES;
//                self.loginBtn.hidden = YES;
//                self.registerBtn.hidden = YES;
//                self.numLabel.hidden = YES;
//                self.pwLabel.hidden = YES;
//                self.numText.hidden = YES;
//                self.pwText.hidden = YES;
//
//                
//                self.myView88.hidden = NO;
//                self.obtainBtn88.hidden = NO;
//                self.loginBtn88.hidden = NO;
//                self.numLabel88.hidden = NO;
//                self.numText88.hidden = NO;
//                self.passwordText88.hidden = NO;
//                self.passwordLabel88.hidden = NO;
//                self.okpasswordLab88.hidden = NO;
//                self.okpasswordText88.hidden = NO;
//                self.obtainText88.hidden = NO;
//                self.obtainLabel88.hidden = NO;
//                
//                self.numText88.text = self.numText.text;
//                
//            }
//            
//                } andFailure:^(int fail) {
//            
//                }];
//            
//            
//        }
//    }
//    
//    if (textField == self.pwText) {
//        if (textField.text.length > 5 & textField.text.length < 21) {
//            
//            self.loginBtn.backgroundColor = [UIColor colorWithRed:174/255.0 green:109/255.0 blue:45/255.0 alpha:1];
//            
//            //点击事件
//            [self.loginBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
//        }else
//            if (textField.text.length > 20){
//                
//                textField.text = [textField.text substringToIndex:20];
//            }else{
//                
//                self.loginBtn.backgroundColor = [UIColor lightGrayColor];
//                
//            }
//    }
//    
//    if (textField == self.numText88) {
//        if (textField.text.length > 10) {
//            textField.text = [textField.text substringToIndex:11];
//            
//            [self.obtainBtn88 setTitleColor:[UIColor colorWithRed:36/255.0 green:203/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
//            
//            //点击事件
//            self.obtainBtn88.enabled = YES;
//        }else{
//            
//            [self.obtainBtn88 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//            
//            self.obtainBtn88.enabled = NO;
//        }
//    }
//    
//}
//
//- (void)back:(UIButton *)sender{
//    
//    self.nav = [[Nav alloc]initWithLeftBtn:nil andWithTitleLab:@"登录" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
////    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_nav];
//
//    self.myView.hidden = NO;
//    self.ForgetPasswordBtn.hidden = NO;
//    self.loginBtn.hidden = NO;
//    self.registerBtn.hidden = NO;
//    self.numLabel.hidden = NO;
//    self.pwLabel.hidden = NO;
//    self.numText.hidden = NO;
//    self.pwText.hidden = NO;
//    
//    
//    self.myView88.hidden = YES;
//    self.obtainBtn88.hidden = YES;
//    self.loginBtn88.hidden = YES;
//    self.numLabel88.hidden = YES;
//    self.numText88.hidden = YES;
//    self.passwordText88.hidden = YES;
//    self.passwordLabel88.hidden = YES;
//    self.okpasswordLab88.hidden = YES;
//    self.okpasswordText88.hidden = YES;
//    self.obtainText88.hidden = YES;
//    self.obtainLabel88.hidden = YES;
//    
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    [self.view endEditing:YES];
//    
//}
//
////pragma mark 键盘即将显示
//- (void)keyBoardWillShow:(NSNotification *)note{
//    
//    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat ty = rect.size.height;
//    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
//        self.myView.transform = CGAffineTransformMakeTranslation(0, - ty + 170);
//    }];
//    
//}
////pragma mark 键盘即将退出
//- (void)keyBoardWillHide:(NSNotification *)note{
//    
//    
//    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
//        self.myView.transform = CGAffineTransformIdentity;
//    }];
//}
//
////登录
//- (void)loginBtn:(UIButton *)sender{
//    
//    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
//    
////    mutdic[@"phone"] = _numText.text;
////    mutdic[@"password"] = _pwText.text;
//    
//    mutdic[@"phone"] = @"18306131899";
//    mutdic[@"password"] = @"123456";
//    
//    //广告网络请求
//    FBYHomeService *service1 = [[FBYHomeService alloc]init];
//    
//    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:loginOrRegister andSuccess:^(NSDictionary *dic) {
//        
//        NSLog(@"%@",dic);
//        
//        NSDictionary *dic1 = [dic objectForKey:@"data"];
//        
//        NSString *token = [dic1 objectForKey:@"token"];
//        
//        NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
//        [tokenid setObject:token forKey:@"tokenid"];
//        [tokenid synchronize];
//        
////        NSString *businessid = [dic1 objectForKey:@"businessid"];
////        
////        NSUserDefaults *business = [NSUserDefaults standardUserDefaults];
////        [business setObject:businessid forKey:@"businessid"];
////        [business synchronize];
//        
////        NSDictionary *dic1 = [arr1[0] objectForKey:@"user"];
////        
////        NSLog(@"%@",dic1);
////
////        NSString *user = [dic1 objectForKey:@"userid"];
////        
////        NSLog(@"%@",user);
////
////        NSUserDefaults *userId = [NSUserDefaults standardUserDefaults];
////        [userId setObject:token forKey:@"userid"];
////        [userId synchronize];
//    
//
//    ViewController *vc = [[ViewController alloc]init];
//    SecondViewController *sc = [[SecondViewController alloc]init];
//    
//    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc];
//    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:sc];;
//    
//    //选中与未被选中图片的渲染
//    nav1.tabBarItem.title = @"留言";
//    //    nav1.tabBarItem.image = [UIImage imageNamed:@"TAG.jpg"];
//    nav1.tabBarItem.image = [[UIImage imageNamed:@"home@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"home@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    
//    nav2.tabBarItem.title = @"工作";
//    nav2.tabBarItem.image = [[UIImage imageNamed:@"home@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    //    nav2.tabBarItem.image = [[UIImage imageNamed:@""]];
//    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"home@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    
//    self.tabBar = [[UITabBarController alloc]init];
//    self.tabBar.viewControllers = @[nav1,nav2];
//    
//    //隐藏导航栏
//    nav1.navigationBarHidden = YES;
//    nav2.navigationBarHidden = YES;
//    
//            
//            
//    [self presentViewController:_tabBar animated:NO completion:nil];
//
//    } andFailure:^(int fail) {
//        
//    }];
//
//    
//}
//
////注册完成
//- (void)registerBtn:(UIButton *)sender{
//    
//    
//    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
//    
//    mutdic[@"phone"] = _numText88.text;
//    mutdic[@"password"] = _passwordText88.text;
//    mutdic[@"repassword"] = _okpasswordText88.text;
//    mutdic[@"code"] = @"123456";
//    
////    mutdic[@"phone"] = @"18306131899";
////    mutdic[@"password"] = @"123456";
////    mutdic[@"repassword"] = @"123456";
////    mutdic[@"code"] = @"123456";
//    
//    //网络请求
//    FBYHomeService *service1 = [[FBYHomeService alloc]init];
//    
//    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:loginOrRegister andSuccess:^(NSDictionary *dic) {
//        
////        NSLog(@"%@",dic);
//        
//        NSDictionary *dic1 = [dic objectForKey:@"data"];
//        
//        NSString *token = [dic1 objectForKey:@"token"];
//        
//        NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
//        [tokenid setObject:token forKey:@"tokenid"];
//        [tokenid synchronize];
//        
//        ViewController *vc = [[ViewController alloc]init];
//        SecondViewController *sc = [[SecondViewController alloc]init];
//        
//        UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:vc];
//        UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:sc];;
//        
//        //选中与未被选中图片的渲染
//        nav1.tabBarItem.title = @"留言";
//        //    nav1.tabBarItem.image = [UIImage imageNamed:@"TAG.jpg"];
//        nav1.tabBarItem.image = [[UIImage imageNamed:@"home@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"home@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        
//        nav2.tabBarItem.title = @"工作";
//        nav2.tabBarItem.image = [[UIImage imageNamed:@"home@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        //    nav2.tabBarItem.image = [[UIImage imageNamed:@""]];
//        nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"home@2x"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        
//        self.tabBar = [[UITabBarController alloc]init];
//        self.tabBar.viewControllers = @[nav1,nav2];
//        
//        //隐藏导航栏
//        nav1.navigationBarHidden = YES;
//        nav2.navigationBarHidden = YES;
//
//        [self presentViewController:_tabBar animated:NO completion:nil];
//        
//    } andFailure:^(int fail) {
//        
//        NSLog(@"错误");
//        
//    }];
//    
//    
//}
//
//@end
