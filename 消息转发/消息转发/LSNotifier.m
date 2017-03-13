//
//  LSNotifier.m
//  消息转发
//
//  Created by togo on 2017/3/10.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LSNotifier.h"

@interface LSNotifier ()

@property (strong, nonatomic) NSHashTable *observers;

@end

@implementation LSNotifier

+ (instancetype)notifier:(BOOL)shouldRetainObserver {
    
    LSNotifier *notifier = [super alloc];
    notifier.observers = [NSHashTable hashTableWithOptions:shouldRetainObserver ? NSPointerFunctionsStrongMemory : NSPointerFunctionsWeakMemory];
    return notifier;
}

+ (id)alloc
{
    return [LSNotifier notifier:NO];
}
+ (instancetype)notifier
{
    return [LSNotifier notifier:NO];
}
+ (instancetype)ratainNotifier
{
    return [LSNotifier notifier:YES];
}

#pragma mark - Interface

- (BOOL)hasObserver
{
    return self.observers.allObjects.count > 0;
}

- (void)addObserver:(id)observer {
    if (observer) {
        
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        [self.observers addObject:observer];
        dispatch_semaphore_signal(self.lock);
    }
}

- (void)removeObserver:(id)observer {
    if (observer) {
        
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        [self.observers removeObject:observer];
        dispatch_semaphore_signal(self.lock);
    }
}

#pragma mark - Forward

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *signature;
    for (id observer in self.observers.allObjects) {
        
            signature = [observer methodSignatureForSelector:sel];
        if (signature) { return signature; }
    }
    signature= [super methodSignatureForSelector:sel];
    if (signature==nil) {
         signature =[NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return signature;    
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    
    for (id observer in self.observers.allObjects) {
        ![observer respondsToSelector:invocation.selector] ?: [invocation invokeWithTarget:observer];
    }
}

#pragma mark - Getter
- (dispatch_semaphore_t)lock {
    
    static dispatch_semaphore_t lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = dispatch_semaphore_create(1);
    });
    return lock;
}

@end
