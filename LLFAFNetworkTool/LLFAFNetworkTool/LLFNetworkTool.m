//
//  LLFNetworkTool.m
//  LLFAFNetworkTool
//
//  Created by Apple on 16/12/5.
//  Copyright © 2016年 LLF. All rights reserved.
//

#import "LLFNetworkTool.h"

@implementation LLFNetworkTool

#pragma mark - AFHTTPSessionManager单例
+ (instancetype)sharedManager
{
    static LLFNetworkTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]initWithBaseURL:[NSURL URLWithString:@"http://httpbin.org/"]];
    });
    
    return manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    if (self = [super initWithBaseURL: url]) {
        // 请求超时
        self.requestSerializer.timeoutInterval = 5.0;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    
    return self;
}

#pragma mark -  网络数据请求
- (void)requestWithMethod:(HTTPMethod)method url:(NSString *)url param:(id)param successBlock:(requestSuccessBlock)success failureBlock:(requestFailureBlock)failure
{
    switch (method) {
        case GET:
        {
            [self GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSError *error;
                    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                    success(responseDic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        }
            break;
        case POST:
        {
            [self POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    NSError *error;
                    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                    success(responseDic);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        }
        default:
            break;
    }
}

@end
