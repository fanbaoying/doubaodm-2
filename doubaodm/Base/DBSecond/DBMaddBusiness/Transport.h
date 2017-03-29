//
//  Transport.h
//  doubaodm
//
//  Created by 范保莹 on 2017/2/13.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transport : NSObject

@property (copy,nonatomic) NSString *title; //类型

@property (copy,nonatomic) NSArray *content; //内容

@property (copy,nonatomic) NSArray *stepstate; //内容

@property (assign,nonatomic) BOOL isAccept ; //是否接受

@property (assign,nonatomic) NSInteger isTag; //接受值 0/1/2表示三个按钮 4表示没选中


@end
