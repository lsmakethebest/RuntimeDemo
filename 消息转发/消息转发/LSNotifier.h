//
//  LSNotifier.h
//  消息转发
//
//  Created by togo on 2017/3/10.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LSNotifObservers(action) if (self.notifier.hasObserver) { [self.notifier action]; }

@interface LSNotifier : NSProxy

+ (instancetype)notifier;
+ (instancetype)ratainNotifier;

- (BOOL)hasObserver;
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

@end
