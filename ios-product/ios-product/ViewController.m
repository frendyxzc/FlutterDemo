//
//  ViewController.m
//  ios_product
//
//  Created by frendy on 2019/9/30.
//  Copyright © 2019 frendy. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>
#import "AppDelegate.h"

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
    [self handleButtonAction];
}

- (void)handleButtonAction {
    FlutterEngine *flutterEngine = [(AppDelegate *)[[UIApplication sharedApplication] delegate] flutterEngine];
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [flutterViewController setInitialRoute:@"route1"];
    [self presentViewController:flutterViewController animated:false completion:nil];
}

//- (void)handleButtonAction {
//    FlutterViewController *flutterViewController = [[FlutterViewController alloc] init];
//
//    // 添加 MethodChannel
//    [self addMethodChannelWithNameWithBinaryMessenger:flutterViewController];
//
//    // 指定前往的flutter页面，不指定则为flutter main.dart中的指定的首页页面
//    if (self.initialRoute.length) {
//        [flutterViewController setInitialRoute:self.initialRoute];
//    }
//
//    // 前往 flutter 模块页面
//    [self.navigationController pushViewController:flutterViewController animated:YES];
//}

- (void)addMethodChannelWithNameWithBinaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    __weak __typeof(self) weakSelf = self;

    NSString *channelName = @"com.pages.your/native_get";   // 要与main.dart中一致
    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
        // result 是给flutter的回调， 该回调只能使用一次
        NSLog(@"flutter 给到我：\nmethod=%@ \narguments = %@",call.method,call.arguments);

        NSDictionary *arguments = [call.arguments isKindOfClass:NSDictionary.class] ? call.arguments : nil;

        if ([call.method isEqualToString:@"toNativeSomething"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"flutter回调" message:[NSString stringWithFormat:@"%@",call.arguments] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];

            // 回调给flutter
            if (result) {
                result(@1000);
            }
        } else if ([call.method isEqualToString:@"isHybrid"]) {
            result==nil ?: result(@YES);
        } else if ([call.method isEqualToString:@"toNativePush"]) {
            ViewController *testViewController = [[ViewController alloc] init];
            testViewController.initialRoute = [arguments objectForKey:@"initialRoute"];
            testViewController.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:(arc4random()%9+1)/10 alpha:1];
            [weakSelf.navigationController pushViewController:testViewController animated:YES];
        } else if ([call.method isEqualToString:@"toNativePop"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
