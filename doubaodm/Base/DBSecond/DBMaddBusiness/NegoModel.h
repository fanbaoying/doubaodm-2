//
//  NegoModel.h
//  Select_demo
//
//  Created by admin on 17/1/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NegoModel : NSObject

@property (copy,nonatomic) NSString *fullname ; //名字

@property (copy,nonatomic) NSString *age; //年龄

@property (copy,nonatomic) NSString *businessid ; //编号

@property (copy,nonatomic) NSString *stepstate; //类型

@property (copy,nonatomic) NSString *phone; //电话

@property (copy,nonatomic) NSString *email; //email

@property (copy,nonatomic) NSString *ctime; //时间

@property (assign,nonatomic) BOOL isAccept ; //是否接受

@end
