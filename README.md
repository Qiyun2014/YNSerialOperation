#使用NSOperation

##创建
```
operationQueue = [[NSOperationQueue alloc] init];

NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:block];
```
##添加到队列,并设定顺序

```
[operation addDependency:[self getAllOperation].lastObject];

[[YNSerialOperation shareInstanceWithOperation].operationQueue addOperation:operation];
```

##使用
```
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[YNSerialOperation shareInstanceWithOperation] addBlockOperationWithBlock:^{
            
            NSLog(@"1");
            
        } withName:@"1"];
        
        [[YNSerialOperation shareInstanceWithOperation] addBlockOperationWithBlock:^{
            
            NSLog(@"2");
            
        } withName:@"2"];
        
        [[YNSerialOperation shareInstanceWithOperation] addBlockOperationWithBlock:^{
            
            NSLog(@"3");
            
        } withName:@"3"];
        
        [[YNSerialOperation shareInstanceWithOperation] addBlockOperationWithBlock:^{
            
            NSLog(@"4");
            
        } withName:@"4"];
        
    });
    
```
>2016-04-07 13:03:52.047 Demo[3971:757116] 1
>2016-04-07 13:03:52.048 Demo[3971:757081] 2
>2016-04-07 13:03:52.049 Demo[3971:757081] 3
>2016-04-07 13:03:52.049 Demo[3971:757081] 4


