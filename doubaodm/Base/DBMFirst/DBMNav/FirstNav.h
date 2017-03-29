//
//  FirstNav.h
//  doubaodm
//
//  Created by 范保莹 on 2017/2/15.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstNav : UIView
@property(strong,nonatomic)UIImageView *bgImg;

@property(strong,nonatomic)UIButton *rightBtn;

@property(strong,nonatomic)UIButton *rightLeftBtn;

@property(strong,nonatomic)UIButton *lab1Btn;

@property(strong,nonatomic)UILabel *titleLab;

@property(strong,nonatomic)UIButton *leftBtn;

@property(strong,nonatomic)UIButton *lab2Btn;

- (instancetype)initWithLeftBtn:(NSString *)leftBtn andWithTitleLab:(NSString *)titleLab andWithRightBtn:(NSString *)rightBtn andWithRightLeftBtn:(NSString *)rightLeftBtn andWithBgImg:(UIImageView *)bgImg andWithLab1Btn:(NSString *)lab1Btn andWithLab2Btn:(NSString *)lab2Btn;
@end
