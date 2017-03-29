//
//  TransportTableViewCell.m
//  doubaodm
//
//  Created by 范保莹 on 2017/2/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "TransportTableViewCell.h"
#import "MJExtension.h"

@implementation TransportTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.myView = [[UIView alloc]init];
        self.myView.backgroundColor = [UIColor whiteColor];
        
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.textAlignment = NSTextAlignmentLeft;
        self.titleLab.font = [UIFont systemFontOfSize:16.0];
        self.titleLab.numberOfLines = 0;
    
        self.oneBtn = [[UIButton alloc]init];
        self.oneBtn.layer.borderWidth = 1.0;
        self.oneBtn.layer.borderColor = [UIColor clearColor].CGColor;
        self.oneBtn.layer.cornerRadius = 25/2;
        self.oneBtn.clipsToBounds = YES;
        self.oneBtn.tag = 1000;
        [self.oneBtn setImage:[UIImage imageNamed:@"no@2x"] forState:UIControlStateNormal];
        [self.oneBtn setImage:[UIImage imageNamed:@"yes@2x"] forState:UIControlStateSelected];
        [self.oneBtn addTarget:self action:@selector(accept:) forControlEvents:UIControlEventTouchUpInside];

        self.oneLab = [[UILabel alloc]init];
        self.oneLab.textAlignment = NSTextAlignmentLeft;
//        self.oneLab.backgroundColor = [UIColor purpleColor];
        self.oneLab.font = [UIFont systemFontOfSize:14.0];
        
        self.twoBtn = [[UIButton alloc]init];
        self.twoBtn.layer.borderWidth = 1.0;
        self.twoBtn.layer.borderColor = [UIColor clearColor].CGColor;
        self.twoBtn.layer.cornerRadius = 25/2;
        self.twoBtn.clipsToBounds = YES;
        self.twoBtn.tag = 1001;
        [self.twoBtn setImage:[UIImage imageNamed:@"no@2x"] forState:UIControlStateNormal];
        [self.twoBtn setImage:[UIImage imageNamed:@"yes@2x"] forState:UIControlStateSelected];
        [self.twoBtn addTarget:self action:@selector(accept:) forControlEvents:UIControlEventTouchUpInside];
        
        self.twoLab = [[UILabel alloc]init];
        self.twoLab.textAlignment = NSTextAlignmentLeft;
        self.twoLab.font = [UIFont systemFontOfSize:14.0];
//        self.twoLab.backgroundColor = [UIColor redColor];
        
        self.thirdBtn = [[UIButton alloc]init];
        self.thirdBtn.layer.borderWidth = 1.0;
        self.thirdBtn.layer.borderColor = [UIColor clearColor].CGColor;
        self.thirdBtn.layer.cornerRadius = 25/2;
        self.thirdBtn.clipsToBounds = YES;
        self.thirdBtn.tag = 1002;
        [self.thirdBtn setImage:[UIImage imageNamed:@"no@2x"] forState:UIControlStateNormal];
        [self.thirdBtn setImage:[UIImage imageNamed:@"yes@2x"] forState:UIControlStateSelected];
        [self.thirdBtn addTarget:self action:@selector(accept:) forControlEvents:UIControlEventTouchUpInside];
        
        self.thirdLab = [[UILabel alloc]init];
        self.thirdLab.textAlignment = NSTextAlignmentLeft;
        self.thirdLab.font = [UIFont systemFontOfSize:14.0];
//        self.thirdLab.backgroundColor = [UIColor purpleColor];
        
        [self.myView addSubview:_thirdLab];
        [self.myView addSubview:_thirdBtn];
        [self.myView addSubview:_twoLab];
        [self.myView addSubview:_twoBtn];
        [self.myView addSubview:_oneLab];
        [self.myView addSubview:_oneBtn];
        [self.myView addSubview:_titleLab];
        
        [self.contentView addSubview:_myView];
        
        
    }
    
    
    return self;
}

- (void)setModel:(Transport *)model{

    if (model.isAccept) {
        
        for (NSInteger i=0; i<3; i++) {
            
            if (model.isTag == 4) return;
            UIButton *btn  = [self viewWithTag:i+1000];
            if (i==model.isTag-1000) {
                btn.selected = model.isAccept;
            }else{
                btn.selected = NO;
            }
        }
        
    }else{
        
        _oneBtn.selected = _twoBtn.selected = _thirdBtn.selected = model.isAccept;
        
        
    }
    
    _titleLab.text = model.title;
    
    NSArray *arr = [NSArray mj_objectArrayWithKeyValuesArray:model.content];
    _oneLab.text = [NSString stringWithFormat:@"%@",arr[0]];
    _twoLab.text = [NSString stringWithFormat:@"%@",arr[1]];
    _thirdLab.text = [NSString stringWithFormat:@"%@",arr[2]];
    
}

//点击事件
- (void)accept:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    for (NSInteger i=0; i<3; i++) {
        
        
        UIButton *btn  = [self viewWithTag:i+1000];
        if (i==sender.tag-1000) {
            btn.selected = sender.selected  ;
        }else{
            btn.selected = NO;
        }
    }
    
    if (_accept) {
        _accept(sender.selected,sender.tag);
    }
}

////1按钮
//- (void)oneBtn:(UIButton *)sender{
//    
//    sender.selected = !sender.selected;
//    
//    if (_accept) {
//        _accept(sender.selected);
//    }
//    
//}

////2按钮
//- (void)twoBtn:(UIButton *)sender{
//    
//    sender.selected = !sender.selected;
//    
//    if (_accept) {
//        _accept(sender.selected);
//    }
//    
//}
//
////3按钮
//- (void)thirdBtn:(UIButton *)sender{
//    
//    sender.selected = !sender.selected;
//    
//    if (_accept) {
//        _accept(sender.selected);
//    }
//    
//}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.myView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    
    self.titleLab.frame = CGRectMake(10, 10, SCREEN_WIDTH/4, 30);
    
    self.oneBtn.frame = CGRectMake(0, 45, 25, 25);
    self.oneLab.frame = CGRectMake(25, 40, SCREEN_WIDTH/3-25, 40);
    
    self.twoBtn.frame = CGRectMake(SCREEN_WIDTH/3, 45, 25, 25);
    self.twoLab.frame = CGRectMake(SCREEN_WIDTH/3+25, 40, SCREEN_WIDTH/3-25, 40);
    
    self.thirdBtn.frame = CGRectMake(SCREEN_WIDTH*2/3, 45, 25, 25);
    self.thirdLab.frame = CGRectMake(SCREEN_WIDTH*2/3+25, 40, SCREEN_WIDTH/3-25, 40);
    
}
@end
