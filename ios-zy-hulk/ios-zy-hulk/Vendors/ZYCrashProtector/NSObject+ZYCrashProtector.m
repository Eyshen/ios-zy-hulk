//
//  NSObject+ZYCrashProtector.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/4/4.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "NSObject+ZYCrashProtector.h"
#import "ZYCrashProtectorManager.h"
#import "ZYCrashStuProxy.h"


@implementation NSObject (ZYCrashProtector)
+ (void)zyCrashExchangeMethodIfDealWithNoneSel:(BOOL)ifDealWithNoneSel {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //setValue:forKey:
        [ZYCrashProtectorManager exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forKey:) method2Sel:@selector(avoidCrashSetValue:forKey:)];
        
        //setValue:forKeyPath:
        [ZYCrashProtectorManager exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forKeyPath:) method2Sel:@selector(avoidCrashSetValue:forKeyPath:)];
        
        //setValue:forUndefinedKey:
        [ZYCrashProtectorManager exchangeInstanceMethod:[self class] method1Sel:@selector(setValue:forUndefinedKey:) method2Sel:@selector(avoidCrashSetValue:forUndefinedKey:)];
        
        //setValuesForKeysWithDictionary:
        [ZYCrashProtectorManager exchangeInstanceMethod:[self class] method1Sel:@selector(setValuesForKeysWithDictionary:) method2Sel:@selector(avoidCrashSetValuesForKeysWithDictionary:)];
        
        
        //unrecognized selector sent to instance
        if (ifDealWithNoneSel) {
            [ZYCrashProtectorManager exchangeInstanceMethod:[self class] method1Sel:@selector(methodSignatureForSelector:) method2Sel:@selector(avoidCrashMethodSignatureForSelector:)];
            [ZYCrashProtectorManager exchangeInstanceMethod:[self class] method1Sel:@selector(forwardInvocation:) method2Sel:@selector(avoidCrashForwardInvocation:)];
        }
    });
}


//=================================================================
//              unrecognized selector sent to instance
//=================================================================
#pragma mark - unrecognized selector sent to instance


static NSMutableArray *noneSelClassStrings;
static NSMutableArray *noneSelClassStringPrefixs;

+ (void)setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings {
    
    if (noneSelClassStrings) {
        
        NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringsArr:];\n调用一此即可，多次调用会自动忽略后面的调用\n\n%@\n\n",AvoidCrashSeparatorWithFlag,AvoidCrashSeparator];
        AvoidCrashLog(@"%@",warningMsg);
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noneSelClassStrings = [NSMutableArray array];
        for (NSString *className in classStrings) {
            if ([className hasPrefix:@"UI"] == NO &&
                [className isEqualToString:NSStringFromClass([NSObject class])] == NO) {
                [noneSelClassStrings addObject:className];
                
            } else {
                NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringsArr:];\n会忽略UI开头的类和NSObject类(请使用NSObject的子类)\n\n%@\n\n",AvoidCrashSeparatorWithFlag,AvoidCrashSeparator];
                AvoidCrashLog(@"%@",warningMsg);
            }
        }
    });
}

/**
 *  初始化一个需要防止”unrecognized selector sent to instance”的崩溃的类名前缀的数组
 */
+ (void)setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs {
    if (noneSelClassStringPrefixs) {
        
        NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringPrefixsArr:];\n调用一此即可，多次调用会自动忽略后面的调用\n\n%@\n\n",AvoidCrashSeparatorWithFlag,AvoidCrashSeparator];
        AvoidCrashLog(@"%@",warningMsg);
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        noneSelClassStringPrefixs = [NSMutableArray array];
        for (NSString *classNamePrefix in classStringPrefixs) {
            if ([classNamePrefix hasPrefix:@"UI"] == NO &&
                [classNamePrefix hasPrefix:@"NS"] == NO) {
                [noneSelClassStringPrefixs addObject:classNamePrefix];
                
            } else {
                NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringsArr:];\n会忽略UI开头的类和NS开头的类\n若需要对NS开头的类防止”unrecognized selector sent to instance”(比如NSArray),请使用setupNoneSelClassStringsArr:\n\n%@\n\n",AvoidCrashSeparatorWithFlag,AvoidCrashSeparator];
                AvoidCrashLog(@"%@",warningMsg);
            }
        }
    });
}

@end
