//
//  NSMutableDictionary+ContainerCrashProtector.m
//  WJCrashProtector-example
//
//  Created by ada on 2019/3/11.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSMutableDictionary+ContainerCrashProtector.h"

@implementation NSMutableDictionary (ContainerCrashProtector)

+ (void)enabledMutableDictionaryCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

@end
