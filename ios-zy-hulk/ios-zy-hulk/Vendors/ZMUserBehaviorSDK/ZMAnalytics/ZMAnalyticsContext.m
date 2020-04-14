//
//  ZMAnalyticsContext.m
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

#import "ZMAnalyticsContext.h"
#import "ZYHttpFactory.h"
#import "UploadEventHttpApi.h"
#import "ZYNetworkContext.h"
#import <AdSupport/ASIdentifierManager.h>

#define UPLOAD_FAIL_TIME_INTERVAL   60*2

#define EVENT_BATCH_UPLOAD_SIZE     100

@interface ZMAnalyticsContext ()

@property(nonatomic, strong) id<IZYHttpEngine> httpEngine;

@property (nonatomic, strong) dispatch_source_t dispatch_source;

@property(nonatomic, strong) ZMAnalyticsConfig *config;

@property(nonatomic, strong) id<IAnalyticsDataStorage> dataStoreage;

@property(nonatomic, strong) dispatch_group_t publish_dispatch_group;

//上传失败网络错误最后时间
@property(atomic, assign) NSTimeInterval uploadFailTime;

@end

@implementation ZMAnalyticsContext

DEF_SINGLETON_INIT(ZMAnalyticsContext)

- (void)registerAppConfig:(ZMAnalyticsConfig*)config dataStoreage:(id<IAnalyticsDataStorage>)dataStoreage {
    self.config = config;
    self.dataStoreage = dataStoreage;
}

-(void)handleApplicationDidFinishLaunchingNotification:(NSNotification*)notification {
    dispatch_source_merge_data(_dispatch_source, 1);
}

-(void) singleInit {
    self.httpEngine = [ZYHttpFactory buildHttpEngine];
    self.processContextData = [[NSMutableDictionary alloc]init];
    self.dispatch_source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_OR, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    self.publish_dispatch_group = dispatch_group_create();
    dispatch_source_set_event_handler(_dispatch_source, ^{
        unsigned long data = dispatch_source_get_data(self.dispatch_source);
        if (data == 1) {
            [self startUploadAction];
        }
    });
    dispatch_resume(self.dispatch_source);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidFinishLaunchingNotification:) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (dispatch_source_testcancel(_dispatch_source) == 0) {
        dispatch_source_cancel(self.dispatch_source);
    }
}

-(void)publish:(id<IAnalyticsEvent>)event {
    if (event) {
        dispatch_group_async(self.publish_dispatch_group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.dataStoreage addEvent:event];
        });
        dispatch_group_notify(self.publish_dispatch_group, dispatch_get_main_queue(), ^{
            dispatch_source_merge_data(self.dispatch_source, 1);
        });
    }
}

-(void)startUploadAction {
    while (self.dataStoreage && ![self.dataStoreage isEmpty] && self.config && [[ZYNetworkContext sharedInstance] isConnection] && [[NSDate date] timeIntervalSince1970] - _uploadFailTime > UPLOAD_FAIL_TIME_INTERVAL) {
        @try {
            @autoreleasepool {
                NSArray *events = [_dataStoreage fetchEvents:EVENT_BATCH_UPLOAD_SIZE];
//                MsgBodyDTO *body = [[MsgBodyDTO alloc] initWithAppCode:self.config.appCode channel:self.config.channelId dcode:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
                MsgBodyDTO *body = [[MsgBodyDTO alloc] initWithAppCode:self.config.appCode userId:self.config.userId channel:self.config.channelId appId:self.config.appId dcode:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
                
                [body setStatList:events];
                UploadEventHttpRequest *request = [[UploadEventHttpRequest alloc] init];
                NSDictionary *bodyData=@{
                                         @"appCode":@"11223344",
                                         @"appKey":@"55667788",
                                         @"commonInfo":@{@"appId":@"110",
                                                         @"appVersion":@"4.17.0",
                                                         @"channelId":@"zhifubao",
                                                         @"deviceId":@"deviceId",
                                                         @"occurtime":@(1570525594417),
                                                         @"platform":@"ios",
                                                         @"reqId":@"ee67bf93-df1a-4412-89ad-9adb0c199a09",
                                                         @"sdkVersion":@"1.0.0.0",
                                                         @"userId":@"userId"},
                                     @"statList":@[@{@"screenInfo":@{
                                                  @"preScreenName":@"com.behavior.demo.PageRouteFragmentA",
                                                  @"screenName":@"com.behavior.demo.PageRouteFragmentA",
                                                  @"screenOut":@{
                                                                @"duration":@(331868),
                                                                @"occurtime":@(1570525594412)
                                                                },
                                                  @"screenType":@(2)
                                                  },
                                                    @"statType":@(0)
                                                     },
                                                  ],
                                         };
                
                [request setMsgData:body];
                [request setData:bodyData];
                
                NSError *error = nil;
                UploadEventHttpResponse *response = (UploadEventHttpResponse*)[self.httpEngine syncRequest:request responseClass:[UploadEventHttpResponse class] error:&error];
                if (error) {
                    self.uploadFailTime = [[NSDate date] timeIntervalSince1970];
                    if ([error isKindOfClass:[NSError class]]) {
                        ZYLogDebug(@"事件发送失败:%@",error.userInfo[NSLocalizedDescriptionKey]);
                    }
                    break;
                } else {
                    if ([response isError]) {
                        ZYLogDebug(@"事件发送失败:%@",[response errorMsg]);
                        self.uploadFailTime = [[NSDate date] timeIntervalSince1970];
                        break;
                    } else {
                        ZYLogDebug(@"事件发送成功~");
                        ZYLogInfo(@"事件发送成功~");
                        [self.dataStoreage deleteEvents:events];
                        self.uploadFailTime = 0;
                    }
                }
            }
        } @catch (NSException *exception) {
            ZYLogDebug(@"事件发送出现问题，导致异常~");
        }
    }
}

@end
