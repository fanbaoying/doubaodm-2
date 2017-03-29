//
//  TransportTableViewCell.h
//  doubaodm
//
//  Created by 范保莹 on 2017/2/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transport.h"

typedef void (^acceptBlock)(BOOL isAccept, NSInteger tag);

@interface TransportTableViewCell : UITableViewCell

@property(strong,nonatomic)UIView *myView;

@property(strong,nonatomic)UILabel *titleLab;

@property(strong,nonatomic)UIButton *oneBtn;
@property(strong,nonatomic)UILabel *oneLab;

@property(strong,nonatomic)UIButton *twoBtn;
@property(strong,nonatomic)UILabel *twoLab;

@property(strong,nonatomic)UIButton *thirdBtn;
@property(strong,nonatomic)UILabel *thirdLab;

@property(strong,nonatomic)Transport *model;

@property (copy,nonatomic) acceptBlock accept;

@end
