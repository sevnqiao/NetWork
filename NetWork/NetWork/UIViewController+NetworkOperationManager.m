//
//  UIViewController+NetworkOperationManager.m
//  NetWork
//
//  Created by xiong on 16/8/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import "UIViewController+NetworkOperationManager.h"
#import <objc/objc-runtime.h>
#import "NetworkRequestManager.h"

static NSString *kOperationKey = @"kOperationKey";

@implementation UIViewController (NetworkOperationManager)

-(NSMutableArray *)operations
{
    id obj = objc_getAssociatedObject(self, &kOperationKey);
    if (!obj) {
        obj = [[NSMutableArray alloc]init];
        objc_setAssociatedObject(self, &kOperationKey, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

-(void)addOperation:(id)operation
{
    [self.operations addObject:operation];
}

-(void)cancleOperation:(id)operation
{
    [self.operations removeObject:operation];
}

-(void)cancelAllOperation
{
    [[NetworkRequestManager shareManager] removeAllRequestOperations];
        
    [self.operations removeAllObjects];
}

@end
