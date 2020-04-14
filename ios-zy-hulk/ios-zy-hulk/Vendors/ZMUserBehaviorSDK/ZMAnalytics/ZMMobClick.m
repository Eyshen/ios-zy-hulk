//
//  KKMobClick.m
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

#import "ZMMobClick.h"
#import "ZMAnalyticsContext.h"
#import "SimpleAnalyticsEvent.h"
#import "ZYNetworkContext.h"
#import "APMTools.h"


@interface ZMMobClick ()

@end

@implementation ZMMobClick

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static id singletonObject;
    dispatch_once( &once, ^{
        singletonObject = [[self alloc] init];
        if ([singletonObject respondsToSelector:@selector(singleInit)]) {
            [singletonObject singleInit];
        }
    });
    return singletonObject;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)singleInit {
    [[ZYNetworkContext sharedInstance] addNotification:self selector:@selector(handleNetworkChangeNotification:)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUIApplicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

//app启动 暂时不记录
-(void)handleApplicationDidFinishLaunchingNotification:(NSNotification*)notification {
//    NSString *sizeString = [NSString stringWithFormat:@"%@|%@",@([[UIScreen mainScreen] scale] * [[UIScreen mainScreen] bounds].size.width),@([[UIScreen mainScreen] scale] * [[UIScreen mainScreen] bounds].size.height)];
//    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationDeviceEvent:[[UIDevice currentDevice] name] type:[[UIDevice currentDevice] model] os:[NSString stringWithFormat:@"%@%@",[[UIDevice currentDevice] systemName],[[UIDevice currentDevice] systemVersion]] size:sizeString];
//    [event setUid:[[ZMAnalyticsContext sharedInstance] uid]];
//    [[ZMAnalyticsContext sharedInstance] publish:event];
}

-(void)handleUIApplicationDidEnterBackgroundNotification:(NSNotification*)notification{
    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationLeaveAPPScreenEvent:@"" screenName:[APMTools getCurrentViewControllerNameThreadSafe] preScreenName:@"" DescInfo:@{} descType:1];
    
    [[ZMAnalyticsContext sharedInstance] setStagingScreenName:[APMTools getCurrentViewControllerNameThreadSafe]];
    
    [[ZMAnalyticsContext sharedInstance] publish:event];
}

-(void)handleNetworkChangeNotification:(NSNotification*)notification {
    /*
     网络状态变化 暂时先不传
    if ([[ZYNetworkContext sharedInstance] isConnection]) {
        NSString *networkingName = nil;
        switch ([[ZYNetworkContext sharedInstance] currentStatus]) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkingName = @"wifi";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkingName = @"wwan";
                break;
            default:
                networkingName = @"unknown";
                break;
        }
        SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationNetworkEvent:networkingName];
        [event setUid:[[ZMAnalyticsContext sharedInstance] uid]];
        [[ZMAnalyticsContext sharedInstance] publish:event];
    }
     */
}
//注册app
+ (void)registerAppConfig:(ZMAnalyticsConfig*)config dataStoreage:(id<IAnalyticsDataStorage>)dataStoreage {
    [[ZMAnalyticsContext sharedInstance] registerAppConfig:config dataStoreage:dataStoreage];
    [ZMMobClick sharedInstance];
}

//用户已注销操作
+ (void)userLogout {
    [[ZMAnalyticsContext sharedInstance] setUid:nil];
    [[ZMAnalyticsContext sharedInstance] setToken:nil];
}

//用户已登录操作
+ (void)userLogined:(NSString*)uid token:(NSString *)token {
    [[ZMAnalyticsContext sharedInstance] setUid:uid];
    [[ZMAnalyticsContext sharedInstance] setToken:token];
}
//进入页面
+ (void)eventScreenInCurrentScreen:(NSString *)currentScreen{
    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationEnterScreenEvent:@"" screenName:currentScreen preScreenName:@"" DescInfo:@{} descType:1];
    
//    [[ZMAnalyticsContext sharedInstance] setStagingScreenName:currentScreen];
    
    [[ZMAnalyticsContext sharedInstance] publish:event];
}
//离开页面
+ (void)eventScreenOutCurrentScreen:(NSString *)currentScreen{
    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationLeaveScreenEvent:@"" screenName:currentScreen preScreenName:@"" DescInfo:@{} descType:2];
    
    [[ZMAnalyticsContext sharedInstance] setStagingScreenName:currentScreen];
    
    [[ZMAnalyticsContext sharedInstance] publish:event];
}
//appCrash页面
+ (void)eventScreenCrashAppCurrentScreen:(NSString *)currentScreen{
    
}
//离开APP页面
+ (void)eventScreenLeaveAppCurrentScreen:(NSString *)currentScreen{
    
}

