//
//  NSAttributedString+ContainerCrashProtector.m
//  WJCrashProtector-example
//
//  Created by ada on 2019/3/11.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSAttributedString+ContainerCrashProtector.h"

@implementation NSAttributedString (ContainerCrashProtector)

+ (void)enabledAttributedStringCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

@end
