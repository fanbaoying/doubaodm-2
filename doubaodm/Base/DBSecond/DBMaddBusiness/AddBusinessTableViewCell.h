//
//  AddBusinessTableViewCell.h
//  doubaodm
//
//  Created by 范保莹 on 2017/2/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NegoModel.h"

typedef void (^acceptBlock)(BOOL isAccept);

@interface AddBusinessTableViewCell : UITableViewCell


@property(strong,nonatomic)UIView *myView;

@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UILabel *timeLab;
@property(strong,nonatomic)UILabel *lab;

@property(strong,nonatomic)UILabel *nameLab;

@property(strong,nonatomic)UILabel *sexLab;

@property(strong,nonatomic)UILabel *ageLab;

@property(strong,nonatomic)UILabel *codeLab;

@property(strong,nonatomic)UILabel *typeLab;

@property(strong,nonatomic)UILabel *phoneLab;

@property(strong,nonatomic)UILabel *emailLab;

@property(strong,nonatomic)UIButton *transportBtn;

@property(strong,nonatomic)NegoModel *model;

@property (copy,nonatomic) acceptBlock accept;

@end
