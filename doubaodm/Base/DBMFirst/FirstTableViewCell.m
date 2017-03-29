//
//  FirstTableViewCell.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/20.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "FirstTableViewCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation FirstTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.myView = [[UIView alloc]init];
        self.myView.backgroundColor = [UIColor whiteColor];

        self.codeImg = [[UIImageView alloc]init];
        self.codeImg.backgroundColor = [UIColor whiteColor];
        self.codeImg.layer.borderWidth = 1;
        self.codeImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.codeImg.layer.cornerRadius = 5.0;
        self.codeImg.clipsToBounds = YES;
        
        self.codeNameLab = [[UILabel alloc]init];
        self.codeNameLab.font = [UIFont systemFontOfSize:14.0];
        
        self.codeNumLab = [[UILabel alloc]init];
        self.codeNumLab.font = [UIFont systemFontOfSize:12.0];
        self.codeNumLab.textColor = [UIColor lightGrayColor];

        self.lab = [[UILabel alloc]init];
        self.lab.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
        
        [self.myView addSubview:_lab];
        [self.myView addSubview:_codeNumLab];
        [self.myView addSubview:_codeNameLab];
        [self.myView addSubview:_codeImg];
        
        
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    
    self.codeImg.frame = CGRectMake(10, 10, 40, 40);
    self.codeNameLab.frame = CGRectMake(60, 10, SCREEN_WIDTH/3, 20);
    self.codeNumLab.frame = CGRectMake(60, 30, SCREEN_WIDTH-80, 20);
    self.lab.frame = CGRectMake(10, 60, SCREEN_WIDTH-10, 1);
}

@end
