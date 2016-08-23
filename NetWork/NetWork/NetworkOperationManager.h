//
//  NetworkOperationManager.h
//  NetWork
//
//  Created by xiong on 16/8/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkOperationManager : NSObject

/**
 *  网络请求 operation 管理类
 *
 *  @return 管理者
 */
+ (instancetype)shareManager;

/**
 *  添加一个网络请求操作到数组中
 *
 *  @param operation  void
 */
- (void)addOperation:(id)operation;

/**
 *  移除一个网络请求对象
 *
 *  @param operation  void
 */
- (void)removeOperation:(id)operation;

/**
 *  移除所有的网络请求
 */
- (void)removeAllOperation;

/**
 *  获取所有的网络请求数组
 *
 *  @return 网络请求的数组
 */
- (NSArray *)allOperation;
@end
