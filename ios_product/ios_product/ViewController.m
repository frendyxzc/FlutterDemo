//
//  ViewController.m
//  ios_product
//
//  Created by frendy on 2019/9/30.
//  Copyright © 2019 frendy. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(20, 120, 280, 40);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"Test" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    [self pushFlutterViewController];
}

- (void)pushFlutterViewController {
    
}

@end
