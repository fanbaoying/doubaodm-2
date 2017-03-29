//
//  MySelfTableViewCell.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/22.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "MySelfTableViewCell.h"

@implementation MySelfTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.myView = [[UIView alloc]init];
        self.myView.backgroundColor = [UIColor whiteColor];

        self.titleLab = [[UILabel alloc]init];
        self.titleLab.font = [UIFont systemFontOfSize:14.0];
        self.quitLab.textAlignment = NSTextAlignmentLeft;
        
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.font = [UIFont systemFontOfSize:14.0];
        self.contentLab.textColor = [UIColor lightGrayColor];
        self.contentLab.textAlignment = NSTextAlignmentRight;
        
        self.quitLab = [[UILabel alloc]init];
        self.quitLab.font = [UIFont systemFontOfSize:18.0];
        self.quitLab.textColor = [UIColor redColor];
        self.quitLab.textAlignment = NSTextAlignmentCenter;
        
        [self.myView addSubview:_titleLab];
        [self.myView addSubview:_contentLab];
        [self.myView addSubview:_quitLab];

        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    
    self.titleLab.frame = CGRectMake(10, 10, SCREEN_WIDTH/4, 30);
    self.contentLab.frame = CGRectMake(SCREEN_WIDTH/4, 10, SCREEN_WIDTH*3/4-10, 30);
    self.quitLab.frame = CGRectMake(0, 10, SCREEN_WIDTH, 30);
}
@end
