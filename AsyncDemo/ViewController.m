//
//  ViewController.m
//  AsyncDemo
//
//  Created by ChunNan on 15/9/8.
//  Copyright (c) 2015年 MeePwn. All rights reserved.
//

#import "ViewController.h"
#import "Async.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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

@end
