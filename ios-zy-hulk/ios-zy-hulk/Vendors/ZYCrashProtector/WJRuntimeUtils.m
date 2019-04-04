//
//  WJRuntimeUtils.m
//  WJAppContext-example
//
//  Created by ada on 2019/2/25.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "WJRuntimeUtils.h"

@implementation WJRuntimeUtils

+ (void)swizzleClassMethodWithClass:(Class _Nonnull)clazz orginalMethod:(SEL _Nonnull)origSelector replaceMethod:(SEL _Nonnull)replSelector {
    Method origMethod = class_getClassMethod(clazz, origSelector);
    Method replMeathod = class_getClassMethod(clazz, replSelector);
    Class metaClazz = objc_getMetaClass([NSStringFromClass(clazz) UTF8String]);
    
    BOOL addMethodResult = class_addMethod(metaClazz, origSelector, method_getImplementation(replMeathod), method_getTypeEncoding(replMeathod));
    if (addMethodResult) {
        class_replaceMethod(metaClazz, replSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else {
        method_exchangeImplementations(origMethod, replMeathod);
    }
}

+ (void)swizzleInstanceMethodWithClass:(Class _Nonnull)clazz orginalMethod:(SEL _Nonnull )origSelector replaceMethod:(SEL _Nonnull )replSelector {
    Method origMethod = class_getInstanceMethod(clazz, origSelector);
    Method replMeathod = class_getInstanceMethod(clazz, replSelector);
    
    BOOL addMethodResult = class_addMethod(clazz, origSelector, method_getImplementation(replMeathod), method_getTypeEncoding(replMeathod));
    if (addMethodResult) {
        class_replaceMethod(clazz, replSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }else {
        method_exchangeImplementations(origMethod, replMeathod);
    }
}

@end
