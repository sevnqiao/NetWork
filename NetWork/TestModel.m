//
//  TestModel.m
//  NetWork
//
//  Created by xiong on 16/8/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import "TestModel.h"

@implementation TestModel

// 某一属性为模型数组时   作以下声明
+ (NSDictionary *)objectClassInArray{
    return @{
             @"Result":[TestModel2 class]
             };
}
@end


@implementation TestModel2

// 需要替换名字的  在这里声明
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"address":@"Address",
             };
}

@end