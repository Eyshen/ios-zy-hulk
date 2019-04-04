//
//  NSObject+NotificationCrashProtector.m
//  WJAppContext-example
//
//  Created by ada on 2019/2/26.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSObject+NotificationCrashProtector.h"
#import "WJRuntimeUtils.h"

@implementation NSObject (NotificationCrashProtector)

+(void)enabledNotificationCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WJRuntimeUtils swizzleInstanceMethodWithClass:[NSObject class] orginalMethod:@selector(addObserver:selector:name:object:) replaceMethod:@selector(cp_addObserver:selector:name:object:)];
        [WJRuntimeUtils swizzleInstanceMethodWithClass:[NSObject class] orginalMethod:NSSelectorFromString(@"dealloc") replaceMethod:NSSelectorFromString(@"cp_dealloc")];
    });
}

-(void)setNeedRemoveObserver:(BOOL)needRemoveObserver  {
    objc_setAssociatedObject(self, @selector(isNeedRemoveObserver), @(needRemoveObserver), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isNeedRemoveObserver {
    return [(NSNumber*)objc_getAssociatedObject(self, @selector(isNeedRemoveObserver)) boolValue];
}

-(void)cp_dealloc {
    if ([self isNeedRemoveObserver]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self cp_dealloc];
}

-(void)cp_addObserver:(id)observer selector:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject {
    [self setNeedRemoveObserver:YES];
    [self cp_addObserver:observer selector:aSelector name:aName object:anObject];
}


@end
