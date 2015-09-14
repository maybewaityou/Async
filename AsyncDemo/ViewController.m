//
//  ViewController.m
//  AsyncDemo
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "ViewController.h"
#import "Async.h"
#import "ReactiveCocoa.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong)Async *async;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testCancel];
}

- (void)testMain
{
    [Async main:^{
        NSLog(@"===>>> This is run on the main queue");
        NSLog(@"===>>> %@",[NSThread mainThread]);
    }];
}

- (void)testBackground
{
    [Async background:^{
        NSLog(@"===>>> This is run on the background queue");
        NSLog(@"===>>> %@",[NSThread mainThread]);
    }];
}

- (void)testMainAfter
{
    [Async mainAfter:5 block:^{
        NSLog(@"===>>> This is run on the main queue after 5 seconds");
        NSLog(@"===>>> %@",[NSThread mainThread]);
    }];
}

- (void)testBackgroundAfter
{
    [Async backgroundAfter:5 block:^{
        NSLog(@"===>>> This is run on the background queue after 5 seconds");
        NSLog(@"===>>> %@",[NSThread mainThread]);
    }];
}

- (void)testChain
{
    [[Async main:^{
        NSLog(@"===>>> This is run on the main queue");
        NSLog(@"===>>> %@",[NSThread mainThread]);
    }] backgroundAfter:5 block:^{
        NSLog(@"===>>> This is run on the background queue after 5 seconds");
        NSLog(@"===>>> %@",[NSThread mainThread]); 
    }];
}

- (void)testCancel
{
    self.async = [Async backgroundAfter:5 block:^{
        NSLog(@"===>>> background ");
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@44);
    }];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"==xxx=>>> %@",x);
        [self.async cancel];
    }];
}

@end
