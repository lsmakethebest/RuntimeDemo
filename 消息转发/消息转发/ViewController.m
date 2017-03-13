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



@interface ViewControllerNotofier : LSNotifier<ViewController>

@end
@implementation ViewControllerNotofier
@end

@interface ViewController ()

@property (weak, nonatomic) IBOutlet LSView *myView;
@property (weak, nonatomic) IBOutlet LSView2 *myView2;
@property (nonatomic,strong) ViewControllerNotofier *notifier;

@end



@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.notifier=[ViewControllerNotofier notifier];
    
    [self.notifier addObserver:self.myView];
    [self.notifier addObserver:self.myView2];
    
}

- (IBAction)buttonClick:(id)sender {

    LSNotifObservers(click:5);

}

@end
