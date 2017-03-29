//
//  SweepNav.h
//  doubao
//
//  Created by 范保莹 on 2017/1/15.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SweepNav : UIView

@property(strong,nonatomic)UIImageView *bgImg;

@property(strong,nonatomic)UIButton *rightBtn;

//@property(strong,nonatomic)UIButton *lab1Btn;

@property(strong,nonatomic)UIButton *leftBtn;

@property(strong,nonatomic)UILabel *titleLab;

//@property(strong,nonatomic)UIButton *lab2Btn;

- (instancetype)initWithLeftBtn:(NSString *)leftBtn andWithBgImg:(UIImageView *)bgImg andWithTitleLab:(NSString *)titleLab andWithRightBtn:(NSString *)rightBtn;
@end
