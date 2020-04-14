//
//  WJHttpEngineConfig.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by Yunhai.Wu on 15/12/25.
//  Copyright © 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractZYBusinessObject.h"
#import "ZMSingleton.h"

/**
 *  ZYHttpEngine 网络HTTP请求组件配置
 */
@interface ZYHttpEngineConfig : AbstractZYBusinessObject

AS_SINGLETON(ZYHttpEngineConfig)

/**
 *  默认超时时长(秒)
 *  default 60
 */
@property (nonatomic, assign, readonly) int defaultTimeoutDuration;

/**
 *  HTTP 默认引擎名称
 *  ASIZYHttpEngine、AFZYHttpEngine
 *  default AFZYHttpEngine
 */
@property (nonatomic, copy) NSString *defaultEngineName;

/**
 *  http请求时是否默认打开状态栏网络活跃标识
 *  default YES
 *  还可以在IZYHttpRequest 实现中实现方法 hideNetworkActivityIndicator 方法针对每个Request修改
 */
@property (nonatomic, assign, readonly) BOOL defaultNetworkActivityEnabled;

/**
 *  是否允许无效证书
 *  Default：NO
 */
@property (nonatomic, assign) BOOL allowInvalidCertificates;


-(void) setTimeoutDuration:(int) timeoutDuration;

-(void) setNetworkActivityEnabled:(BOOL) enabled;

-(void) addFilter:(Class) filterClazz;

/**
 *  过滤器列表
 */
-(NSArray*) filters;

/**
 *  添加证书(只可以添加cer证书)
 */
-(void) addCertificater:(NSString*) path;

/**
 *  证书列表
 */
-(NSArray*) certificatesPaths;

@end
