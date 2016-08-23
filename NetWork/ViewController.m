//
//  ViewController.m
//  NetWork
//
//  Created by xiong on 16/8/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSURLSessionDataTask *op = [[NetworkRequestManager shareManager] GET:@"http://114.80.110.197/v3/028/json/reply/GetRegionPostsRequest" params:nil targetModelClass:[TestModel class] completionHnadle:^(id operation, id targetModel, NSError *error) {
        
        TestModel *model = (TestModel *)targetModel;
        
        [model.Result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            TestModel2 *model2 = (TestModel2 *)obj;
            
            NSLog(@"测试地址 : %@", model2.address);
        }];
        
    }];
    
    [self addOperation:op];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    // 退出界面时  取消所有未完成的网络请求
    [self cancelAllOperation];
}

@end
