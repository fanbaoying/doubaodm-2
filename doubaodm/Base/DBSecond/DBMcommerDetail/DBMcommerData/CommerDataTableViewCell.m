//
//  CommerDataTableViewCell.m
//  doubaodm
//
//  Created by 范保莹 on 2017/1/22.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "CommerDataTableViewCell.h"

@implementation CommerDataTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.myView = [[UIView alloc]init];
        self.myView.backgroundColor = [UIColor whiteColor];
        
        self.headeImg = [[UIImageView alloc]init];
        self.headeImg.backgroundColor = [UIColor whiteColor];
        self.headeImg.layer.borderWidth = 1;
        self.headeImg.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.headeImg.layer.cornerRadius = 5.0;
        self.headeImg.clipsToBounds = YES;
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.font = [UIFont systemFontOfSize:16.0];
        
        self.contentLab = [[UILabel alloc]init];
        self.contentLab.font = [UIFont systemFontOfSize:14.0];
    
        [self.myView addSubview:_titleLab];
        [self.myView addSubview:_contentLab];
        [self.myView addSubview:_headeImg];
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    
    self.headeImg.frame = CGRectMake(20, 40, 30, 30);
    
    self.titleLab.frame = CGRectMake(20, 10, SCREEN_WIDTH/2, 30);
    
    self.contentLab.frame = CGRectMake(60, 40, SCREEN_WIDTH/2, 30);
    
}

@end
