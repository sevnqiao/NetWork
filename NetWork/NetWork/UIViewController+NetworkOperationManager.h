//
//  UIViewController+NetworkOperationManager.h
//  NetWork
//
//  Created by xiong on 16/8/23.
//  Copyright © 2016年 xiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NetworkOperationManager)
@property (nonatomic, strong, readonly) NSMutableArray *operations;


-(void)addOperation:(id)operation;

-(void)cancleOperation:(id)operation;

-(void)cancelAllOperation;

@end
