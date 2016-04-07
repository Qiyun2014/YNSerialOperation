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

