//
//  ManagerSearchSalesmanTableViewCell.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/16.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "ManagerSearchSalesmanTableViewCell.h"
#import "MJExtension.h"

@implementation ManagerSearchSalesmanTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.myView = [[UIView alloc]init];
        
        
        _salesmanName = [[UILabel alloc]init];
        
        self.okGoodsBtn = [[UIButton alloc]init];
        [self.okGoodsBtn setImage:[UIImage imageNamed:@"no"] forState:UIControlStateNormal];
        [self.okGoodsBtn setImage:[UIImage imageNamed:@"yes"] forState:UIControlStateSelected];
        [self.okGoodsBtn addTarget:self action:@selector(accept:) forControlEvents:UIControlEventTouchUpInside];
        
        
    
        [self.myView addSubview:_okGoodsBtn];
        [self.myView addSubview:_salesmanName];

        [self.contentView addSubview:_myView];
        
    }
    return self;
}

- (void)setModel:(ManagerSearch *)model{
    
    self.okGoodsBtn.selected = model.isAccept;

    self.salesmanName.text = model.fullname;

}

//补货按钮
- (void)accept:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (_accept) {
        _accept(sender.selected);
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    
    self.salesmanName.frame = CGRectMake(10, 10, SCREEN_WIDTH/2, 30);
    
    self.okGoodsBtn.frame = CGRectMake(SCREEN_WIDTH-60, 10, 30, 30);
}

@end
