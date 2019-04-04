//
//  NSArray+ContainerCrashProtector.m
//  WJCrashProtector-example
//
//  Created by ada on 2019/3/11.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSArray+ContainerCrashProtector.h"
#import "WJRuntimeUtils.h"

@implementation NSArray (ContainerCrashProtector)

+ (void)enabledArrayCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class arrayClass = objc_getClass("NSArray");
        Class arrayIClass = objc_getClass("__NSArrayI");
        Class singleObjectArrayIClass = objc_getClass("__NSSingleObjectArrayI");
        Class array0Class = objc_getClass("__NSArray0");
        
    });
}

@end
