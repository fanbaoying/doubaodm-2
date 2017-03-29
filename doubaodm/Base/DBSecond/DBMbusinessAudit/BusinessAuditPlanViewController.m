//
//  BusinessAuditPlanViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/3/6.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "BusinessAuditPlanViewController.h"
#import "Nav.h"

#import "BXTextField.h"

@interface BusinessAuditPlanViewController ()

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UIView *headView;
@property(strong,nonatomic)UILabel *auditPlanLab;

@property(strong,nonatomic)UIView *clauseView;

@property(strong,nonatomic)UIView *foodView;
@property(strong,nonatomic)UIImageView *idImg;
@property(strong,nonatomic)UIButton *passBtn;
@property(strong,nonatomic)UIButton *notPassBtn;

@property(strong,nonatomic)UIView *remindView;
@property(strong,nonatomic)UITextView *contentTextView;

@property(strong,nonatomic)BXTextField *idTextField;

@end

@implementation BusinessAuditPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self headview];
    [self clauseview];
    [self foodview];
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"审核进度" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
}

- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)headview{
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 50)];
    [self.view addSubview:_headView];
    
    self.auditPlanLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH/4, 30)];
    self.auditPlanLab.text = @"审核进度";
    self.auditPlanLab.font = [UIFont systemFontOfSize:16.0];
    [self.headView addSubview:_auditPlanLab];
    
    UILabel *maxlab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 40, SCREEN_WIDTH, 10)];
    maxlab.layer.borderWidth = 1.0;
    maxlab.layer.borderColor = threadColor.CGColor;
    maxlab.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:maxlab];
    
    UILabel *minlab = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 10)];
    minlab.backgroundColor = threadColor;
    [self.headView addSubview:minlab];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 10)];
    lab.backgroundColor = threadColor;
    [self.headView addSubview:lab];
}

- (void)clauseview{
    
    self.clauseView = [[UIView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, 70)];
    [self.view addSubview:_clauseView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH/4, 30)];
    titleLab.text = @"条款确认";
    titleLab.font = [UIFont systemFontOfSize:16.0];
    [self.clauseView addSubview:titleLab];
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH-20, 40)];
    contentView.layer.borderWidth = 1.0;
    contentView.layer.borderColor = threadColor.CGColor;
    [self.clauseView addSubview:contentView];
    
    NSArray *contentArr = @[@"核心条款确认",@"普通条款确认"];
    
    for (int i = 0; i < contentArr.count; i++) {
        int a = SCREEN_WIDTH*4/8*i;
        UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8+a, 35, SCREEN_WIDTH/4, 30)];
        contentLab.text = contentArr[i];
        contentLab.font = [UIFont systemFontOfSize:14.0];
        [self.clauseView addSubview:contentLab];
        
        UIButton *myBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3/8+a, 38, 20, 20)];
        myBtn.tag = 1000+i;
        [myBtn setImage:[UIImage imageNamed:@"no"] forState:0];
        [self.clauseView addSubview:myBtn];
        
    }
    
}

