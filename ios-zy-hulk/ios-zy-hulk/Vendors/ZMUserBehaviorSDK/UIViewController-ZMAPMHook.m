//
//  NSObject-TableViewHook.m
//  ZMLogTest
//
//  Created by jun2 on 2019/4/27.
//  Copyright © 2019 jun2. All rights reserved.
//

#import "UIViewController-ZMAPMHook.h"
#import "ZMZAPMHookBase.h"
#import "ZMFileWriter.h"
#import "ZMAPM.h"
#import "APMTools.h"
#import "ZMMobClick.h"

@implementation UIViewController(ZMAPMHook)

+ (void)apmHook {
    [ZMZAPMHookBase hookClass:[self class] originalSelector:@selector(presentViewController:animated:completion:) swizzledSelector:@selector(apmhook_presentViewController:animated:completion:)];
    [ZMZAPMHookBase hookClass:[self class] originalSelector:@selector(viewWillAppear:) swizzledSelector:@selector(apmhook_viewWillAppear:)];
}

- (void)recordPush:(NSString *)params {
    NSDictionary *dic = @{@"time":[ZMAPM getTime],
                          @"counter":[[ZMAPM sharedInstance] getCounter],
                          @"type":@"switchview",
                          @"viewcontroller":[APMTools getCurrentViewControllerName],
                          @"value":@"",
                          @"param":params,
                          @"resq":@"",
                          @"resp":@"",
                          @"stacks":@""
                          };
    NSLog(@"页面捕捉:%@",dic);
//    [FileWriter writeDic:dic];
}


- (void)apmhook_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
//    [self recordPush:[NSString stringWithFormat:@"Present To %@",[viewControllerToPresent class]]];
    [ZMMobClick eventScreenOutCurrentScreen:[APMTools getCurrentViewControllerName]];
    if ([self respondsToSelector:@selector(apmhook_presentViewController:animated:completion:)]) {
        [self apmhook_presentViewController:viewControllerToPresent animated:flag completion:completion ];
    }
}

- (void)recordNav:(NSString *)params {
    NSDictionary *dic = @{
                          @"time":[ZMAPM getTime],
                          @"counter":[[ZMAPM sharedInstance] getCounter],
                          @"type":@"switchview",
                          @"viewcontroller":[APMTools getCurrentViewControllerName],
                          @"value":@"",
                          @"param":params,
                          @"resq":@"",
                          @"resp":@"",
                          @"stacks":@""
                          };
    NSLog(@"行为跟踪%@",dic);
//    [FileWriter writeDic:dic];
}

-(void)apmhook_viewWillAppear:(BOOL)animated{
//    [self recordNav:@"POP ViewControllerNext"];
    [ZMMobClick eventScreenInCurrentScreen:[APMTools getCurrentViewControllerName]];
    if ([self respondsToSelector:@selector(apmhook_viewWillAppear:)]) {
        [self apmhook_viewWillAppear:animated];
    }
}

@end

