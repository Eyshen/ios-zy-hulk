//
//  ZMAnalyticsConfig.m
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

#import "ZMAnalyticsConfig.h"

@implementation ZMAnalyticsConfig


+(instancetype)instanceWithUserId:(NSString *)userId andAppId:(NSString *)appId andAppCode:(NSString*)appCode policy:(ZMReportPolicy)policy {
    ZMAnalyticsConfig *config = [[ZMAnalyticsConfig alloc] init];
//    [config setAppKey:appKey];//暂时不用
    [config setUserId:userId];
    [config setAppCode:appCode];
    [config setAppId:appId];
    [config setPolicy:policy];
    return config;
}

-(NSString *)channelId {
    return @"AppStore";
}

@end
