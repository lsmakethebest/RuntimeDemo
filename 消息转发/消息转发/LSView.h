//
//  LSView.h
//  消息转发
//
//  Created by 刘松 on 16/12/8.
//  Copyright © 2016年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>

//随机颜色
#define RandomColor  [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]


@interface LSView : UIView


+(void)log1;
+(void)log2;
@end
