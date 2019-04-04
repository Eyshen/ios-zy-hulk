//
//  NSMutableString+ContainerCrashProtector.m
//  WJCrashProtector-example
//
//  Created by ada on 2019/3/11.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSMutableString+ContainerCrashProtector.h"

@implementation NSMutableString (ContainerCrashProtector)

+ (void)enabledMutableStringCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

@end
