//
//  FBYHomeService.m
//  doubao
//
//  Created by 范保莹 on 2017/1/16.
//  Copyright © 2017年 TAG. All rights reserved.
//

#import "FBYHomeService.h"
#import "AFNetworking.h"

@implementation FBYHomeService

- (void)searchMessage:(NSString *)pageNum andWithAction:(NSString *)action andWithDic:(NSDictionary *)Alldic andUrl:(NSString *)url andSuccess:(void (^)(NSDictionary *))success andFailure:(void (^)(int))failure{

    NSString *urlstr= [NSString stringWithFormat:@"%@%@",DBAllURL,url];
    //1.创建ADHTTPSESSIONMANGER对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    
    //2.设置该对象返回类型
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    
    [manager POST:urlstr parameters:Alldic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
        
        success(dic);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----返回错误");
        NSLog(@"%@",error);
        
    }];
    
}

@end
