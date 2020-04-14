//
//  ZYStringUtils.m
//
//     _______________      __
//    /\______   /  \ \    / /
//    \/___  /  /    \ \  / /
//        / /  /      \ \/ /
//       / /  /        \/ /
//      / /  /______   / /
//     / /__________\ / /
//    /_____________/ \/
//
//  Created by Eason on 19/10/22.
//  Copyright (c) 2019年 张一. All rights reserved.
//

#import "ZYStringUtils.h"

@implementation ZYStringUtils

+(BOOL)isBlank:(NSString *)str {
    if (str == nil || [[str stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0) {
        return YES;
    }
    return NO;
}

+(BOOL)isNotBlank:(NSString *)str {
    return ![self isBlank:str];
}

+(BOOL)isEmpty:(NSString *)str {
    if ((NSNull*)str == [NSNull null] || str == nil || [self equal:@"null" str:str] || [self equal:@"(null)" str:str] || [[str stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0) {
        return YES;
    }
    return NO;
}

+(BOOL)isNotEmpty:(NSString *)str {
    return ![self isEmpty:str];
}

+(BOOL)equal:(NSString *)str1 str:(NSString *)str2 {
    if (str1 == str2 || [str1 isEqualToString:str2]) {
        return YES;
    }
    return NO;
}

+(NSArray *)split:(NSString *)str separator:(NSString *)separator {
    return [str componentsSeparatedByString:separator];
}

+(NSString *)join:(NSArray *)strs separator:(NSString *)separator {
    NSString *result = nil;
    if ([strs count] > 0 && separator) {
        result = [strs componentsJoinedByString:separator];
    }
    return result;
}

@end
