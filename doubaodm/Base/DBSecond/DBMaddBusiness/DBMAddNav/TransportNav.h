//
//  TransportNav.h
//  doubaodm
//
//  Created by 范保莹 on 2017/2/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransportNav : UIView

@property(strong,nonatomic)UIImageView *bgImg;

@property(strong,nonatomic)UIButton *rightBtn;

@property(strong,nonatomic)UILabel *titleLab;

@property(strong,nonatomic)UIButton *leftBtn;

- (instancetype)initWithLeftBtn:(NSString *)leftBtn andWithTitleLab:(NSString *)titleLab andWithRightBtn:(NSString *)rightBtn andWithBgImg:(UIImageView *)bgImg;
@end
