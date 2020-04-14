//
//  ZYHttpFactory.m
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

#import "ZYHttpFactory.h"
#import "ZYLoggingMacros.h"
#import "ZYHttpEngineConfig.h"


@implementation ZYHttpFactory

+(id<IZYHttpEngine>)buildHttpEngine {
    id<IZYHttpEngine> httpEngine = nil;
    NSString *engineClazzName = [[ZYHttpEngineConfig sharedInstance] defaultEngineName];
    Class engineClazz = NSClassFromString(engineClazzName);
    if (engineClazz) {
        if ([engineClazz conformsToProtocol:@protocol(IZYHttpEngine)]) {
            httpEngine = [[engineClazz alloc] init];
            ZYLogDebug(@"构建 %@",NSStringFromClass(engineClazz));
        } else {
            NSString *reason = [NSString stringWithFormat:@"%@ 没有实现协议 IWJHttpEngine",engineClazzName];
            ZYLogError(reason);
            @throw [NSException exceptionWithName:@"ZYHttpFactoryException" reason:reason userInfo:nil];
        }
    } else {
        NSString *reason = [NSString stringWithFormat:@"%@ 不是有效的 HTTP 引擎,请在ZYHttpEngineConfig 中配置",engineClazzName];
        @throw [NSException exceptionWithName:@"ZYHttpFactoryException" reason:reason userInfo:nil];
        ZYLogError(reason);
    }
    return httpEngine;
}

@end
