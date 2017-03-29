//
//  FamilyViewController.m
//  MyFamily
//
//  Created by 陆洋 on 15/6/2.
//  Copyright (c) 2015年 maili. All rights reserved.
//

#import "FamilyViewController.h"
#import "HeaderContent.h"
#import "FamilyGroupCell.h"
//#import "ShowImageViewController.h"
#import "ReplyInputView.h"

#import "FamilyGroup.h"

#import "Nav.h"
#import "FriendGroupViewController.h"

#import "FBYHomeService.h"
#import "AFNetworking.h"

@interface FamilyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)Nav *nav;

@property(strong,nonatomic)NSArray *dataArr;
//@property(strong,nonatomic)NSArray *dataArrs;

//@property (strong,nonatomic) NSMutableArray *sourceArr;

@property (nonatomic,strong)NSMutableArray *familyGroupData;
@property (nonatomic,weak)UIButton *replyButton; //点击后弹出的评论按钮
@property (nonatomic,weak)ReplyInputView *replyInputView;
@property (nonatomic,assign)BOOL flag;  //用于键盘出现时函数调用多次的情况
//@property (weak, nonatomic) IBOutlet UITableView *familyTableView;
@property(strong,nonatomic)UITableView *familyTableView;

//用于view的移动，使评论框落在cell下面，没想到别的方法
@property (nonatomic,assign)float replyViewDraw;

//工具栏的高约束，用于当输入文字过多时改变工具栏的约束
@property (strong, nonatomic) NSLayoutConstraint *replyInputViewConstraintHeight;
@end

@implementation FamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.familyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, screenWidth, screenHeight-44)];
    self.familyTableView.backgroundColor = [UIColor whiteColor];
    self.familyTableView.delegate = self;
    self.familyTableView.dataSource =self;
    //    self.myTable.showsVerticalScrollIndicator = NO;
    //    self.myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.myTable.scrollEnabled = NO;

    [self.view addSubview:_familyTableView];
    
    [self addHeaderView];
    self.flag = YES;
    //获取通知中心
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //注册为被通知者
    [notificationCenter addObserver:self selector:@selector(keyChange:) name:UIKeyboardDidShowNotification object:nil];
    
    //if (!_familyGroupData) {
       // _familyGroupData = [[NSMutableArray alloc]initWithCapacity:0];
        
        //self.dataArr = @[@{@"icon":@"业务员张",
                           //@"name":@"业务员张三",
                          // @"shuoshuoText":@"发表的时间,存的是nadate，应该要有时间操作",
                          // @"time":@"2小时前",
                          // @"replys":@[@{@"title":@"发表的时间,存的是nadate，应该要有时间操作"},
                                       //@{@"title":@"发表的时间,存的是nadate，应该要有时间操作"},
                                      // @{@"title":@"发表的时间,存的是nadate，应该要有时间操作"},
                                      // @{@"title":@"发表的时间,存的是nadate，应该要有时间操作"}
                                //]
                          // },
                        // @{@"icon":@"业务员张",
                           //@"name":@"业务员张三",
                          // @"shuoshuoText":@"发表的时间,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作",
                          // @"time":@"2小时前",
                          // @"replys":@[@{@"title":@"发表的时间,存的是nadate，应该要有时间操作"},
                                      // @{@"title":@"发表的时间,存的是nadate，应该要有时间操作"},
                                      // @{@"title":@"发表的时间,存的是nadate，应该要有时间操作"},
                                      // @{@"title":@"发表的时间,存的是nadate，应该要有时间操作"}
                                    //   ]
                           //},
                         //@{@"icon":@"业务员张",
                           //@"name":@"业务员张三",
                          // @"shuoshuoText":@"发表的时间,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作",
                           //@"time":@"2小时前",
                          // @"replys":@[@{@"title":@"发表的时间,存的是nadate，应该要有时间操作"},
                                      // @{@"title":@"发表的时间,存的是nadate，应该要有时间操作"},
                                      // @{@"title":@"发表的时间,存的是nadate，应该要有时间操作"},
                                      // @{@"title":@"发表的时间,存的是nadate，应该要有时间操作"}
                                     //  ]
                         //  }
                        // ];
        
        //for (NSDictionary *dic in _dataArr){
            
            //FamilyGroup *model = [FamilyGroup mj_objectWithKeyValues:dic];
           // [_familyGroupData addObject:model];
            //[self.familyTableView reloadData];
       // }
    //}
    
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

#define headViewHeight 200
#define headIconWidth 50
#define headIconHeight 50

