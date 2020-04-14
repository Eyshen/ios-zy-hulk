//
//  SimpleAnalyticsEvents.m
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

#import "SimpleAnalyticsEvent.h"
#import "ZMAnalyticsContext.h"
#import "ZYStringUtils.h"
#import "ZMScreenInfoDto.h"


@implementation SimpleAnalyticsEvent

static NSString *currentEventId = nil;

+(void)initialize {
    currentEventId = [[ZYUUIDUtils UUID] copy];
}

-(instancetype)init {
    self = [super init];
    if (self) {
        self.time = [NSString stringWithFormat:@"%lli",(long long)[[NSDate date] timeIntervalSince1970]*1000];
        self.uuid = [[ZYUUIDUtils UUID] copy];
        self.eventId = currentEventId;
//        self.token = [[ZMAnalyticsContext sharedInstance] token];
        self.uid = [[ZMAnalyticsContext sharedInstance] uid];
    }
    return self;
}
///////////////////////////////////////////////////////////
//进入页面信息事件
+(instancetype)generationEnterScreenEvent:(NSString*)statType screenName:(NSString*)screenName preScreenName:(NSString*)preScreenName DescInfo:(NSDictionary*)DescInfo descType:(int)descType{
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    e.statType = @"1";
    ZMScreenInfoDto *info = [[ZMScreenInfoDto alloc]init];
    
    info.screenType = @"1";
    info.screenName = screenName?:@"";
    NSString * preScreenNameStr = [ZMAnalyticsContext sharedInstance].stagingScreenName;
    if([ZYStringUtils isNotEmpty:preScreenNameStr]){
        info.preScreenName = preScreenNameStr;
    }else{
        info.preScreenName = @"";
    }
    [ZMAnalyticsContext sharedInstance].stagingScreenName = screenName;
    
    NSString*outOccurTime = [ZMAnalyticsContext sharedInstance].outOccurTime;
    NSString *duration = @"0";
    NSString *currentTime = [NSString stringWithFormat:@"%lli",(long long)[[NSDate date] timeIntervalSince1970]*1000];
    if([ZYStringUtils isNotEmpty:outOccurTime]){
        long long time = [currentTime longLongValue]-[outOccurTime longLongValue];
        duration = [NSString stringWithFormat:@"%lli",time];
    }
    info.screenIn =@{@"occurTime":currentTime,
                             @"duration":duration
                             };
    
    //info
    e.screenInfo = info;
    [[ZMAnalyticsContext sharedInstance] setInOccurTime:currentTime];
    return e;
}
//离开页面信息事件
+(instancetype)generationLeaveScreenEvent:(NSString*)statType screenName:(NSString*)screenName preScreenName:(NSString*)preScreenName DescInfo:(NSDictionary*)DescInfo descType:(int)descType{
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    e.statType = @"1";
    ZMScreenInfoDto *info = [[ZMScreenInfoDto alloc]init];
    info.screenType = @"1";
    info.screenName = screenName?:@"";
    NSString * preScreenNameStr = [ZMAnalyticsContext sharedInstance].stagingScreenName;
    if([ZYStringUtils isNotEmpty:preScreenNameStr]){
        info.preScreenName = preScreenNameStr;
    }else{
        info.preScreenName = @"";
    }
    [ZMAnalyticsContext sharedInstance].stagingScreenName = screenName;
    
    NSString*inOccurTime = [ZMAnalyticsContext sharedInstance].inOccurTime;
    NSString *duration = @"0";
    NSString *currentTime = [NSString stringWithFormat:@"%lli",(long long)[[NSDate date] timeIntervalSince1970]*1000];
    if([ZYStringUtils isNotEmpty:inOccurTime]){
        long long time = [currentTime longLongValue]-[inOccurTime longLongValue];
        duration = [NSString stringWithFormat:@"%lli",time];
    }
    info.screenOut =@{@"occurTime":currentTime,
                      @"duration":duration
                             };
    e.screenInfo = info;
    [[ZMAnalyticsContext sharedInstance] setOutOccurTime:currentTime];
    return e;
}

