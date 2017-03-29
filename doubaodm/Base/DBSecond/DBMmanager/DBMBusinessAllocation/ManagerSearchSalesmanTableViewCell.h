//
//  ManagerSearchSalesmanTableViewCell.h
//  doubaodm
//
//  Created by 范保莹 on 2017/2/16.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerSearch.h"

typedef void (^acceptBlock)(BOOL isAccept);

@interface ManagerSearchSalesmanTableViewCell : UITableViewCell

@property(strong,nonatomic)UIView *myView;

@property (strong,nonatomic) UILabel *salesmanName;

@property(strong,nonatomic)UIButton *okGoodsBtn;

@property (strong,nonatomic) ManagerSearch *model;

@property (copy,nonatomic) acceptBlock accept;

@end
