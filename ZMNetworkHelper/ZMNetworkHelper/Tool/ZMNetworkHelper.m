//
//  ZMNetworkHelper.m
//  ZMBCY
//
//  Created by Brance on 2017/11/26.
//  Copyright © 2017年 Brance. All rights reserved.
//

#import "ZMNetworkHelper.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation ZMNetworkHelper

static AFHTTPSessionManager *manager ;

+ (AFHTTPSessionManager *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"text/html;charset=utf-8"forHTTPHeaderField:@"Content-Type"];
        //关闭缓存，避免干扰调试
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//        //设置安全策略
//        _manager.requestSerializer.timeoutInterval = (weakSelf.timeoutInterval ? weakSelf.timeoutInterval : 10);

        manager.requestSerializer.timeoutInterval = 20;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain",@"text/json", @"text/javascript",@"text/html" ,nil];
    });
    return manager;
}

+ (void)requestGETWithRequestURL:(NSString *)requestURLString parameters:(id)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure{
    
    [[ZMNetworkHelper sharedInstance] GET:requestURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}

+ (void)requestPOSTWithRequestURL:(NSString *)requestURLString parameters:(id)parameters success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure{
    [[ZMNetworkHelper sharedInstance] POST:requestURLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}

@end


