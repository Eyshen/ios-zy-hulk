//
//  WJRuntimeUtils.h
//  WJAppContext-example
//
//  Created by ada on 2019/2/25.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface WJRuntimeUtils : NSObject

+ (void)swizzleClassMethodWithClass:(Class _Nonnull )clazz orginalMethod:(SEL _Nonnull )origSelector replaceMethod:(SEL _Nonnull )replSelector;

+ (void)swizzleInstanceMethodWithClass:(Class _Nonnull)clazz orginalMethod:(SEL _Nonnull )origSelector replaceMethod:(SEL _Nonnull )replSelector;

@end
