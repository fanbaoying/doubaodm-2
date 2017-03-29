//
//  AddBusinessTableViewCell.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "AddBusinessTableViewCell.h"

@implementation AddBusinessTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.myView = [[UIView alloc]init];
        self.myView.layer.cornerRadius = 5.0;
        self.myView.clipsToBounds = YES;
        self.myView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.textAlignment = NSTextAlignmentLeft;
        self.titleLab.font = [UIFont systemFontOfSize:14.0];
        self.titleLab.numberOfLines = 0;
        
        self.timeLab = [[UILabel alloc]init];
        self.timeLab.textAlignment = NSTextAlignmentLeft;
        self.timeLab.font = [UIFont systemFontOfSize:14.0];
        self.timeLab.textColor = [UIColor lightGrayColor];
        self.timeLab.numberOfLines = 0;
        
        self.lab = [[UILabel alloc]init];
        self.lab.textColor = [UIColor lightGrayColor];
        
        self.nameLab = [[UILabel alloc]init];
        self.nameLab.textAlignment = NSTextAlignmentLeft;
        self.nameLab.font = [UIFont systemFontOfSize:14.0];
        self.nameLab.numberOfLines = 0;
        
        self.sexLab = [[UILabel alloc]init];
        self.sexLab.textAlignment = NSTextAlignmentLeft;
        self.sexLab.font = [UIFont systemFontOfSize:14.0];
        self.sexLab.numberOfLines = 0;
        
        self.ageLab = [[UILabel alloc]init];
        self.ageLab.textAlignment = NSTextAlignmentLeft;
        self.ageLab.font = [UIFont systemFontOfSize:14.0];
        self.ageLab.numberOfLines = 0;
        
        self.codeLab = [[UILabel alloc]init];
        self.codeLab.textAlignment = NSTextAlignmentLeft;
        self.codeLab.font = [UIFont systemFontOfSize:14.0];
        self.codeLab.numberOfLines = 0;
        
        self.typeLab = [[UILabel alloc]init];
        self.typeLab.textAlignment = NSTextAlignmentLeft;
        self.typeLab.font = [UIFont systemFontOfSize:14.0];
        self.typeLab.numberOfLines = 0;
        
        self.phoneLab = [[UILabel alloc]init];
        self.phoneLab.textAlignment = NSTextAlignmentLeft;
        self.phoneLab.font = [UIFont systemFontOfSize:14.0];
        self.phoneLab.numberOfLines = 0;
        
        self.emailLab = [[UILabel alloc]init];
        self.emailLab.textAlignment = NSTextAlignmentLeft;
        self.emailLab.font = [UIFont systemFontOfSize:14.0];
        self.emailLab.numberOfLines = 0;
        
        
        self.transportBtn = [[UIButton alloc]init];
        self.transportBtn.layer.borderWidth = 1.0;
        self.transportBtn.layer.borderColor = [UIColor colorWithRed:174/255.0 green:109/255.0 blue:45/255.0 alpha:1].CGColor;
        self.transportBtn.layer.cornerRadius = 5.0;
        self.transportBtn.clipsToBounds = YES;
        self.transportBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        self.transportBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.transportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.transportBtn setTitle:@"移动" forState:UIControlStateNormal];
        [self.transportBtn addTarget:self action:@selector(transportBtn:) forControlEvents:UIControlEventTouchUpInside];

        [self.myView addSubview:_transportBtn];
        [self.myView addSubview:_emailLab];
        [self.myView addSubview:_phoneLab];
        [self.myView addSubview:_typeLab];
        [self.myView addSubview:_ageLab];
        [self.myView addSubview:_sexLab];
        [self.myView addSubview:_codeLab];
        [self.myView addSubview:_nameLab];
        [self.myView addSubview:_timeLab];
        [self.myView addSubview:_titleLab];
        [self.myView addSubview:_lab];
        
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)setModel:(NegoModel *)model{
    
    self.transportBtn.selected = model.isAccept;
    
    self.titleLab.text = @"基本信息";
    NSString *timeStr = model.ctime;
    NSTimeInterval interval=[timeStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    self.timeLab.text =  [NSString stringWithFormat:@"%@创建",currentDateStr];
    
    self.nameLab.text =  [NSString stringWithFormat:@"姓名：%@",model.fullname];
    self.sexLab.text = @"性别：男";
    self.ageLab.text = [NSString stringWithFormat:@"年龄：%@",model.age];
    self.codeLab.text = [NSString stringWithFormat:@"编号：%@",model.businessid];
    self.typeLab.text = [NSString stringWithFormat:@"类型：%@",model.stepstate];
    self.phoneLab.text = [NSString stringWithFormat:@"电话：%@",model.phone];
    self.emailLab.text = [NSString stringWithFormat:@"邮箱：%@",model.email];
//    self.numbleLab.text = model.store;
}

//补货按钮
- (void)transportBtn:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (_accept) {
        _accept(sender.selected);
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 240);
    
    self.titleLab.frame = CGRectMake(20, 0, SCREEN_WIDTH/5, 30);
    self.timeLab.frame = CGRectMake(SCREEN_WIDTH/5+20, 0, SCREEN_WIDTH/2, 30);
    self.lab.frame = CGRectMake(20, 30, SCREEN_WIDTH*2/3, 1);
    self.nameLab.frame = CGRectMake(20, 30, SCREEN_WIDTH*2/3, 30);
    self.sexLab.frame = CGRectMake(20, 60, SCREEN_WIDTH*2/3, 30);
    self.ageLab.frame = CGRectMake(20, 90, SCREEN_WIDTH*2/3, 30);
    self.codeLab.frame = CGRectMake(20, 120, SCREEN_WIDTH*2/3, 30);
    self.typeLab.frame = CGRectMake(20, 150, SCREEN_WIDTH*2/3, 30);
    self.phoneLab.frame = CGRectMake(20, 180, SCREEN_WIDTH*2/3, 30);
    self.emailLab.frame = CGRectMake(20, 210, SCREEN_WIDTH*2/3, 30);
    self.transportBtn.frame = CGRectMake(SCREEN_WIDTH-30-SCREEN_WIDTH/6, 10, SCREEN_WIDTH/6, 30);
    
}

@end
