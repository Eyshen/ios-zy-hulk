//
//  BaseZYHttpEngine.h
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

#import <Foundation/Foundation.h>
#import "IZYHttpEngine.h"
#import "IZYHttpFilter.h"
#import "IZYHttpRequest.h"
#import "IZYHttpResponse.h"
#import "ZYHttpFilterCore.h"
#import "ZYLoggingMacros.h"
/**
 *  HTTP 引擎基类
 *  不要直接使用此类（要继承）
 */
@interface BaseZYHttpEngine : NSObject

@property (nonatomic, copy) ZYHttpEngineResponseBlock resBlock;
@property (nonatomic, copy) ZYHttpEngineNativeResponseBlock nativeResBlock;

@property (nonatomic, copy) ZYHttpEngineDownloadResponseBlock downloadResBlock;
@property (nonatomic, copy) ZYHttpEngineProgressBlock progressBlock;

@property (atomic, assign) BOOL loading;//是否在加载中
@end
