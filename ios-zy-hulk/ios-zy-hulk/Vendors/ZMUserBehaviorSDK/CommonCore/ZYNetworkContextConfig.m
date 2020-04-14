//
//  ZYNetworkContextConfig.m
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

#import "ZYNetworkContextConfig.h"

@implementation ZYNetworkContextConfig

DEF_SINGLETON(ZYNetworkContextConfig)


-(void)setCheckServerHost:(NSString *)host {
    if (host) {
        _serverHost = [host copy];
    }
}

@end
