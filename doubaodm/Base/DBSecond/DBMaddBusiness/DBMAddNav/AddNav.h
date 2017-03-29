//
//  AddNav.h
//  doubaodm
//
//  Created by 范保莹 on 2017/2/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNav : UIView

@property(strong,nonatomic)UIImageView *bgImg;

@property(strong,nonatomic)UIButton *leftBtn;

@property(strong,nonatomic)UITextField *titleText;

@property(strong,nonatomic)UILabel *lab;

- (instancetype)initWithLeftBtn:(NSString *)leftBtn andWithTitleText:(NSString *)titleText andWithLab:(NSString *)lab andWithBgImg:(UIImageView *)bgImg;
@end
