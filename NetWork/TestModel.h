//
//  TestModel.h
//  NetWork
//
//  Created by xiong on 16/8/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel :NSObject
@property (nonatomic, assign) NSInteger resultNo;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSArray *result;

@end


@interface TestModel2 : NSObject
@property (nonatomic, copy) NSString *address;
@end