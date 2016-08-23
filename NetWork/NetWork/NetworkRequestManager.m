//
//  NetworkRequestManager.m
//  NetWork
//
//  Created by xiong on 16/8/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import "NetworkRequestManager.h"
#import "NetworkOperationManager.h"
#import "AFNetworking.h"
#import "MJExtension.h"

// 是否使用  NSURLSession  来完成网络请求
#define UseNSURLSession 1

@implementation NetworkRequestManager

+ (instancetype)shareManager{
    static NetworkRequestManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetworkRequestManager alloc]init];
    });
    return manager;
}


- (id)POST:(NSString *)address params:(NSDictionary *)params targetModelClass:(Class)targetModel completionHnadle:(CompletionHandle)handle{
    
    id requestOperation;
    
    requestOperation = [self requestWithMethod:@"POST" address:address params:params completionHnadle:^(id operation, id responseObject, NSError *error) {
        if (error)
        {
            handle(operation, nil, error);
        }
        else
        {
            id model = [targetModel mj_objectWithKeyValues:responseObject];
            
            handle (operation, model , nil);
        }
    }];
    
    return requestOperation;
}

- (id)GET:(NSString *)address params:(NSDictionary *)params targetModelClass:(Class)targetModel completionHnadle:(CompletionHandle)handle{
    
    id requestOperation;
    
    requestOperation = [self requestWithMethod:@"GET" address:address params:params completionHnadle:^(id operation, id responseObject, NSError *error) {
        
        if (error)
        {
            handle(operation, nil, error);
        }
        else
        {
            id model = [targetModel mj_objectWithKeyValues:responseObject];
            
            handle (operation, model , nil);
        }
    }];
    
    return requestOperation;
}

- (id)requestWithMethod:(NSString *)requestMethod address:(NSString *)address params:(NSDictionary *)params completionHnadle:(void(^)(id operation, id responseObject, NSError *error))handle{
    
    if (SYSTEMVERSION > 7.0 && UseNSURLSession) {
        
        NSURLSessionDataTask *requestTask;
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        
        [self setOperationManagerHeader:manager];
        
        [self setOperationManagerOtherInfo:manager];
        
        //    [self setOperationManagerSecurityPolicy:manager];
        
        if ([requestMethod isEqualToString:@"POST"])
        {
            requestTask = [manager POST:address parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                handle (task, responseObject, nil);
                
                [self removeRequestOperation:requestTask];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                handle (task, nil, error);
                
                [self removeRequestOperation:requestTask];
            }];
        }
        else if ([requestMethod isEqualToString:@"GET"])
        {
            requestTask = [manager GET:address parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                
                handle (task, responseObject, nil);
                
                [self removeRequestOperation:requestTask];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                handle (task, nil, error);
                
                [self removeRequestOperation:requestTask];
            }];
        }
        else
        {
            NSLog(@"暂无该方法, 若需要, 请此添加");
        }
        
        [self addRequestOperation:requestTask];
        
        return requestTask;
    }
    else
    {
        AFHTTPRequestOperation *requestOperation;
        
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
        
        [self setOperationManagerHeader:manager];
        
        [self setOperationManagerOtherInfo:manager];
        
        //    [self setOperationManagerSecurityPolicy:manager];
        
        if ([requestMethod isEqualToString:@"POST"])
        {
            requestOperation = [manager POST:address parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                
                handle (operation, operation.responseObject, nil);
                
                [self removeRequestOperation:requestOperation];
                
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                
                handle (operation, nil, error);
                
                [self removeRequestOperation:requestOperation];
            }];
        }
        else if ([requestMethod isEqualToString:@"GET"])
        {
            requestOperation = [manager GET:address parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                
                handle (operation, operation.responseObject, nil);
                
                [self removeRequestOperation:requestOperation];
                
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                
                handle (operation, nil, error);
                
                [self removeRequestOperation:requestOperation];
            }];
        }
        else
        {
            NSLog(@"暂无该方法, 若需要, 请此添加");
        }
        
        [self addRequestOperation:requestOperation];
        
        return requestOperation;
    }
    
}

#pragma mark - 初始化AFHTTPRequestOperationManager / AFHTTPSessionManager 其他参数
///设置operationManager的请求头
- (void)setOperationManagerHeader:(id)manager
{
    if ([manager isKindOfClass:[AFHTTPRequestOperationManager class]])
    {
        [((AFHTTPRequestOperationManager *)manager).requestSerializer setValue:@"iOS" forHTTPHeaderField:@"platform"];
    }
    else if ([manager isKindOfClass:[AFHTTPSessionManager class]])
    {
        [((AFHTTPSessionManager *)manager).requestSerializer setValue:@"iOS" forHTTPHeaderField:@"platform"];
    }
    
}

/// 设置请求附加属性
- (void)setOperationManagerOtherInfo:(id)manager
{
    if ([manager isKindOfClass:[AFHTTPRequestOperationManager class]])
    {
        
        ((AFHTTPRequestOperationManager *)manager).requestSerializer = [AFJSONRequestSerializer serializer];
        
        ((AFHTTPRequestOperationManager *)manager).responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
        
        // 设置可接收的数据类型
        [((AFHTTPRequestOperationManager *)manager).responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",nil]];
        
        // 设置请求超时时长
        [((AFHTTPRequestOperationManager *)manager).requestSerializer setTimeoutInterval:5.0f];
        
    }
    else if ([manager isKindOfClass:[AFHTTPSessionManager class]])
    {
        ((AFHTTPSessionManager *)manager).requestSerializer = [AFJSONRequestSerializer serializer];
        
        ((AFHTTPSessionManager *)manager).responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
        
        // 设置可接收的数据类型
        [((AFHTTPSessionManager *)manager).responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",nil]];
        
        // 设置请求超时时长
        [((AFHTTPSessionManager *)manager).requestSerializer setTimeoutInterval:5.0f];
    }
}


/// 若为 https 请求则设置根证书
- (void)setOperationManagerSecurityPolicy:(id)manager
{
    //导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"root.cer" ofType:nil];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    if (!certData) {
        NSLog(@"sorry , SSL certificate load failed!");
    }
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    securityPolicy.allowInvalidCertificates = NO;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    securityPolicy.validatesDomainName = YES;
    
    securityPolicy.pinnedCertificates = certData ? @[certData] : @[];
    
    if ([manager isKindOfClass:[AFHTTPRequestOperationManager class]])
    {
        ((AFHTTPSessionManager *)manager).securityPolicy = securityPolicy;
    }
    else if ([manager isKindOfClass:[AFHTTPSessionManager class]])
    {
        ((AFHTTPSessionManager *)manager).securityPolicy = securityPolicy;
    }
}


#pragma mark - operations 队列管理
- (void)removeAllRequestOperations{
    [[NetworkOperationManager shareManager] removeAllOperation];
}

- (void)removeRequestOperation:(AFHTTPRequestOperation *)operation{
    [[NetworkOperationManager shareManager]removeOperation:operation];
}

- (void)addRequestOperation:(AFHTTPRequestOperation *)operation{
    [[NetworkOperationManager shareManager]addOperation:operation];
}

- (NSArray *)allRequestOperations{
    return [[NetworkOperationManager shareManager] allOperation];
}
@end
