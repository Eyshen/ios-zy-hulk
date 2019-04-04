//
//  NSMutableArray+ContainerCrashProtector.m
//  WJCrashProtector-example
//
//  Created by ada on 2019/3/11.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSMutableArray+ContainerCrashProtector.h"

@implementation NSMutableArray (ContainerCrashProtector)

+ (void)enabledMutableArrayCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

@end