//Crash页面信息事件
+(instancetype)generationCrashScreenEvent:(NSString*)statType screenName:(NSString*)screenName preScreenName:(NSString*)preScreenName DescInfo:(NSDictionary*)DescInfo descType:(int)deAPPscType{
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    e.statType = @"1";
    e.screenInfo.screenType = @"1";
    e.screenInfo.screenName = screenName?:@"";
    NSString * preScreenNameStr = [ZMAnalyticsContext sharedInstance].stagingScreenName;
    if([ZYStringUtils isNotEmpty:preScreenNameStr]){
        e.screenInfo.preScreenName = preScreenNameStr;
    }else{
        e.screenInfo.preScreenName = @"";
    }
    [ZMAnalyticsContext sharedInstance].stagingScreenName = screenName;
    
    NSString*inOccurTime = [ZMAnalyticsContext sharedInstance].inOccurTime;
    NSString *duration = @"0";
    NSString *currentTime = [NSString stringWithFormat:@"%lli",(long long)[[NSDate date] timeIntervalSince1970]*1000];
    if([ZYStringUtils isNotEmpty:inOccurTime]){
        long long time = [currentTime longLongValue]-[inOccurTime longLongValue];
        duration = [NSString stringWithFormat:@"%lli",time];
    }
    e.screenInfo.screenOut =@{@"occurTime":currentTime,
                              @"duration":duration
                              };
    
    [[ZMAnalyticsContext sharedInstance] setOutOccurTime:currentTime];
    return e;
}

//离开APP页面信息事件
+(instancetype)generationLeaveAPPScreenEvent:(NSString*)statType screenName:(NSString*)screenName preScreenName:(NSString*)preScreenName DescInfo:(NSDictionary*)DescInfo descType:(int)descType{
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    e.statType = @"1";
    ZMScreenInfoDto *info = [[ZMScreenInfoDto alloc]init];
    info.screenType = @"1";
    info.screenName = screenName?:@"";
    NSString * preScreenNameStr = [ZMAnalyticsContext sharedInstance].stagingScreenName;
    if([ZYStringUtils isNotEmpty:preScreenNameStr]){
        info.preScreenName = preScreenNameStr;
    }else{
        info.preScreenName = @"";
    }
    [ZMAnalyticsContext sharedInstance].stagingScreenName = screenName;
    NSString *currentTime = [NSString stringWithFormat:@"%lli",(long long)[[NSDate date] timeIntervalSince1970]*1000];
    info.appOut =@{@"occurTime":currentTime,
                           };
    e.screenInfo = info;
    return e;
}

///////////////////////////////////////////////////////////

//单点事件
+(instancetype)generationPointEvent:(NSString*)eventCode screenName:(NSString*)screenName eventParam:(NSDictionary *)eventParam{
    
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    e.statType = @"2";
    
    ZMEventInfoDto *info = [[ZMEventInfoDto alloc]init];
    info.eventId = [ZYUUIDUtils UUID];
    info.eventType = ZMEventTypePoint;
    info.eventCode = eventCode;
    info.eventStage = 0;
    info.screenName = screenName?:@"";
    NSString *currentTime = [NSString stringWithFormat:@"%lli",(long long)[[NSDate date] timeIntervalSince1970]*1000];
    info.occurTime = currentTime;
    info.eventParam = eventParam;
    
    e.eventInfo = info;
    return e;
}


