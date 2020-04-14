//
//  MsgBodyDTO.m
//  ZMAnalytics-example
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
//  Created by Eason on 19/10/23.
//  Copyright (c) 2019年 张一. All rights reserved.
//

#import "MsgBodyDTO.h"
#import "ZYUUIDUtils.h"
#import "ZYStringUtils.h"
#import "MsgCommonInfoDto.h"

#define SDK_VERSION     @"1.0.0"

@implementation MsgBodyDTO

-(instancetype)initWithAppCode:(NSString*)appCode userId:(NSString *)userId channel:(NSString*)channel appId:(NSString *)appId dcode:(NSString*)dcode {
    self = [super init];
    if (self) {
        self.appCode = appCode;
        MsgCommonInfoDto *info = [[MsgCommonInfoDto alloc]init];
        info.reqId = [ZYUUIDUtils UUID];
        if([ZYStringUtils isNotEmpty:userId]){
            info.userId = userId;
        }
        info.deviceId = dcode;
        info.channelId = channel;
        info.sdkVersion = SDK_VERSION;
        info.appId = appId;
        info.platform = @"iOS";
        info.occurTime = [NSString stringWithFormat:@"%lli",(long long)[[NSDate date] timeIntervalSince1970]*1000];
        
#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR || TARGET_OS_IPAD || TARGET_OS_MAC || TARGET_IPAD_SIMULATOR)
        info.appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
#else    // #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
        self.appVersion = nil;
#endif   // #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
        self.commonInfo = info;
    }
    return self;
}

@end
