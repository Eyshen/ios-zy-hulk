//
//  ZYHTTPSessionManager.h
//  ZYHttpEngineAF-example
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

#import "AbstractZYBusinessObject.h"
#import "ZMSingleton.h"
#import "AFHTTPSessionManager.h"

/**
 *  AFHTTPSessionManager 管理
 */
@interface ZYHTTPSessionManagerStorage : AbstractZYBusinessObject

AS_SINGLETON(ZYHTTPSessionManagerStorage)

/**
 *  最大并发数(default 5)
 */
-(void) setMaxConcurrentCount:(NSInteger) concurrentCount;

-(AFHTTPSessionManager*) defaultSessionManager;

@end
