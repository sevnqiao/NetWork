//
//  NetworkRequestManager.h
//  NetWork
//
//  Created by xiong on 16/8/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperation;
@protocol AFMultipartFormData;

typedef void(^CompletionHandle)(id operation, id targetData, NSError *error);

@interface NetworkRequestManager : NSObject


+ (instancetype)shareManager;

#pragma mark - 网络请求模块

/**
 *  POST 请求
 *
 *  @param address     请求地址
 *  @param params      请求参数
 *  @param targetModel 需要转化的目标模型  (如果 targetModel 为 nil , 则返回默认的字典)
 *  @param handle      回调
 *
 *  @return 请求操作对象
 */
- (id)POST:(NSString *)address params:(NSDictionary *)params targetModelClass:(Class)targetModel completionHnadle:(CompletionHandle)handle;


/**
 *  GET 请求
 *
 *  @param address     请求地址
 *  @param params      请求参数
 *  @param targetModel 需要转化的目标模型 (如果 targetModel 为 nil , 则返回默认的字典)
 *  @param handle      回调
 *
 *  @return 请求操作对象
 */
- (id)GET:(NSString *)address params:(NSDictionary *)params targetModelClass:(Class)targetModel completionHnadle:(CompletionHandle)handle;


/**
 *  UPLOAD 上传数据
 *
 *  @param address           请求地址
 *  @param params            请求参数
 *  @param targetModel       需要转化的目标模型 (如果 targetModel 为 nil , 则返回默认的字典)
 *  @param multipartformData 需要上传的二进制数据 遵守 AFMultipartFormData 协议
 *  @param handle            回调
 *
 *  @return 请求操作对象
 */
- (id)UPLOAD:(NSString *)address params:(NSDictionary *)params targetModelClass:(Class)targetModel constructingFormData:(id <AFMultipartFormData> )multipartformData completionHnadle:(CompletionHandle)handle;




#pragma mark - operations 队列管理

/**
 *  取消队列中的所有请求
 */
- (void)removeAllRequestOperations;


/**
 *  取消队列中的某一个请求
 *
 *  @param operation 需要取消的请求
 */
- (void)removeRequestOperation:(id)operation;


/**
 *  添加一个请求到队列中
 *
 *  @param operation 需要添加的请求
 */
- (void)addRequestOperation:(id)operation;


/**
 *  队列中的所有请求
 *
 *  @return 所有请求的数组
 */
- (NSArray *)allRequestOperations;
@end
