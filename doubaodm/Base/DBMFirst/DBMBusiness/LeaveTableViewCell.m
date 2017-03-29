//
//  LeaveTableViewCell.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/20.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "LeaveTableViewCell.h"

@implementation LeaveTableViewCell

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
        [self.headBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.headBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        self.headBtn.layer.cornerRadius = 5.0;
        self.headBtn.clipsToBounds = YES;
        self.headBtn.titleLabel.numberOfLines = 0;
        
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.font = [UIFont systemFontOfSize:14.0];
        self.contentLab.textColor = [UIColor lightGrayColor];
        self.contentLab.numberOfLines = 0;
        
        self.lookMoreLab = [[UILabel alloc]init];
        self.lookMoreLab.font = [UIFont systemFontOfSize:14.0];
        self.lookMoreLab.textAlignment = NSTextAlignmentCenter;
        
        [self.myView addSubview:_lookMoreLab];
        [self.myView addSubview:_contentLab];
        [self.myView addSubview:_headBtn];
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    
    self.headBtn.frame = CGRectMake(10, 10, 40, 40);
    self.contentLab.frame = CGRectMake(60, 10, SCREEN_WIDTH*2/3, 40);
    self.lookMoreLab.frame = CGRectMake(0, 10, SCREEN_WIDTH, 40);
}

@end
