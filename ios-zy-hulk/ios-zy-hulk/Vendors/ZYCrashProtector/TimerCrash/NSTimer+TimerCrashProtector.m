//
//  NSTimer+TimerCrashProtector.m
//  WJAppContext-example
//
//  Created by ada on 2019/3/1.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSTimer+TimerCrashProtector.h"
#import "WJRuntimeUtils.h"


@interface WJTimerTargetProxy : NSProxy

@property(nonatomic, weak) id target;

+ (instancetype)proxyWithTarget:(id)target;

@end

@implementation WJTimerTargetProxy

+ (instancetype)proxyWithTarget:(id)target {
    WJTimerTargetProxy *proxy = [WJTimerTargetProxy alloc];
    [proxy setTarget:target];
    return proxy;
}

-(Class)class {
    return [_target class];
}

-(Class)superclass {
    return [_target superclass];
}

- (BOOL)isProxy {
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end


@implementation NSTimer (TimerCrashProtector)

+(void)enabledTimerCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WJRuntimeUtils swizzleClassMethodWithClass:[NSTimer class] orginalMethod:@selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) replaceMethod:@selector(cp_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:)];
        [WJRuntimeUtils swizzleClassMethodWithClass:[NSTimer class] orginalMethod:@selector(timerWithTimeInterval:invocation:repeats:) replaceMethod:@selector(cp_timerWithTimeInterval:target:selector:userInfo:repeats:)];
    });
}

+ (NSTimer *)cp_scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats {
    return [NSTimer cp_scheduledTimerWithTimeInterval:timeInterval target:[WJTimerTargetProxy proxyWithTarget:target] selector:selector userInfo:userInfo repeats:repeats];
}

+ (NSTimer *)cp_timerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    return [NSTimer cp_timerWithTimeInterval:timeInterval target:[WJTimerTargetProxy proxyWithTarget:target] selector:aSelector userInfo:userInfo repeats:yesOrNo];
}

@end
