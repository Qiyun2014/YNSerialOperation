//
//  YNSerialOpration.m
//  Demo
//
//  Created by qiyun on 16/4/6.
//  Copyright © 2016年 ProDrone. All rights reserved.
//

#import "YNSerialOperation.h"

@interface YNSerialOperation ()

@property (nonatomic,strong) NSOperationQueue *operationQueue;

@end

@implementation YNSerialOperation

static YNSerialOperation    *serialOpration = nil;

+ (instancetype)shareInstanceWithOperation{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        serialOpration = [[YNSerialOperation alloc] init];
        if (serialOpration) {
            
            serialOpration.operationQueue = [[NSOperationQueue alloc] init];
            
            [serialOpration.operationQueue setName:[[NSString alloc]
                                                    initWithUTF8String:object_getClassName(serialOpration.operationQueue)]];
        }
    });
    return serialOpration;
}


- (NSArray *)getAllOperation{

    return [YNSerialOperation shareInstanceWithOperation].operationQueue.operations;
}

- (void)addBlockOperationWithBlock:(void (^) (void))block withName:(NSString *)name{

    if (!block) return;

    //sleep(1);

    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:block];
    
    [[YNSerialOperation shareInstanceWithOperation] addBlockOperation:blockOperation
                                               withBlockOperationName:name];
}


- (void)addBlockOperation:(NSBlockOperation *)blockOperation withBlockOperationName:(NSString *)name{

    [[YNSerialOperation shareInstanceWithOperation] addOperation:blockOperation withOperationName:name];
}


//adding
- (void)addOperation:(NSOperation *)operation withOperationName:(NSString *)name{
    
    __block BOOL    isContainsObject = NO;
    
    [[self getAllOperation] enumerateObjectsUsingBlock:^(__kindof NSOperation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.name isEqualToString:name] && obj) {
            
            isContainsObject = YES;
        }
    }];
    
    if (!isContainsObject){
        
        if ([self getAllOperation].count)
            [operation addDependency:[self getAllOperation].lastObject];
        
        operation.name = name;
        [[YNSerialOperation shareInstanceWithOperation].operationQueue addOperation:operation];
    };
}



//cancle
- (void)cancleOperation:(NSString *)operationName{

    [[YNSerialOperation shareInstanceWithOperation].operationQueue setSuspended:YES];

    NSArray *operations = [YNSerialOperation shareInstanceWithOperation].operationQueue.operations;
    [operations enumerateObjectsUsingBlock:^(__kindof NSOperation * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if ([obj.name isEqualToString:operationName] && obj) {

            [obj cancel];
        }
    }];

    [[YNSerialOperation shareInstanceWithOperation].operationQueue setSuspended:NO];
}

//cancle all
- (void)cancleAllOperation{

    [[YNSerialOperation shareInstanceWithOperation].operationQueue cancelAllOperations];
}

//suspended
- (void)suspendedOperation:(NSString *)operationName{

    [[self getAllOperation] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if ([[(NSOperationQueue *)obj name] isEqualToString:operationName]) {

            [(NSOperationQueue *)obj setSuspended:YES];
        }
    }];
}

- (NSOperationQueue *)currentOperation{

    return [NSOperationQueue currentQueue];
}

@end
