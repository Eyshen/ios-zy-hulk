//
//  UIControl+UIControl_XY.m
//  iOSanimation
//
//  Created by biyabi on 15/9/29.
//  Copyright © 2015年 caijunrong. All rights reserved.
//

#import "UIControl-ZMAPMHook.h"
#import "ZMZAPMHookBase.h"
#import "ZMFileWriter.h"
#import "ZMAPM.h"
#import "APMTools.h"

@implementation UIControl (ZMAPMHook)

+ (void)apmHook {
    [ZMZAPMHookBase hookClass:self originalSelector:@selector(sendAction:to:forEvent:) swizzledSelector:@selector(APMHook_sendAction:to:forEvent:)];
}

- (void)recordTap:(NSString *)params {
    NSDictionary *dic = @{@"time":[ZMAPM getTime],
                          @"counter":[[ZMAPM sharedInstance] getCounter],
                          @"type":@"button",
                          @"viewcontroller":[APMTools getCurrentViewControllerName],
                          @"value":@"",
                          @"param":params,
                          @"resq":@"",
                          @"resp":@"",
                          @"stacks":@""
                          };
    NSLog(@"点击事件:%@",dic);
//    [FileWriter writeDic:dic];
}

- (void)APMHook_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    [self recordTap:[NSString stringWithFormat:@"%@，%@",[target class],NSStringFromSelector(action)]];
    
    if ([self respondsToSelector:@selector(APMHook_sendAction:to:forEvent:)]) {
        [self APMHook_sendAction:action to:target forEvent:event];
    }
}

@end
