//
//  ZYNetworkContextConfig.h
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

/**
 *  网络环境配置
 */
@interface ZYNetworkContextConfig : AbstractZYBusinessObject

/**
 *  检测是否已联网host
 *  default www.baidu.com
 */
@property (nonatomic, copy, readonly) NSString *serverHost;

AS_SINGLETON(ZYNetworkContextConfig)

-(void) setCheckServerHost:(NSString*) host;

@end
