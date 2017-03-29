//
//  AddNav.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "AddNav.h"

@implementation AddNav

- (instancetype)initWithLeftBtn:(NSString *)leftBtn andWithTitleText:(NSString *)titleText andWithLab:(NSString *)lab andWithBgImg:(UIImageView *)bgImg{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    if (self) {
        
        self.bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        self.bgImg.backgroundColor = [UIColor colorWithRed:0/255.0 green:122/255.0 blue:183/255.0 alpha:1];
        //        self.bgImg.backgroundColor = [UIColor clearColor];
        [self addSubview:_bgImg];

        self.leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        self.leftBtn.backgroundColor = [UIColor clearColor];
        [self.leftBtn setBackgroundImage:[UIImage imageNamed:leftBtn] forState:UIControlStateNormal];
        [self addSubview:_leftBtn];
        
        self.titleText = [[UITextField alloc]initWithFrame:CGRectMake(54, 20, SCREEN_WIDTH-88, 44)];
        self.titleText.backgroundColor = [UIColor clearColor]; 
        [self addSubview:_titleText];
        
        self.lab = [[UILabel alloc]initWithFrame:CGRectMake(54, 60, SCREEN_WIDTH-88, 1)];
        self.lab.backgroundColor = [UIColor colorWithRed:230/25.0 green:230/250.0 blue:230/250.0 alpha:1];
        [self addSubview:_lab];
        
        
        
    }
    return self;
}
@end
