//
//  NetworkManager.m
//  NetWork
//
//  Created by xiong on 16/8/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import "NetworkOperationManager.h"
#import "AFNetworking.h"

@interface NetworkOperationManager()

@property (nonatomic, strong) NSMutableArray *operations;

@end

@implementation NetworkOperationManager

+ (instancetype)shareManager{
    static NetworkOperationManager *networkManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[NetworkOperationManager alloc]init];
    });
    return networkManager;
}

- (NSMutableArray *)operations {
    
    if (!_operations)
    {
        _operations = [[NSMutableArray alloc] init];
    }
    return _operations;
}

- (void)addOperation:(id)operation {
    
    if ([self.operations indexOfObject:operation] == NSNotFound)
    {
        if ([operation isKindOfClass:[AFHTTPRequestOperation class]])
        {
            NSLog(@"加入请求:%@", ((AFHTTPRequestOperation *)operation).request);
        }
        else if([operation isKindOfClass:[NSURLSessionDataTask class]])
        {
            NSLog(@"加入请求:%@",  ((NSURLSessionDataTask *)operation).currentRequest);
        }
        
        [self.operations addObject:operation];
        
        NSLog(@"所有请求数:%ld", (unsigned long)self.operations.count);
    }
}

- (void)removeOperation:(id)operation {
    
    if ([self.operations indexOfObject:operation] != NSNotFound)
    {
        if ([operation isKindOfClass:[AFHTTPRequestOperation class]])
        {
            NSLog(@"移除请求:%@", ((AFHTTPRequestOperation *)operation).request);
        }
        else if([operation isKindOfClass:[NSURLSessionDataTask class]])
        {
            NSLog(@"移除请求:%@",  ((NSURLSessionDataTask *)operation).currentRequest);
        }
        
        [operation cancel];
        [self.operations removeObject:operation];
        
        NSLog(@"所有请求数:%ld", (unsigned long)self.operations.count);
    }
}

- (void)removeAllOperation {
    
    for (id operation in self.operations)
    {
        [operation cancel];
    }
    
    [self.operations removeAllObjects];
}

- (NSArray *)allOperation {
    
    return self.operations;
}

@end
