//
//  LLFNetworkTool.h
//  LLFAFNetworkTool
//
//  Created by Apple on 16/12/5.
//  Copyright © 2016年 LLF. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


/**
 请求失败回调block

 @param successDic 请求失败返回的数据
 */
typedef void (^requestSuccessBlock)(NSDictionary *successDic);

/**
 请求失败回调blcok

 @param error 请求失败返回的数据
 */
typedef void (^requestFailureBlock)(NSError *error);

//请求方法define
typedef NS_ENUM(NSInteger, HTTPMethod) {
    GET = 0,
    POST,
    PUT,
    DELETE,
    HEAD
};

@interface LLFNetworkTool : AFHTTPSessionManager


/**
 AFHTTPSessionManager单例

 @return 单例实例对象
 */
+ (instancetype)sharedManager;

/**
 网络数据请求

 @param method 请求方法
 @param url 请求地址
 @param param 参数
 @param success 请求成功返回的数据
 @param failure 请求失败返回的数据
 */
- (void)requestWithMethod:(HTTPMethod)method
                      url:(NSString *)url
                    param:(id)param
             successBlock:(requestSuccessBlock)success
             failureBlock:(requestFailureBlock)failure;


@end
