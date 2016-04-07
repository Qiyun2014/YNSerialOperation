//
//  YNSerialOpration.h
//  Demo
//
//  Created by qiyun on 16/4/6.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YNSerialOperation : NSObject

+ (instancetype)shareInstanceWithOperation;


//adding

- (void)addBlockOperationWithBlock:(void (^) (void))block withName:(NSString *)name;

- (void)addOperation:(NSOperation *)operation withOperationName:(NSString *)name;

- (void)addBlockOperation:(NSBlockOperation *)blockOperation withBlockOperationName:(NSString *)name;



//cancle
- (void)cancleOperation:(NSString *)operationName;

//canle all
- (void)cancleAllOperation;

//suspended
- (void)suspendedOperation:(NSString *)operationName;



- (NSOperationQueue *)currentOperation;

@end
