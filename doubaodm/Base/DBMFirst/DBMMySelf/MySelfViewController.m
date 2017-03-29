//
//  MySelfViewController.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/22.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "MySelfViewController.h"
#import "Nav.h"
#import "MySelfTableViewCell.h"

#import "NewLoginViewController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>

#import "AFNetworking.h"
#import "FBYHomeService.h"

@interface MySelfViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    
    UIImagePickerController *_imagePickerController;
    
}

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)UITableView *myTable;

@property(strong,nonatomic)NSArray *dataArr;

@property(strong,nonatomic)NSArray *titleArr;

@property(strong,nonatomic)NSArray *contentArr;

@property(strong,nonatomic)UIView *headView;

@property(strong,nonatomic)UIButton *headBtn;

@property(strong,nonatomic)UILabel *nameLab;

@property(strong,nonatomic)UILabel *idLab;

@property(strong,nonatomic)UIImage *image1;

@end

@implementation MySelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT/3)];
    self.headView.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    
    self.headBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, SCREEN_HEIGHT/6-40, 80, 80)];
    self.headBtn.backgroundColor = [UIColor whiteColor];
    [self.headBtn setTitle:@"点击选择头像" forState:UIControlStateNormal];
    self.headBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    self.headBtn.titleLabel.numberOfLines = 0;
    [self.headBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.headBtn addTarget:self action:@selector(headBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.headBtn.layer.cornerRadius = 5.0;
    self.headBtn.clipsToBounds = YES;
    [self.headView addSubview:_headBtn];
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3-60, SCREEN_WIDTH, 30)];
    self.nameLab.text = @"张三";
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    self.nameLab.font = [UIFont systemFontOfSize:14.0];
    [self.headView addSubview:_nameLab];
    
    self.idLab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/3-30, SCREEN_WIDTH, 20)];
    self.idLab.text = @"ID号：123456784234";
    self.idLab.textColor = [UIColor lightGrayColor];
    self.idLab.textAlignment = NSTextAlignmentCenter;
    self.idLab.font = [UIFont systemFontOfSize:12.0];
    [self.headView addSubview:_idLab];
    
    
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT-120)];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.showsVerticalScrollIndicator = NO;
    //    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTable.scrollEnabled = NO;
    
    self.myTable.tableHeaderView = _headView;
    [self.view addSubview:_myTable];
    
    
    self.titleArr = @[@"归属",@"职务",@"手机号",@"Email",@"电话"];
    self.contentArr = @[@"上海市杨浦区张主管",@"业务员",@"123456789",@"147916494@qq.com",@"021-123456987"];
    
    self.nav = [[Nav alloc]initWithLeftBtn:@"back" andWithTitleLab:@"我的" andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    [self.nav.leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nav];
    
    //创建UIImagePickerController对象
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokenid objectForKey:@"tokenid"];
    
    //    NSLog(@"%@",token);
    
    NSMutableDictionary *mutdic=[NSMutableDictionary dictionaryWithCapacity:0];
    mutdic[@"token"] = @"f9d8b97d22164820992c2912d689111a";

    //网络请求
    FBYHomeService *service1 = [[FBYHomeService alloc]init];
    
    [service1 searchMessage:nil andWithAction:nil andWithDic:mutdic andUrl:getUserInfo andSuccess:^(NSDictionary *dic) {
        
        NSLog(@"%@",dic);
        NSLog(@"%@",[dic objectForKey:@"msg"]);
        NSString *str = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
        
        if ([str isEqualToString:[NSString stringWithFormat:@"0"]]) {
            
            self.dataArr = [dic objectForKey:@"data"];
            if ([_dataArr isEqual:[NSNull null]]) {
                
            }else{
                
                [self.myTable reloadData];
                
            }
            
        }
        
    } andFailure:^(int fail) {
        
    }];
    
}

//选择头像
- (void)headBtn:(UIButton *)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择头像" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        //录制视频时长，默认10s
        _imagePickerController.videoMaximumDuration = 15;
        
        //相机类型（拍照、录像...）字符串需要做相应的类型转换
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
        
        //视频上传质量
        //UIImagePickerControllerQualityTypeHigh高清
        //UIImagePickerControllerQualityTypeMedium中等质量
        //UIImagePickerControllerQualityTypeLow低质量
        //UIImagePickerControllerQualityType640x480
        _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        
        //设置摄像头模式（拍照，录制视频）为录像模式
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //NSLog(@"相册");
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//适用获取所有媒体资源，只需判断资源类型
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    //判断资源类型
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        
        //        NSLog(@"%d",_bgNum);
        ////        如果是图片
        self.image1 = info[UIImagePickerControllerEditedImage];
        
        
        [self.headBtn setImage:_image1 forState:UIControlStateNormal];
        //            NSLog(@"%@",_idImg.image);
        
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//图片和视频保存完毕后的回调
- (void) image: (UIImage *) image didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInf{
    
}

//返回按钮
- (void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count+1;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 5) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"退出登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            NewLoginViewController *vc = [[NewLoginViewController alloc]init];
            
            NSUserDefaults *tokenid = [NSUserDefaults standardUserDefaults];
            [tokenid setObject:@"0" forKey:@"tokenid"];
            [tokenid synchronize];
            
            NSUserDefaults *gradeid = [NSUserDefaults standardUserDefaults];
            [gradeid setObject:nil forKey:@"gradeid"];
            [gradeid synchronize];
            
            [self presentViewController:vc animated:YES completion:nil];
            
        }];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MySelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[MySelfTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    if (indexPath.row == 5) {
        cell.quitLab.text = @"退出登录";
        cell.titleLab.text = nil;
        cell.contentLab.text = nil;
    }else{
        cell.titleLab.text = _titleArr[indexPath.row];
        cell.contentLab.text = _contentArr[indexPath.row];
        cell.quitLab.text = nil;
    }
    return cell;
}
@end
