//
//  KKMobClick.h
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
#import "ZMAnalyticsConfig.h"
#import "IAnalyticsDataStorage.h"

typedef NS_ENUM(NSInteger, ZMEventStageProcessEventEnum) {
    
    //聚合事件开始
    ZMEventStageProcessEventEnumBegin = 1,
    
    //聚合事件进行中
    ZMEventStageProcessEventEnumInprogress = 2,
    
    //聚合事件结束
    ZMEventStageProcessEventEnumFinish = 3,
    
};

/************************************************
 * 使用方法：
 * （1）在程序进入时调用 registerAppConfig:
 * （2）用户登录成功调用 userLogined: 注销调用 userLogout
 *
 *
 *************************************************/
@interface ZMMobClick : NSObject

//注册app
+ (void)registerAppConfig:(ZMAnalyticsConfig*)config dataStoreage:(id<IAnalyticsDataStorage>)dataStoreage;

//用户已注销操作
+ (void)userLogout;

//用户已登录操作
+ (void)userLogined:(NSString*)uid token:(NSString*)token;


//*************************************************/
//进入页面
+ (void)eventScreenInCurrentScreen:(NSString *)currentScreen;
//离开页面
+ (void)eventScreenOutCurrentScreen:(NSString *)currentScreen;
//Crash页面
+ (void)eventScreenCrashAppCurrentScreen:(NSString *)currentScreen;
//离开APP页面
+ (void)eventScreenLeaveAppCurrentScreen:(NSString *)currentScreen;
//*************************************************/
//单点事件
+ (void)pointEventCode:(NSString*)eventCode;

+ (void)pointEventCode:(NSString*)eventCode withEventParam:(NSDictionary *)eventParam;
//聚合事件
+ (void)processEventCode:(NSString*)eventCode eventStage:(ZMEventStageProcessEventEnum)eventStage processStep:(int)processStep processCode:(NSString *)processCode;

+ (void)processEventCode:(NSString*)eventCode eventStage:(ZMEventStageProcessEventEnum)eventStage processStep:(int)processStep processCode:(NSString *)processCode withEventParam:(NSDictionary *)eventParam;

//绑定事件
+ (void)bindingPointEventCode:(NSString*)eventCode;

+ (void)bindingPointEventCode:(NSString*)eventCode withEventParam:(NSDictionary *)eventParam;

//*************************************************/
//记录事件
+ (void)event:(NSString*)evnetId;

+ (void)event:(NSString*)evnetId label:(NSString*)label;

+ (void)event:(NSString*)evnetId label:(NSString*)label duration:(int)millisecond;

+ (void)event:(NSString*)evnetId label:(NSString*)label attributes:(NSDictionary *)attributes;

+ (void)event:(NSString*)evnetId attributes:(NSDictionary *)attributes;

+ (void)event:(NSString*)evnetId attributes:(NSDictionary *)attributes duration:(int)millisecond;

//+ (void)beginEvent:(NSString*)eventId;
//
//+ (void)endEvent:(NSString*)eventId;
//
//+ (void)beginEvent:(NSString*)eventId label:(NSString*)label;
//
//+ (void)endEvent:(NSString*)eventId label:(NSString*)label;

//位置信息发生改变 暂时不用
+ (void)setLocationLng:(double)lng lat:(double)lat;

@end
