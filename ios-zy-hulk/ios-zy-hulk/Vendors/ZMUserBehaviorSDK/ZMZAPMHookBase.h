//
//  HookBase.h
//  ZMLog
//
//  Created by jun2 on 2019/5/7.
//  Copyright © 2019 jun2. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMZAPMHookBase : NSObject

+ (void)hookClass:(Class)classObject
 originalSelector:(SEL)originalSelector
 swizzledSelector:(SEL)swizzledSelector;

+ (void)hookClassOut:(Class)targetClass
        currentClass:(Class)currentClass
    originalSelector:(SEL)originalSelector
    swizzledSelector:(SEL)swizzledSelector;

+ (void)hookClassSelectorOut:(Class)targetClass
                currentClass:(Class)currentClass
            originalSelector:(SEL)originalSelector
            swizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
