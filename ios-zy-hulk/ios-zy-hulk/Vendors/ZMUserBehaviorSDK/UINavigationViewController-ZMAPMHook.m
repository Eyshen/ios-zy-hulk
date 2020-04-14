//
//  UIControl+UIControl_XY.m
//  iOSanimation
//
//  Created by biyabi on 15/9/29.
//  Copyright © 2015年 caijunrong. All rights reserved.
//

#import "UINavigationViewController-ZMAPMHook.h"
#import "ZMZAPMHookBase.h"
#import "ZMFileWriter.h"
#import "ZMAPM.h"
#import "APMTools.h"
#import "ZMMobClick.h"


@implementation UINavigationController(ZMAPMHook)

+ (void)apmHook {
    [ZMZAPMHookBase hookClass:self
         originalSelector:@selector(pushViewController:animated:)
         swizzledSelector:@selector(apmhook_pushViewController:animated:)];
    [ZMZAPMHookBase hookClass:self
         originalSelector:@selector(popViewControllerAnimated:)
         swizzledSelector:@selector(apmhook_popViewControllerAnimated:)];
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
    [ZMMobClick eventScreenOutCurrentScreen:[APMTools getCurrentViewControllerName]];
    
//    [FileWriter writeDic:dic];
}

- (void)apmhook_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
//    [self recordNav:[NSString stringWithFormat:@"Push To %@",[viewController class]]];
    [self recordNav:[NSString stringWithFormat:@"%@",[viewController class]]];
    if ([self respondsToSelector:@selector(apmhook_pushViewController:animated:)]) {
        [self apmhook_pushViewController:viewController animated:animated];
    }
}

- (void)apmhook_popViewControllerAnimated:(BOOL)animated {
    
//    [self recordNav:@"POP ViewController"];[APMTools getCurrentViewControllerName]
    [self recordNav:[NSString stringWithFormat:@"%@",[APMTools getCurrentViewControllerName]]];
    if ([self respondsToSelector:@selector(apmhook_popViewControllerAnimated:)]) {
        [self apmhook_popViewControllerAnimated:animated];
    }
}


@end
