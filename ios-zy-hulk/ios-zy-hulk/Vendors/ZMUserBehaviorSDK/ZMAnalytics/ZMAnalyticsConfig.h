//
//  ZMAnalyticsConfig.h
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

#import <Foundation/Foundation.h>
//#import "BaseZYObject.h"

typedef NS_ENUM(NSInteger, ZMReportPolicy) {
    
    //实时发送
    ZMReportPolicyRealTime = 0,
    
    //启动时发送
    ZMReportPolicyBatch = 1,
    
    //混合策略（启动时发送+累计10条发送）
    ZMReportPolicyHybrid = 2,
    
};


@interface ZMAnalyticsConfig : NSObject

@property(nonatomic, copy) NSString *appCode;//app注册ID

@property(nonatomic, copy) NSString *appKey;//app注册key

@property(nonatomic, copy) NSString *userId;//用户id

@property(nonatomic, copy) NSString *appId;//appId

@property(nonatomic, copy, readonly) NSString *channelId;//渠道ID

@property(nonatomic, assign) ZMReportPolicy policy;


+(instancetype)instanceWithUserId:(NSString *)userId andAppId:(NSString *)appId andAppCode:(NSString*)appCode policy:(ZMReportPolicy)policy;

@end
