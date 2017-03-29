//
//  SecondTableViewCell.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/21.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.myView = [[UIView alloc]init];
        self.myView.backgroundColor = [UIColor whiteColor];
        
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.font = [UIFont systemFontOfSize:14.0];
        
        self.lab = [[UILabel alloc]init];
        self.lab.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
        
        [self.myView addSubview:_lab];
        [self.myView addSubview:_contentLab];
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(30, 10, SCREEN_WIDTH-35, 40);
    
    self.contentLab.frame = CGRectMake(10, 5, SCREEN_WIDTH*2/3, 30);
    
    self.lab.frame = CGRectMake(10, 39, SCREEN_WIDTH-30, 1);
    
}

@end