//////////////////////////////////////////////////////////////////////////////////////

//单点事件
+ (void)pointEventCode:(NSString*)eventCode{
    [self pointEventCode:eventCode withEventParam:nil];
}

+ (void)pointEventCode:(NSString*)eventCode withEventParam:(NSDictionary *)eventParam{
    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationPointEvent:eventCode screenName:[APMTools getCurrentViewControllerNameThreadSafe] eventParam:eventParam?:@{}];
    
    [[ZMAnalyticsContext sharedInstance] publish:event];
}
//聚合事件
+ (void)processEventCode:(NSString*)eventCode eventStage:(ZMEventStageProcessEventEnum)eventStage processStep:(int)processStep processCode:(NSString *)processCode{
    [self processEventCode:eventCode eventStage:eventStage processStep:processStep processCode:processCode withEventParam:nil];
}

+ (void)processEventCode:(NSString*)eventCode eventStage:(ZMEventStageProcessEventEnum)eventStage processStep:(int)processStep processCode:(NSString *)processCode withEventParam:(NSDictionary *)eventParam{
    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationProcessEvent:eventCode eventStage:eventStage processStep:processStep processCode:processCode screenName:[APMTools getCurrentViewControllerNameThreadSafe] eventParam:eventParam?:@{}];
    
    [[ZMAnalyticsContext sharedInstance] publish:event];
}

//绑定事件
+ (void)bindingPointEventCode:(NSString*)eventCode{
    [self bindingPointEventCode:eventCode withEventParam:nil];
}

+ (void)bindingPointEventCode:(NSString*)eventCode withEventParam:(NSDictionary *)eventParam{
    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationBindingPointEvent:eventCode screenName:[APMTools getCurrentViewControllerNameThreadSafe] eventParam:eventParam?:@{}];
                                   
    [[ZMAnalyticsContext sharedInstance] publish:event];
}

//////////////////////////////////////////////////////////////////////////////////////
+ (void)event:(NSString*)evnetId {
    [self event:evnetId label:nil];
}

+ (void)event:(NSString*)evnetId label:(NSString*)label {
    [self event:evnetId label:label duration:0];
}

+ (void)event:(NSString*)evnetId label:(NSString*)label duration:(int)millisecond {
    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationEvent:evnetId lab:label atts:nil duration:millisecond];
    [event setUid:[[ZMAnalyticsContext sharedInstance] uid]];
    [[ZMAnalyticsContext sharedInstance] publish:event];
}

+ (void)event:(NSString*)evnetId label:(NSString*)label attributes:(NSDictionary *)attributes {
    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationEvent:evnetId lab:label atts:attributes duration:0];
    [event setUid:[[ZMAnalyticsContext sharedInstance] uid]];
    [[ZMAnalyticsContext sharedInstance] publish:event];
}

+ (void)event:(NSString*)evnetId attributes:(NSDictionary *)attributes {
    [self event:evnetId label:nil attributes:attributes];
}

+ (void)event:(NSString*)evnetId attributes:(NSDictionary *)attributes duration:(int)millisecond {
    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationEvent:evnetId lab:nil atts:attributes duration:millisecond];
    [event setUid:[[ZMAnalyticsContext sharedInstance] uid]];
    [[ZMAnalyticsContext sharedInstance] publish:event];
}

//+ (void)beginEvent:(NSString*)eventId {
//    
//}
//
//+ (void)endEvent:(NSString*)eventId {
//    
//}
//
//+ (void)beginEvent:(NSString*)eventId label:(NSString*)label {
//    
//}
//
//+ (void)endEvent:(NSString*)eventId label:(NSString*)label {
//    
//}

//位置信息发生改变---暂时不传
+ (void)setLocationLng:(double)lng lat:(double)lat {
    SimpleAnalyticsEvent *event = [SimpleAnalyticsEvent generationLocationEvent:lat lng:lng];
    [event setUid:[[ZMAnalyticsContext sharedInstance] uid]];
    [[ZMAnalyticsContext sharedInstance] publish:event];
}

@end