#pragma mark - 这些进入应用就应该全部保存起来，直接问服务器拿数据，保存，类似username,之后可以直接取，图片可以放入沙盒暂存
-(void)addHeaderView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, headViewHeight)];
    
    
    //长按应该可以更换背景
    UIImageView *backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, headViewHeight - 2*padding)];
    backGroundImageView.image = [UIImage imageNamed:@"background.jpg"];
    [headView addSubview:backGroundImageView];
    
    
    UIImageView *headIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(screenWidth*4/5, headViewHeight - headIconHeight, headIconWidth, headIconHeight)];
    headIconImageView.backgroundColor = [UIColor lightGrayColor];
    //headIconImageView.image = [UIImage imageNamed:@"headicon"];
    [headView addSubview:headIconImageView];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth*3/5, headViewHeight - 0.8*headIconHeight, 100, 15)];
    nameLabel.text = @"Baoying";
    nameLabel.font = [UIFont systemFontOfSize:14.0];
    //nameLabel.textColor = [UIColor whiteColor];
    [headView addSubview:nameLabel];
    
    self.familyTableView.tableHeaderView = headView;
}

#pragma mark - tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%lu",(unsigned long)[self.statusFrames count]);
    return [self.familyGroupData count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //虽然返回1，但是每个indexpath的section为0
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //__weak typeof(self) weakSelf = self;
    
    FamilyGroupCell *cell = [FamilyGroupCell cellWithTableView:tableView];
    cell.familyGroupFrame = self.familyGroupData[indexPath.row];
    [cell.replyButton addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.replyButton.tag = indexPath.row;   //评论时可以知道加到第几行
    
//    cell.imageBlock = ^(NSArray *imageViews, NSInteger clickTag) {
//        self.navigationController.navigationBarHidden = YES;
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        ShowImageViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ShowImage"];
//        [vc setHidesBottomBarWhenPushed:YES]; //隐藏tabbar
//        vc.clickTag = clickTag;
//        vc.imageViews = imageViews;
//        [self.navigationController pushViewController:vc animated:YES];
//        
//    };
    return cell;
}

-(NSMutableArray *)familyGroupData
{
    if (!_familyGroupData) {
        
        
        
//        self.dataArr = @[@{@"icon":@"业务员张",
//                           @"name":@"业务员张三",
//                           @"shuoshuoText":@"发表的时间,存的是nadate，应该要有时间操作",
//                           @"time":@"2小时前",
//                           @"replys":@[@"发表的时间,存的是nadate，应该要有时间操作",
//                                       @"发表的时间,存的是nadate，应该要有时间操作",
//                                       @"发表的时间,存的是nadate，应该要有时间操作",
//                                       @"发表的时间,存的是nadate，应该要有时间操作"
//                                       ]
//                           },
//                         @{@"icon":@"业务员张",
//                           @"name":@"业务员张三",
//                           @"shuoshuoText":@"发表的时间,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作",
//                           @"time":@"2小时前",
//                           @"replys":@[@"发表的时间,存的是nadate，应该要有时间操作",
//                                       @"发表的时间,存的是nadate，应该要有时间操作",
//                                       @"发表的时间,存的是nadate，应该要有时间操作",
//                                       @"发表的时间,存的是nadate，应该要有时间操作"
//                                       ]
//                           },
//                         @{@"icon":@"业务员张",
//                           @"name":@"业务员张三",
//                           @"shuoshuoText":@"发表的时间,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作,存的是nadate，应该要有时间操作",
//                           @"time":@"2小时前",
//                           @"replys":@[@"发表的时间,存的是nadate，应该要有时间操作",
//                                       @"发表的时间,存的是nadate，应该要有时间操作",
//                                       @"发表的时间,存的是nadate，应该要有时间操作",
//                                       @"发表的时间,存的是nadate，应该要有时间操作"
//                                       ]
//                           }
//                         ];
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:[_arr count]];
        for (NSDictionary *dict in _arr) {
            FamilyGroup *familyGroup = [FamilyGroup familyGroupWithDict:dict];
            FamilyGroupFrame *familyGroupFrame = [[FamilyGroupFrame alloc]init];
            familyGroupFrame.familyGroup = familyGroup;
            
            [models addObject:familyGroupFrame];
        }
        _familyGroupData = [models copy];
    }
    //NSLog(@"%lu",(unsigned long)[_statusFrames count]);
    return _familyGroupData;
}

-(void)replyAction:(UIButton *)sender
{
    FamilyGroupCell *cell = (FamilyGroupCell *)sender.superview.superview;
    
    self.replyViewDraw = [cell convertRect:cell.bounds toView:self.view.window].origin.y + cell.frame.size.height;
    
    NSIndexPath *indexPath = [self.familyTableView indexPathForCell:cell];
    CGRect rectInTableView = [self.familyTableView rectForRowAtIndexPath:indexPath];
    //NSLog(@"%f",rectInTableView.origin.y);
    CGRect replyButtonF = CGRectMake(sender.frame.origin.x , rectInTableView.origin.y+sender.frame.origin.y - 2, 0,20);
    NSLog(@"%f",self.replyButton.frame.origin.y);
    NSLog(@"%f",rectInTableView.origin.y+sender.frame.origin.y - 2);
    if (self.replyButton && self.replyButton.frame.origin.y != (rectInTableView.origin.y+sender.frame.origin.y - 2-padding)) {
        [self.replyButton removeFromSuperview];      //以防用户按了一个评论又按另一个
        self.replyButton = nil;
    }
    [self initReplyButton:replyButtonF];
    if (self.replyButton) {
        self.replyButton.tag = sender.tag;
    }
}

