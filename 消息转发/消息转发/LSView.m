

//
//  LSView.m
//  消息转发
//
//  Created by 刘松 on 16/12/8.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import "LSView.h"
#import "NSObject+LSRunTime.h"

@implementation LSView

-(void)click:(NSInteger)index

{
    NSLog(@"111111111111111111-----%d",index);
}

+(void)load
{
    
    [self ls_swizzleClassMethod:[self class] originalSel:@selector(log1) newSel:@selector(log2)];
}
+(void)log1
{
    NSLog(@"log111");
}


+(void)log2
{
    NSLog(@"log222222");
}

@end
