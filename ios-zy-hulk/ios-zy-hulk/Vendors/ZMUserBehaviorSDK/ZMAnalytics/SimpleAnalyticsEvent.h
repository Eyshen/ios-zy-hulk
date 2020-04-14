//
//  SimpleAnalyticsEvents.h
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
#import "IAnalyticsEvent.h"
#import "ZYUUIDUtils.h"
#import "ZMEventInfoDto.h"
#import "ZMScreenInfoDto.h"

@interface SimpleAnalyticsEvent : NSObject<IAnalyticsEvent>

//类型
@property(nonatomic, copy) NSString *type;

//事件类型(1页面  2事件)
@property(nonatomic, copy) NSString *statType;

///////////////////////////////////////////////////////////

@property(nonatomic, strong) ZMScreenInfoDto *screenInfo;

//进入页面信息事件
+(instancetype)generationEnterScreenEvent:(NSString*)statType screenName:(NSString*)screenName preScreenName:(NSString*)preScreenName DescInfo:(NSDictionary*)DescInfo descType:(int)descType;

//离开页面信息事件
+(instancetype)generationLeaveScreenEvent:(NSString*)statType screenName:(NSString*)screenName preScreenName:(NSString*)preScreenName DescInfo:(NSDictionary*)DescInfo descType:(int)descType;

//Crash页面信息事件
+(instancetype)generationCrashScreenEvent:(NSString*)statType screenName:(NSString*)screenName preScreenName:(NSString*)preScreenName DescInfo:(NSDictionary*)DescInfo descType:(int)deAPPscType;

//离开APP页面信息事件
+(instancetype)generationLeaveAPPScreenEvent:(NSString*)statType screenName:(NSString*)screenName preScreenName:(NSString*)preScreenName DescInfo:(NSDictionary*)DescInfo descType:(int)descType;

///////////////////////////////////////////////////////////

@property(nonatomic, copy) ZMEventInfoDto *eventInfo;

//单点事件
+(instancetype)generationPointEvent:(NSString*)eventCode screenName:(NSString*)screenName eventParam:(NSDictionary *)eventParam;


//过程事件
+(instancetype)generationProcessEvent:(NSString*)eventCode eventStage:(int)eventStage processStep:(int)processStep processCode:(NSString *)processCode screenName:(NSString *)screenName eventParam:(NSDictionary *)eventParam;

//绑定事件
+(instancetype)generationBindingPointEvent:(NSString*)eventCode screenName:(NSString*)screenName eventParam:(NSDictionary *)eventParam;

///////////////////////////////////////////////////////////

//事件唯一id
@property(nonatomic, copy) NSString *uuid;

//用户id
@property(nonatomic, copy) NSString *uid;

//时间戳
@property(nonatomic, copy) NSString *time;

//eventId
@property(nonatomic, copy) NSString *eventId;

//口令
//@property(nonatomic, copy) NSString *token;

+(instancetype)generationLocationEvent:(double)lat lng:(double)lng;//lat 纬度  lng经度


@property(nonatomic, copy) NSNumber *lat;

@property(nonatomic, copy) NSNumber *lng;


+(instancetype)generationDeviceEvent:(NSString*)name type:(NSString*)type os:(NSString*)os size:(NSString*)size;


//设备名称
@property(nonatomic, copy) NSString *dName;//暂时不用

//设备类型
@property(nonatomic, copy) NSString *dType;//暂时不用

//设备系统号
@property(nonatomic, copy) NSString *dOS;//暂时不用

//屏幕大小
@property(nonatomic, copy) NSString *dSize;//暂时不用


+(instancetype)generationNetworkEvent:(NSString*)cxt;

@property(nonatomic, copy) NSString *cxt;


//时间收集
+(instancetype)generationEvent:(NSString*)eventId lab:(NSString*)lab atts:(NSDictionary*)atts duration:(int)duration;

//时间id
@property(nonatomic, copy) NSString *eId;

//时长
@property(nonatomic, copy) NSNumber *duration;

//分类标签
@property(nonatomic, copy) NSString *lab;

//事件附属参数
@property(nonatomic, copy) NSDictionary *atts;

@end
