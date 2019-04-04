//
//  NSString+ContainerCrashProtector.m
//  WJCrashProtector-example
//
//  Created by ada on 2019/3/11.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSString+ContainerCrashProtector.h"

@implementation NSString (ContainerCrashProtector)

+ (void)enabledStringCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        substringFromIndex:
//        substringToIndex:
//        substringWithRange:
//        characterAtIndex:
//        stringByReplacingOccurrencesOfString:withString:options:range:
//        stringByReplacingCharactersInRange:withString:
        
        
    });
}



@end

