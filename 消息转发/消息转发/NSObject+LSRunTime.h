//
//  NSObject+LSRunTime.h
//  消息转发
//
//  Created by 刘松 on 16/12/8.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LSRunTime)

//获取所有属性(仅有@properety定义的属性)
+(NSMutableArray*)ls_getPropertyNames;

//获取所有成员变量包括@properety和大括号定义的变量
+(NSMutableArray*)ls_getIvarNames;

//交换对象方法
+(void)ls_swizzleInstanceMethod:(Class) class originalSel:(SEL)originalSel newSel:(SEL)newSel;

//交换类方法
+(void)ls_swizzleClassMethod:(Class) class originalSel:(SEL)originalSel newSel:(SEL)newSel;


@end
