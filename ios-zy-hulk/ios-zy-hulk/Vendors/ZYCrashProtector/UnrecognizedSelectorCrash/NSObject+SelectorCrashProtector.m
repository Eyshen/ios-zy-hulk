//
// NSObject+SelectorCrashProtector.m
//  WJCrashProtector-example
//
//  Created by ada on 2019/3/11.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSObject+SelectorCrashProtector.h"
#import "WJRuntimeUtils.h"

@implementation NSObject (SelectorCrashProtector)


+ (void)enableSelectorCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

@end
