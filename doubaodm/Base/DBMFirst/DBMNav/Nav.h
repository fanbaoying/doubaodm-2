//
//  Nav.h
//  tag
//
//  Created by 范保莹 on 2016/12/21.
//  Copyright © 2016年 范保莹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Nav : UIView

@property(strong,nonatomic)UIImageView *bgImg;

@property(strong,nonatomic)UIButton *rightBtn;

@property(strong,nonatomic)UIButton *lab1Btn;

@property(strong,nonatomic)UILabel *titleLab;

@property(strong,nonatomic)UIButton *leftBtn;

@property(strong,nonatomic)UIButton *lab2Btn;

- (instancetype)initWithLeftBtn:(NSString *)leftBtn andWithTitleLab:(NSString *)titleLab andWithRightBtn:(NSString *)rightBtn andWithBgImg:(UIImageView *)bgImg andWithLab1Btn:(NSString *)lab1Btn andWithLab2Btn:(NSString *)lab2Btn;
@end