- (void)foodview{
    
    self.foodView = [[UIView alloc]initWithFrame:CGRectMake(0, 184, SCREEN_WIDTH, SCREEN_HEIGHT-184)];
    [self.view addSubview:_foodView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH/3, 30)];
    titleLab.text = @"资质上传审核";
    titleLab.font = [UIFont systemFontOfSize:16.0];
    [self.foodView addSubview:titleLab];
    
    NSArray *contentArr = @[@"身份证",@"营业执照",@"微信二维码",@"支付宝二维码"];
    
    for (int i = 0; i < contentArr.count; i++) {
        int count = ((SCREEN_HEIGHT-254)/4+10)*i;
        
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(10, 30+count, SCREEN_WIDTH-20, (SCREEN_HEIGHT-254)/4)];
        contentView.layer.borderWidth = 1.0;
        contentView.layer.borderColor = threadColor.CGColor;
        [self.foodView addSubview:contentView];
        
        if (i == 0) {
            self.idTextField = [[BXTextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 30)];
            self.idTextField.placeholder = @"请输入身份证号";
            self.idTextField.font = [UIFont systemFontOfSize:12.0];
            [contentView addSubview:_idTextField];
            
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 25, SCREEN_WIDTH/2-20, 1)];
            lab.backgroundColor = [UIColor lightGrayColor];
            [contentView addSubview:lab];
        }
        
        UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8-10, 0, SCREEN_WIDTH/4, 30)];
        contentLab.text = contentArr[i];
        contentLab.font = [UIFont systemFontOfSize:14.0];
        [contentView addSubview:contentLab];
        
        UIButton *myBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*3/8, 5, 20, 20)];
        myBtn.tag = 2000+i;
        [myBtn setImage:[UIImage imageNamed:@"no"] forState:0];
        [contentView addSubview:myBtn];
        
        self.idImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/8, 30, SCREEN_WIDTH/4, SCREEN_WIDTH/6)];
        self.idImg.backgroundColor = [UIColor lightGrayColor];
        [contentView addSubview:_idImg];
        
        
        NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
        NSString *grade = [gradeid objectForKey:@"gradeid"];
        int intString = [grade intValue];
        
        if (intString == 1) {
            
        }else if (intString == 2){
            
            self.passBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 30, SCREEN_WIDTH/3, 30)];
            self.passBtn.tag = 4000+i;
            [self.passBtn setTitle:@"审核通过" forState:0];
            self.passBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [self.passBtn setTitleColor:[UIColor blackColor] forState:0];
            self.passBtn.layer.borderWidth = 1.0;
            self.passBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.passBtn.layer.cornerRadius = 5.0;
            self.passBtn.clipsToBounds = YES;
            [contentView addSubview:_passBtn];
            
            self.notPassBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 64, SCREEN_WIDTH/3, 30)];
            self.notPassBtn.tag = 5000+i;
            [self.notPassBtn setTitle:@"审核未通过" forState:0];
            self.notPassBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [self.notPassBtn setTitleColor:[UIColor blackColor] forState:0];
            self.notPassBtn.layer.borderWidth = 1.0;
            self.notPassBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.notPassBtn.layer.cornerRadius = 5.0;
            self.notPassBtn.clipsToBounds = YES;
            [contentView addSubview:_notPassBtn];
            
            [self.passBtn addTarget:self action:@selector(passBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.notPassBtn addTarget:self action:@selector(notPassBtn:) forControlEvents:UIControlEventTouchUpInside];
        }else if (intString == 3){
            
            UILabel *resultLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 45, SCREEN_WIDTH/3, 30)];
            resultLab.text = @"审核未通过";
            resultLab.font = [UIFont systemFontOfSize:14.0];
            resultLab.textAlignment = NSTextAlignmentCenter;
            [contentView addSubview:resultLab];
        }
        
        
    }
}
//审核通过按钮
- (void)passBtn:(UIButton *)sender{
    
    
    
}

//审核未通过按钮
- (void)notPassBtn:(UIButton *)sender{
    
    self.remindView = [[UIView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT/3, SCREEN_WIDTH-20, SCREEN_HEIGHT/3)];
    self.remindView.layer.borderWidth = 1.0;
    self.remindView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.remindView.backgroundColor = threadColor;
    [self.view addSubview:_remindView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    titleLab.text = @"审核未通过原因";
    [self.remindView addSubview:titleLab];
    
    self.contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 35, SCREEN_WIDTH-40, SCREEN_HEIGHT/3-80)];
    [self.remindView addSubview:_contentTextView];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3-35, (SCREEN_WIDTH-20)/2, 35)];
    [cancelBtn setTitle:@"取消" forState:0];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:0];
    cancelBtn.layer.borderWidth = 1.0;
    cancelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.remindView addSubview:cancelBtn];
    
    UIButton *ensureBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-10, SCREEN_HEIGHT/3-35, (SCREEN_WIDTH-20)/2, 35)];
    [ensureBtn setTitle:@"确定" forState:0];
    ensureBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [ensureBtn setTitleColor:[UIColor blackColor] forState:0];
    ensureBtn.layer.borderWidth = 1.0;
    ensureBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    if (sender.tag == 5000) {
        ensureBtn.tag = 6000;
    }else if (sender.tag == 5001){
        ensureBtn.tag = 6001;
    }else if (sender.tag == 5002){
        ensureBtn.tag = 6002;
    }else if (sender.tag == 5003){
        ensureBtn.tag = 6003;
    }
    [ensureBtn addTarget:self action:@selector(ensureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.remindView addSubview:ensureBtn];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

//取消按钮
- (void)cancelBtn:(UIButton *)sender{
    
    self.remindView.hidden = YES;
    
}

//确定按钮
- (void)ensureBtn:(UIButton *)sender{
    
    self.remindView.hidden = YES;
    
    if (sender.tag == 6000) {
        NSLog(@"000");
    }else if (sender.tag == 6001){
        NSLog(@"111");
    }else if (sender.tag == 6002){
        NSLog(@"222");
    }else if (sender.tag == 6003){
        NSLog(@"333");
    }
    
}

@end
