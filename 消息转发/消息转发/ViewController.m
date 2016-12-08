//
//  ViewController.m
//  消息转发
//
//  Created by 刘松 on 16/12/8.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "ViewController.h"
#import "LSView.h"
#import "LSView2.h"
#import <objc/runtime.h>

@interface ViewController ()

{
    
    NSString *myName;
}
@property (weak, nonatomic) IBOutlet LSView *myView;
@property (weak, nonatomic) IBOutlet LSView2 *myView2;

@end



@implementation ViewController


//-(void)click:(NSInteger)index
//{
//    NSLog(@"click");
//}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self click:100];
}


+(BOOL)resolveInstanceMethod:(SEL)sel

{
    if (sel ==@selector(click:)) {
        //        class_addMethod([self class], sel, imp_implementationWithBlock(^(id self, NSString *word) {
        //                        NSLog(@"method resolution" );
        //                    }), "v@*");
        
        //v@*  格式类型查看链接  https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
        return NO;
    }
    return YES;
}

//-(id)forwardingTargetForSelector:(SEL)aSelector
//{
//    if (aSelector ==@selector(click:)) {
//
//        return [super forwardingTargetForSelector:aSelector];
//    }
//    return  self.myView;
//}


-(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        //NSMethodSignature * methodSignature = [self.myView methodSignatureForSelector:aSelector];
        methodSignature =[NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return methodSignature;
}

-(void)forwardInvocation:(NSInvocation *)anInvocation
{

        if ([self.myView respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:self.myView];
        }
        if ([self.myView2 respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:self.myView2];
        }
}



@end
