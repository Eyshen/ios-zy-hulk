//
//  NSObject+KVOCrashProtector.m
//  WJAppContext-example
//
//  Created by ada on 2019/2/26.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "NSObject+KVOCrashProtector.h"
#import "WJRuntimeUtils.h"

@interface KVOCrashProtectorInfo : NSObject

@property(nonatomic, strong) NSMutableDictionary *kvoInfoMap;

-(NSMutableArray*)getObserversForKeyPath:(NSString*)keyPath;

@end

@implementation KVOCrashProtectorInfo

-(NSMutableArray *)getObserversForKeyPath:(NSString *)keyPath {
    NSMutableArray *observers = _kvoInfoMap[keyPath];
    if (!observers) {
        observers = [[NSMutableArray alloc] init];
        self.kvoInfoMap[keyPath] = observers;
    }
    return observers;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.kvoInfoMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end

@implementation NSObject (KVOCrashProtector)

+(void)enableKVOCrashProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [WJRuntimeUtils swizzleInstanceMethodWithClass:[NSObject class] orginalMethod:@selector(addObserver:forKeyPath:options:context:) replaceMethod:@selector(cp_addObserver:forKeyPath:options:context:)];
        [WJRuntimeUtils swizzleInstanceMethodWithClass:[NSObject class] orginalMethod:@selector(removeObserver:forKeyPath:) replaceMethod:@selector(cp_removeObserver:forKeyPath:)];
    });
}

-(KVOCrashProtectorInfo*)kvoCrashProtectorInfo {
    KVOCrashProtectorInfo *info = objc_getAssociatedObject(self, @selector(kvoCrashProtectorInfo));
    if (!info) {
        info = [[KVOCrashProtectorInfo alloc] init];
        [self setKVOCrashProtectorInfo:info];
    }
    return info;
}

-(void)setKVOCrashProtectorInfo:(KVOCrashProtectorInfo*)info {
    objc_setAssociatedObject(self, @selector(kvoCrashProtectorInfo), info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cp_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    KVOCrashProtectorInfo *info = [self kvoCrashProtectorInfo];
    NSMutableArray *observerList = [info getObserversForKeyPath:keyPath];
    if (![observerList containsObject:observer]) {
        [observerList addObject:observer];
        [self cp_addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

- (void)cp_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    KVOCrashProtectorInfo *info = [self kvoCrashProtectorInfo];
    NSMutableArray *observerList = [info getObserversForKeyPath:keyPath];
    if ([observerList containsObject:observer]) {
        [self cp_removeObserver:observer forKeyPath:keyPath];
        [observerList removeObject:observer];
    }
}

@end
