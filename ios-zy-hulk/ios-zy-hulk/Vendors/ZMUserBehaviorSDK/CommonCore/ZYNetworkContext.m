//
//  ZYNetworkContext.m
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

#import "ZYNetworkContext.h"
#import "ZYNetworkContextConfig.h"

@implementation ZYNetworkContext

DEF_SINGLETON_INIT(ZYNetworkContext)

-(BOOL)isConnection {
    return [self currentStatus] != AFNetworkReachabilityStatusUnknown;
}

-(AFNetworkReachabilityStatus) currentStatus {
    return [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
}

-(void) addNotification:(id) target selector:(SEL) selector {
    if (target != nil && selector != NULL) {
        [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:AFNetworkingReachabilityDidChangeNotification object:nil];
    }
}
-(void) removeNotification:(id)target {
    if (target) {
        [[NSNotificationCenter defaultCenter] removeObserver:target name:AFNetworkingReachabilityDidChangeNotification object:nil];
    }
}

-(void)singleInit {
    NSString *host = [[ZYNetworkContextConfig sharedInstance] serverHost];
    
    if (host) {
        AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager managerForDomain:host];
        [reachability startMonitoring];
    } else {
        AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
        [reachability startMonitoring];
    }
}


@end
