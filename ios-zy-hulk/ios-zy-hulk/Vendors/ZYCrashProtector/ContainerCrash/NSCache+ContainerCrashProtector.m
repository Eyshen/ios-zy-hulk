//
//  NSCache+ContainerCrashProtector.m
//  WJCrashProtector-example
//
//  Created by ada on 2019/3/11.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSCache+ContainerCrashProtector.h"

@implementation NSCache (ContainerCrashProtector)

+ (void)enabledCacheCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        
    });
}

@end
