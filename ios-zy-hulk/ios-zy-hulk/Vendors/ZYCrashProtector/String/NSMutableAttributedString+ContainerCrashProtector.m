//
//  NSMutableAttributedString+ContainerCrashProtector.m
//  WJCrashProtector-example
//
//  Created by ada on 2019/3/11.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSMutableAttributedString+ContainerCrashProtector.h"

@implementation NSMutableAttributedString (ContainerCrashProtector)

+ (void)enabledMutableAttributedStringCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}

@end