-(void)initReplyButton:(CGRect)replyButtonF
{
    if (!self.replyButton) {
        UIButton *replyButton = [UIButton buttonWithType:0];
        replyButton.layer.cornerRadius = 5;
        replyButton.backgroundColor = [UIColor colorWithRed:33/255.0 green:37/255.0 blue:38/255.0 alpha:1.0];
        replyButton.frame = replyButtonF;
        [replyButton setTitleColor:[UIColor whiteColor] forState:0];
        replyButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [replyButton addTarget:self action:@selector(replyMessage:) forControlEvents:UIControlEventTouchUpInside];
        [self.familyTableView addSubview:replyButton];
        self.replyButton = replyButton;
        
        [UIView animateWithDuration:0.25f animations:^{
            CGRect replyButtonDurF;
            replyButtonDurF.size.height = replyButtonF.size.height + 2*padding;
            replyButtonDurF.origin.y = replyButtonF.origin.y - padding;
            replyButtonDurF.origin.x = replyButtonF.origin.x - 60;
            replyButtonDurF.size.width = 60;
            replyButton.frame = replyButtonDurF;
        } completion:^(BOOL finished) {
            [replyButton setTitle:@"评论" forState:0];
        }];
        
    }
    else
    {
        [UIView animateWithDuration:0.25f animations:^{
            self.replyButton.frame = replyButtonF;    //只是为了有收缩的动画效果
        } completion:^(BOOL finished) {
            [self.replyButton removeFromSuperview];
            self.replyButton = nil;
        }];
        
    }
}

-(void)replyMessage:(UIButton *)sender
{
    if (self.replyButton) {
        [self initReplyInputView:sender.tag];
        [self.replyButton removeFromSuperview];
        self.replyButton = nil;
    }
}

-(void)initReplyInputView:(NSInteger) tag
{
    ReplyInputView *replyInputView = [[ReplyInputView alloc]initWithFrame:CGRectMake(0, self.view.bounds.origin.y + self.view.frame.size.height - 105, screenWidth, 54) andAboveView:self.view];
    
    self.flag = YES;
    //回调输入框的contentSize,改变工具栏的高度
    [replyInputView setContentSizeBlock:^(CGSize contentSize) {
        [self updateHeight:contentSize];
    }];
    
    [replyInputView setReplyAddBlock:^(NSString *replyText, NSInteger inputTag) {
        replyText = [@"浮夸：" stringByAppendingString:replyText];
        FamilyGroupFrame *familyGroupFrameNeedChanged = self.familyGroupData[inputTag];
        FamilyGroup *newFamilyGroup = familyGroupFrameNeedChanged.familyGroup;
        //做个中转
        NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
        [mutaArray addObjectsFromArray:newFamilyGroup.replys];
        [mutaArray addObject:replyText];
        newFamilyGroup.replys = mutaArray;
        
        familyGroupFrameNeedChanged.replysF = nil;
        familyGroupFrameNeedChanged.picturesF = nil;
        familyGroupFrameNeedChanged.familyGroup = newFamilyGroup;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:inputTag inSection:0];  //nsindexpath初始化方法
        [self.familyTableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];

    }];

    replyInputView.replyTag = tag;    //值为cell所在的行
    [self.view addSubview:replyInputView];
    self.replyInputView = replyInputView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FamilyGroupFrame *frame = self.familyGroupData[indexPath.row];
    return frame.cellHeight;
}

//更新replyView的高度约束
-(void)updateHeight:(CGSize)contentSize
{
    float height = contentSize.height + 20;
    CGRect frame = self.replyInputView.frame;
    frame.origin.y -= height - frame.size.height;  //高度往上拉伸
    frame.size.height = height;
    self.replyInputView.frame = frame;
}

//键盘出来的时候调整replyView的位置
-(void) keyChange:(NSNotification *) notify
{
    NSDictionary *dic = notify.userInfo;
    CGRect keyboardRect = [dic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    if (keyboardRect.size.height >250 && self.flag) {
        [UIView animateWithDuration:[dic[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            
            [UIView setAnimationCurve:[dic[UIKeyboardAnimationCurveUserInfoKey] doubleValue]];
            
            CGRect frame = self.replyInputView.frame;
            frame.origin.y = frame.origin.y - keyboardRect.size.height + 52;
            self.replyInputView.frame = frame;
            
            CGPoint point = self.familyTableView.contentOffset;
            
            point.y -= (frame.origin.y - self.replyViewDraw);
            self.familyTableView.contentOffset = point;
        }];
        self.flag = NO;

    }
}

@end
