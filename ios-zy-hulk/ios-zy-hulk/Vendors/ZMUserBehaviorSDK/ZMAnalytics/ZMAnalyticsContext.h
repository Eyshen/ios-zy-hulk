//
//  ZMAnalyticsContext.h
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

//#import <ZYCommon/ZYCommon.h>
#import "AbstractZYBusinessObject.h"
#import "ZMSingleton.h"
#import "IAnalyticsEvent.h"
#import "ZMAnalyticsConfig.h"
#import "IAnalyticsDataStorage.h"

@interface ZMAnalyticsContext : AbstractZYBusinessObject

AS_SINGLETON(ZMAnalyticsContext)

@property(nonatomic, copy) NSString *uid;

@property(nonatomic, copy) NSString *token;//暂时用不到

@property(nonatomic, copy) NSString *inOccurTime;//页面进入时间戳

@property(nonatomic, copy) NSString *outOccurTime;//页面离开时间戳

@property(nonatomic, copy) NSString *stagingScreenName;//暂存页面名

@property(nonatomic, strong) NSMutableDictionary *processContextData;//过程事件 processEventId存储


//发送事件
-(void)publish:(id<IAnalyticsEvent>)event;


- (void)registerAppConfig:(ZMAnalyticsConfig*)config dataStoreage:(id<IAnalyticsDataStorage>)dataStoreage;


@end
