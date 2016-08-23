//
//  TestModel.h
//  NetWork
//
//  Created by xiong on 16/8/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel :NSObject
@property (nonatomic, assign) NSInteger ResultNo;
@property (nonatomic, assign) NSInteger Total;
@property (nonatomic, strong) NSArray *Result;

@end


@interface TestModel2 : NSObject
@property (nonatomic, copy) NSString *address;
@end