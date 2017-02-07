



//
//  NSObject+LSRunTime.m
//  消息转发
//
//  Created by 刘松 on 16/12/8.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "NSObject+LSRunTime.h"

#import <objc/runtime.h>
@implementation NSObject (LSRunTime)


+(NSMutableArray*)ls_getIvarNames
{
    NSMutableArray *names=[NSMutableArray array];
    unsigned int  count;
    Ivar *ivars =class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar ivar=ivars[i];
        NSString *ivarName=[NSString stringWithUTF8String:ivar_getName(ivar)];
        [names addObject:ivarName];
    }
    return names;
}
+(NSMutableArray*)ls_getPropertyNames
{
    NSMutableArray *names=[NSMutableArray array];
    unsigned int  count;
    objc_property_t *propertys =class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {
        objc_property_t property=propertys[i];
        NSString *propertyName=[NSString stringWithUTF8String:property_getName(property)];
        [names addObject:propertyName];
    }
    

    return names;

}

+(void)ls_swizzleInstanceMethod:(Class) class originalSel:(SEL)originalSel newSel:(SEL)newSel
{

    //两个方法的Method
    Method systemMethod = class_getInstanceMethod(class, originalSel);
    Method swizzMethod = class_getInstanceMethod(class, newSel);
    //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
    BOOL isAdd =
    class_addMethod(class, originalSel, method_getImplementation(swizzMethod),
                    method_getTypeEncoding(swizzMethod));
    if (isAdd) {
        //如果成功，说明类中不存在这个将要被替换方法的实现
        //将被交换方法的实现替换到这个并不存在的实现
        class_replaceMethod(class, newSel, method_getImplementation(systemMethod),
                            method_getTypeEncoding(systemMethod));
    } else {
        //否则，交换两个方法的实现
        method_exchangeImplementations(systemMethod, swizzMethod);
    }
    
}
+(void)ls_swizzleClassMethod:(Class)class originalSel:(SEL)originalSel newSel:(SEL)newSel
{
    
    //两个方法的Method
    Method systemMethod = class_getClassMethod(class, originalSel);
    Method swizzMethod = class_getClassMethod(class, newSel);
    //交换两个方法的实现
    method_exchangeImplementations(systemMethod, swizzMethod);
    
}


@end
