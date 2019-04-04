//
//  ZYCrashProtectorManager.h
//  ZYCrashProtector-example
//     _______________      __
//    /\______   /  \ \    / /
//    \/___  /  /    \ \  / /
//        / /  /      \ \/ /
//       / /  /        \/ /
//      / /  /______   / /
//     / /__________\ / /
//    /_____________/ \/
//
//  Created by Eason on 2019/3/11.
//  Copyright © 2019年 ZY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

//category
#import "NSArray+ContainerCrashProtector.h"


//define
#import "ZYCrashStuProxy.h"

typedef NS_OPTIONS(NSInteger, ZYCrashProtectorType) {
    ZYCrashProtectorTypeNone                        = 0,
    ZYCrashProtectorTypeAll                         = 1 << 0,
    ZYCrashProtectorTypeUnrecognizedSelector        = 1 << 1,
    ZYCrashProtectorTypeKVO                         = 1 << 2,
    ZYCrashProtectorTypeString                      = 1 << 3,
    ZYCrashProtectorTypeContainer                   = 1 << 4,
    ZYCrashProtectorTypeTimer                       = 1 << 5,
    ZYCrashProtectorTypeNotification                = 1 << 6,
};


/**
 崩溃防护器管理
 */
@interface ZYCrashProtectorManager : NSObject

/**
 开启防护器
 注意：首次调用有效
 */
+ (void)enabledCrashProtector:(ZYCrashProtectorType)types;

+ (void)becomeEffective;

+ (void)makeAllEffective;

+ (void)setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings;

+ (void)setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs;
@end