//过程事件
+(instancetype)generationProcessEvent:(NSString*)eventCode eventStage:(int)eventStage processStep:(int)processStep processCode:(NSString *)processCode screenName:(NSString *)screenName eventParam:(NSDictionary *)eventParam{
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    e.statType = @"2";
    
    ZMEventInfoDto *info = [[ZMEventInfoDto alloc]init];
    NSString *currentTime = [NSString stringWithFormat:@"%lli",(long long)[[NSDate date] timeIntervalSince1970]*1000];
    NSString *uuidStr = [ZYUUIDUtils UUID];
    info.eventId = uuidStr;
    info.eventType = ZMEventTypeProgress;
    info.processCode = processCode;
    info.eventStage = eventStage;
    info.processStep = processStep;
    if(eventStage == 1){
        info.processEventId = uuidStr;
        info.slotDuration = @"0";
        NSMutableDictionary *processInfo = [[NSMutableDictionary alloc]init];
        [processInfo setObject:uuidStr forKey:@"processEventId"];
        [processInfo setObject:currentTime forKey:@"processBeginTime"];
        [processInfo setObject:currentTime forKey:@"preProcessTime"];
        [[ZMAnalyticsContext sharedInstance].processContextData setObject:processInfo forKey:processCode];
    }else if(eventStage == 3){
        if([[ZMAnalyticsContext sharedInstance].processContextData objectForKey:processCode]){
            NSMutableDictionary *processInfo = [[NSMutableDictionary alloc]initWithDictionary:[[ZMAnalyticsContext sharedInstance].processContextData objectForKey:processCode]];
            info.processEventId = [processInfo objectForKey:@"processEventId"];
            NSString *preProcessTime = [processInfo objectForKey:@"preProcessTime"];
            NSString *slotDuration = @"0";
            if([ZYStringUtils isNotEmpty:preProcessTime]){
                long long time = [currentTime longLongValue]-[preProcessTime longLongValue];
                slotDuration = [NSString stringWithFormat:@"%lli",time];
            }
            info.slotDuration = slotDuration;
            
            NSString *processBeginTime = [processInfo objectForKey:@"processBeginTime"];
            NSString *processDuration = @"0";
            if([ZYStringUtils isNotEmpty:processBeginTime]){
                long long time = [currentTime longLongValue]-[processBeginTime longLongValue];
                processDuration = [NSString stringWithFormat:@"%lli",time];
            }
            info.processDuration = processDuration;
        }else{
        }
    }else{
        if([[ZMAnalyticsContext sharedInstance].processContextData objectForKey:processCode]){
            NSMutableDictionary *processInfo = [[NSMutableDictionary alloc]initWithDictionary:[[ZMAnalyticsContext sharedInstance].processContextData objectForKey:processCode]];
            info.processEventId = [processInfo objectForKey:@"processEventId"];
            NSString *preProcessTime = [processInfo objectForKey:@"preProcessTime"];
            NSString *slotDuration = @"0";
            if([ZYStringUtils isNotEmpty:preProcessTime]){
                long long time = [currentTime longLongValue]-[preProcessTime longLongValue];
                slotDuration = [NSString stringWithFormat:@"%lli",time];
            }
            info.slotDuration = slotDuration;
        }else{
        }
    }
    info.eventCode = eventCode;
    
    info.screenName = screenName?:@"";
    
    info.occurTime = currentTime?:@"";
    
    info.eventParam = eventParam;
    
    e.eventInfo = info;
    return e;
}

//绑定事件
+(instancetype)generationBindingPointEvent:(NSString*)eventCode screenName:(NSString*)screenName eventParam:(NSDictionary *)eventParam{
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    e.statType = @"2";
    
    ZMEventInfoDto *info = [[ZMEventInfoDto alloc]init];
    info.eventId = [ZYUUIDUtils UUID];
    info.eventType = ZMEventTypeBind;
    info.eventCode = eventCode;
    info.eventStage = 0;
    info.screenName = screenName?:@"";
    NSString *currentTime = [NSString stringWithFormat:@"%lli",(long long)[[NSDate date] timeIntervalSince1970]*1000];
    info.occurTime = currentTime;
    info.eventParam = eventParam;
    e.eventInfo = info;
    return e;
}

///////////////////////////////////////////////////////////



+(instancetype)generationNetworkEvent:(NSString *)cxt {
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    [e setType:@"network"];
    [e setCxt:cxt];
    return e;
}

+(instancetype)generationLocationEvent:(double)lat lng:(double)lng {
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    [e setType:@"location"];
    [e setLng:@(lng)];
    [e setLat:@(lat)];
    return e;
}
+(instancetype)generationEvent:(NSString *)eventId lab:(NSString *)lab atts:(NSDictionary *)atts duration:(int)duration {
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    [e setType:@"event"];
    [e setEId:eventId];
    [e setLab:lab];
    [e setAtts:atts];
    [e setDuration:@(duration)];
    return e;
}
+(instancetype)generationDeviceEvent:(NSString *)name type:(NSString *)type os:(NSString *)os size:(NSString *)size {
    SimpleAnalyticsEvent *e = [[SimpleAnalyticsEvent alloc] init];
    [e setType:@"device"];
    [e setDName:name];
    [e setDType:type];
    [e setDOS:os];
    [e setDSize:size];
    return e;
}

#pragma mark IAnalyticsEvent
-(NSString *)type {
    return _type;
}

-(NSString *)uid {
    return _uid;
}

-(NSString *)uuid {
    return _uuid;
}

-(NSString *)time {
    return _time;
}

@end
