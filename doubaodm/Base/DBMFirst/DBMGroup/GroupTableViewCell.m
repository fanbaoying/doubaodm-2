//
//  GroupTableViewCell.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/23.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "GroupTableViewCell.h"
#import "UILabel+LabelHeightAndWidth.h"

@implementation GroupTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.myView = [[UIView alloc]init];
        self.myView.backgroundColor = [UIColor whiteColor];
        
        self.headBtn = [[UIButton alloc]init];
        self.headBtn.backgroundColor = [UIColor whiteColor];
        self.headBtn.layer.borderWidth = 1;
        self.headBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.headBtn.layer.cornerRadius = 5.0;
        self.headBtn.clipsToBounds = YES;
        
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.font = [UIFont systemFontOfSize:14.0];
        self.contentLab.numberOfLines = 0;
        CGFloat height = [UILabel getHeightByWidth:self.contentLab.frame.size.width title:self.contentLab.text font:self.contentLab.font];
        self.contentLab.frame = CGRectMake(10, 30, 200, height);
        
        self.timeLab = [[UILabel alloc]init];
        self.timeLab.font = [UIFont systemFontOfSize:12.0];
        self.timeLab.textColor = [UIColor lightGrayColor];
        
        self.messageBtn = [[UIButton alloc]init];
        self.messageBtn.backgroundColor = [UIColor whiteColor];
        self.messageBtn.layer.borderWidth = 1;
        self.messageBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.messageBtn.layer.cornerRadius = 5.0;
        self.messageBtn.clipsToBounds = YES;
        
        [self.myView addSubview:_contentLab];
        [self.myView addSubview:_timeLab];
        [self.myView addSubview:_headBtn];
        [self.myView addSubview:_messageBtn];
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    self.headBtn.frame = CGRectMake(10, 20, 40, 40);
    self.contentLab.frame = CGRectMake(60, 10, SCREEN_WIDTH-80, 40);
    self.timeLab.frame = CGRectMake(60, 60, SCREEN_WIDTH/7, 20);
    self.messageBtn.frame = CGRectMake(SCREEN_WIDTH-40, 60, 20, 20);
}
@end
