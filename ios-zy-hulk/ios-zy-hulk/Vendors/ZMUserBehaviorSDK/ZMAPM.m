//
//  APM.m
//  ZMPerformanceTestSDK
//
//  Created by jun on 2019/8/28.
//  Copyright © 2019 jun. All rights reserved.
//

#import "ZMAPM.h"
#import <arpa/inet.h>
#import <netinet/in.h>
#import <ifaddrs.h>
#import "sys/utsname.h"
#import <mach/mach.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>
#import <QuartzCore/QuartzCore.h>
#import "ZMZAPMHookBase.h"
#import "APMTools.h"
#import "ZMFileWriter.h"
#import "ZMZAPMBacktraceLogger.h"
#import "zmgetgateway.h"
#import "ZMapmfishhook.h"
#import "ZMZAPMBacktraceLogger.h"
#import "UIControl-ZMAPMHook.h"
#import "UINavigationViewController-ZMAPMHook.h"
#import "UIViewController-ZMAPMHook.h"


static NSTimeInterval luanchTime = 0;
static ZMAPM *s_apmInstance = nil;

@interface ZMAPM()

//fps统计，每一秒开始的时间，原子属性
@property(atomic,assign) NSTimeInterval beginTime;
//
@property(atomic,assign) NSTimeInterval beginTimeInterval;

//fps统计，每一秒的帧数计数，原子属性
@property(atomic,assign) NSInteger count;

@property(atomic,assign) NSTimeInterval enterForegroundTime;
@property(atomic,assign) NSInteger counter;

@property(atomic,assign) NSTimeInterval enterMainThreadTime;
@property(atomic,assign) NSTimeInterval leftMainThreadTime;

@property(strong,nonatomic) ZMZAPMSimplePing *ping;
@property(assign,atomic) NSTimeInterval startTime;
@property(assign,atomic) uint16_t sequenceNumber;


@property(assign,nonatomic) double lastSended;
@property(assign,nonatomic) double lastReceived;

@end

@implementation ZMAPM

+ (ZMAPM *)sharedInstance {
    if (s_apmInstance == nil) {
        s_apmInstance = [ZMAPM new];
    }
    return s_apmInstance;
}

+ (void)start {
    
    [ZMZAPMHookBase hookClassOut:NSClassFromString(@"AFURLSessionManager")
                   currentClass:self
               originalSelector:NSSelectorFromString(@"dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:")
               swizzledSelector:NSSelectorFromString(@"loghook_dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:")];
    
    [ZMZAPMHookBase hookClassOut:NSClassFromString(@"SocketIOClient")
                   currentClass:self
               originalSelector:NSSelectorFromString(@"on:callback:")
               swizzledSelector:NSSelectorFromString(@"loghookon:callback:")];
    
    [ZMZAPMHookBase hookClassOut:NSClassFromString(@"SocketIOClient")
                   currentClass:self
               originalSelector:NSSelectorFromString(@"onAny:")
               swizzledSelector:NSSelectorFromString(@"loghookonAny:")];
    
    [ZMZAPMHookBase hookClassOut:NSClassFromString(@"SocketIOClient")
                   currentClass:self
               originalSelector:NSSelectorFromString(@"emitWithAck:with:")
               swizzledSelector:NSSelectorFromString(@"loghook_emitWithAck:with:")];
    
    [ZMZAPMHookBase hookClassOut:NSClassFromString(@"SocketIOClient")
                   currentClass:self
               originalSelector:NSSelectorFromString(@"emit:with:")
               swizzledSelector:NSSelectorFromString(@"loghook_emit:with:")];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(apmTimer) userInfo:nil repeats:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[ZMAPM sharedInstance] startFPSMonitor];
    });
    
    [[ZMAPM sharedInstance] startRouterDelayMonitor];
    
    [self hookfopen];
    
    [UIControl apmHook];
    [UINavigationController apmHook];
    [UIViewController apmHook];
}

- (NSNumber *)getCounter {
    return @(self.counter++);
}

+ (NSString *)getTime {
    return [NSString stringWithFormat:@"%.2f",([[NSDate date] timeIntervalSince1970])];
}

+ (void)apmTimer {
    
    [self recorCPU];
    [self recordMemory];
    [[ZMAPM sharedInstance] recordCarton];
    [[ZMAPM sharedInstance] recordNetworkBytes];
    
    if ([[ZMAPM sharedInstance] ping]) {
        [ZMAPM sharedInstance].startTime = [[NSDate date] timeIntervalSince1970];
        [[[ZMAPM sharedInstance] ping] sendPingWithData:nil];
    }
}

+ (void)recorCPU {
    CGFloat cpu = [APMTools cpuUsage];

    NSDictionary *dic = @{@"time":[self getTime],
                          @"counter":[[ZMAPM sharedInstance] getCounter],
                          @"type":@"cpu",
                          @"viewcontroller":[APMTools getCurrentViewControllerName],
                          @"value":[NSString stringWithFormat:@"%.1f",cpu],
                          @"param":@"",
                          @"resq":@"",
                          @"resp":@"",
                          @"stacks":@""
                          };
    
//    [FileWriter writeDic:dic];
}

+ (void)recordMemory {
    CGFloat memory = [APMTools memoryUsage];

    NSDictionary *dic = @{@"time":[self getTime],
                          @"counter":[[ZMAPM sharedInstance] getCounter],
                          @"type":@"memory",
                          @"viewcontroller":[APMTools getCurrentViewControllerName],
                          @"value":[NSString stringWithFormat:@"%.1f",memory],
                          @"param":@"",
                          @"resq":@"",
                          @"resp":@"",
                          @"stacks":@""
                          };
    
    
//    [FileWriter writeDic:dic];
}


+ (void)recordFPS:(NSInteger)fps {
    NSDictionary *dic = @{@"time":[self getTime],
                          @"counter":[[ZMAPM sharedInstance] getCounter],
                          @"type":@"fps",
                          @"viewcontroller":[APMTools getCurrentViewControllerName],
                          @"value":@(fps),
                          @"param":@"",
                          @"resq":@"",
                          @"resp":@"",
                          @"stacks":@""
                          };
    
//    [FileWriter writeDic:dic];
}

- (void)recordCarton {
    if (self.enterMainThreadTime - self.leftMainThreadTime > 1.5f) {
        
        NSString *mainThreadStacks = [ZMZAPMBacktraceLogger bs_backtraceOfMainThread];
        mainThreadStacks = [mainThreadStacks stringByReplacingOccurrencesOfString:@"  " withString:@""];
        
        NSDictionary *dic = @{@"time":[ZMAPM getTime],
                              @"counter":[[ZMAPM sharedInstance] getCounter],
                              @"type":@"carton",
                              @"viewcontroller":[APMTools getCurrentViewControllerName],
                              @"value":[NSString stringWithFormat:@"%.0f",(self.enterMainThreadTime - self.leftMainThreadTime)],
                              @"param":@"",
                              @"resq":@"",
                              @"resp":@"",
                              @"stacks":mainThreadStacks
                              };
        
//        [FileWriter writeDic:dic];
    }
    
    self.enterMainThreadTime = [[NSDate date] timeIntervalSince1970];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.leftMainThreadTime = [[NSDate date] timeIntervalSince1970];
    });
}

- (void)recordNetworkBytes {
    NSDictionary *dic = [APMTools trackDataBytes];
    
    double allsent = [dic[DataCounterKeyWiFiSent] unsignedIntValue] + [dic[DataCounterKeyWWANSent] unsignedIntValue];
    double allReceived = [dic[DataCounterKeyWWANReceived] unsignedIntValue] + [dic[DataCounterKeyWiFiReceived] unsignedIntValue];

    if (self.lastSended != 0) {

        NSDictionary *dic = @{@"time":[ZMAPM getTime],
                              @"counter":[[ZMAPM sharedInstance] getCounter],
                              @"type":@"send_bytes",
                              @"viewcontroller":[APMTools getCurrentViewControllerName],
                              @"value":@((allsent - self.lastSended) / 1024.0f),
                              @"param":@"",
                              @"resq":@"",
                              @"resp":@"",
                              @"stacks":@""
                              };
        
//        [FileWriter writeDic:dic];
        
        NSDictionary *dic2 = @{@"time":[ZMAPM getTime],
                              @"counter":[[ZMAPM sharedInstance] getCounter],
                              @"type":@"receive_bytes",
                              @"viewcontroller":[APMTools getCurrentViewControllerName],
                              @"value":@((allReceived - self.lastReceived) / 1024.0f),
                              @"param":@"",
                              @"resq":@"",
                              @"resp":@"",
                              @"stacks":@""
                              };
        
//        [FileWriter writeDic:dic2];
    }

    self.lastSended = [dic[DataCounterKeyWiFiSent] unsignedIntValue] + [dic[DataCounterKeyWWANSent] unsignedIntValue];
    self.lastReceived = [dic[DataCounterKeyWiFiReceived] unsignedIntValue] + [dic[DataCounterKeyWWANReceived] unsignedIntValue];
}

- (void)startRouterDelayMonitor {
    NSString *gatewayip = [ZMAPM zmgetgatewayIpForCurrentWiFi];
    if (gatewayip.length > 0 && ([gatewayip containsString:@"192.168"] || [gatewayip containsString:@"172.20"])) {
        self.ping = [[ZMZAPMSimplePing alloc] initWithHostName:gatewayip];
        self.ping.delegate = self;
        self.ping.addressStyle = SimplePingAddressStyleAny;
        [self.ping start];
    }
}

- (void)simplePing:(ZMZAPMSimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet {
    if (pinger == self.ping) {
        CGFloat routerDelay = ([[NSDate date] timeIntervalSince1970] - self.startTime) * 1000;
        [self recordRouterDelay:routerDelay];
    }
}

- (void)simplePing:(ZMZAPMSimplePing *)pinger didFailWithError:(NSError *)error {
    if (pinger == self.ping) {
        CGFloat routerDelay = ([[NSDate date] timeIntervalSince1970] - self.startTime) * 1000;
        [self recordRouterDelay:routerDelay];
    }
}

- (void)simplePing:(ZMZAPMSimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber {
    if (pinger == self.ping) {
        self.sequenceNumber = sequenceNumber;
    }
}

- (void)simplePing:(ZMZAPMSimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber {
    if (sequenceNumber == self.sequenceNumber && pinger == self.ping) {
        self.ping = pinger;
        CGFloat routerDelay = ([[NSDate date] timeIntervalSince1970] - self.startTime) * 1000;
        [self recordRouterDelay:routerDelay];
    }
}

- (void)recordRouterDelay:(CGFloat)delay {
    NSDictionary *dic = @{@"time":[ZMAPM getTime],
                          @"counter":[[ZMAPM sharedInstance] getCounter],
                          @"type":@"router_delay",
                          @"viewcontroller":[APMTools getCurrentViewControllerName],
                          @"value":[NSString stringWithFormat:@"%.1f",delay],
                          @"param":@"",
                          @"resq":@"",
                          @"resp":@"",
                          @"stacks":@""
                          };
//    [FileWriter writeDic:dic];
}

//获取网关等信息
+ (NSString *)zmgetgatewayIpForCurrentWiFi {
    unsigned char *s = getdefaultgateway();
    
    if (s == NULL) {
        return @"";
    }
    else if (sizeof(s) < 4){
        free(s);
        return @"";
    }
    NSString *ip=[NSString stringWithFormat:@"%d.%d.%d.%d",s[0],s[1],s[2],s[3]];
    free(s);
    return ip;
}


- (id)loghook_emit:(NSString *)event with:(NSArray *)items {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *dic = @{@"time":[ZMAPM getTime],
                              @"counter":[[ZMAPM sharedInstance] getCounter],
                              @"type":@"socket",
                              @"viewcontroller":[APMTools getCurrentViewControllerName],
                              @"value":@(2),
                              @"param":event,
                              @"resq":[NSString stringWithFormat:@"%@",items],
                              @"resp":@"",
                              @"stacks":@"socketio emit"
                              };
        
//        [FileWriter writeDic:dic];
    });
    return [self loghook_emit:event with:items];
}

- (id)loghook_emitWithAck:(NSString *)event with:(NSArray *)items {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *dic = @{@"time":[ZMAPM getTime],
                              @"counter":[[ZMAPM sharedInstance] getCounter],
                              @"type":@"socket",
                              @"viewcontroller":[APMTools getCurrentViewControllerName],
                              @"value":@(1),
                              @"param":event,
                              @"resq":[NSString stringWithFormat:@"%@",items],
                              @"resp":@"",
                              @"stacks":@"socketio emitWithAck"
                              };
        
//        [FileWriter writeDic:dic];
    });
    
    return [self loghook_emitWithAck:event with:items];
}

typedef void(^socketOnAnyCompleteHandler)(id);

- (void)loghookonAny:(void (^)(id))handler {
    
    socketOnAnyCompleteHandler newCompleteBlock = ^void(id event) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = @{@"time":[ZMAPM getTime],
                                  @"counter":[[ZMAPM sharedInstance] getCounter],
                                  @"type":@"socket",
                                  @"viewcontroller":[APMTools getCurrentViewControllerName],
                                  @"value":@(3),
                                  @"param":@"",
                                  @"resq":@"",
                                  @"resp":[NSString stringWithFormat:@"%@",event],
                                  @"stacks":@"socketio onAny"
                                  };
            
//            [FileWriter writeDic:dic];
        });
        
        if (handler) {
            handler(event);
        }
    };
    
    if ([self respondsToSelector:@selector(loghookonAny:)]) {
        return [self loghookonAny:newCompleteBlock];
    }
}


typedef void(^socketCompleteHandler)(NSArray *, id);

- (NSUUID *)loghookon:(NSString *)event callback:(void (^)(NSArray *arr, id emiter))callback {
    
    socketCompleteHandler newCompleteBlock = ^void(NSArray *arr, id emiter) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dic = @{@"time":[ZMAPM getTime],
                                  @"counter":[[ZMAPM sharedInstance] getCounter],
                                  @"type":@"socket",
                                  @"viewcontroller":[APMTools getCurrentViewControllerName],
                                  @"value":@(0),
                                  @"param":event,
                                  @"resq":@"",
                                  @"resp":[NSString stringWithFormat:@"%@",arr],
                                  @"stacks":@"socketio on callback"
                                  };
            
//            [FileWriter writeDic:dic];
        });
        
        if (callback) {
            callback(arr,emiter);
        }
    };
    
    if ([self respondsToSelector:@selector(loghookon:callback:)]) {
        return [self loghookon:event callback:newCompleteBlock];
    }
    else {
        return nil;
    }
}

typedef void(^logCompleteHandler)(NSURLResponse *, id,  NSError *);

- (NSURLSessionDataTask *)loghook_dataTaskWithRequest:(NSURLRequest *)request
                                       uploadProgress:(void (^)(NSProgress *uploadProgress))uploadProgressBlock
                                     downloadProgress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                    completionHandler:(void (^)(NSURLResponse *response, id responseObject,  NSError * error))completionHandler {
    
    double startTime = [[NSDate date] timeIntervalSince1970];
    
    logCompleteHandler newCompleteBlock = ^void(NSURLResponse *response, id responseObject,  NSError * error) {
        
        NSTimeInterval execTime = ([[NSDate date] timeIntervalSince1970] - startTime) * 1000;
        
        NSDictionary *dic = @{@"time":[ZMAPM getTime],
                              @"counter":[[ZMAPM sharedInstance] getCounter],
                              @"type":@"network",
                              @"viewcontroller":[APMTools getCurrentViewControllerName],
                              @"value":@(execTime),
                              @"param":request.URL.absoluteString,
                              @"exectime":[NSString stringWithFormat:@"%.1f",execTime],
                              @"resq":@"",
                              @"resp":[NSString stringWithFormat:@"%@",responseObject],
                              @"stacks":@""
                              };

//        [FileWriter writeDic:dic];
        
        if (completionHandler) {
            completionHandler(response,responseObject,error);
        }
    };
    
    if ([self respondsToSelector:@selector(loghook_dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:)]) {
        return [self loghook_dataTaskWithRequest:request
                                  uploadProgress:uploadProgressBlock
                                downloadProgress:downloadProgressBlock
                               completionHandler:newCompleteBlock];
    }
    else {
        return nil;
    }
}

- (void)startFPSMonitor {
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
    [displayLink setPaused:NO];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

//这个方法的执行频率跟当前屏幕的刷新频率是一样的，屏幕每渲染刷新一次，就执行一次，那么1秒的时长执行刷新的次数就是当前的FPS值
- (void)displayLinkTick:(CADisplayLink *)link{
    
    //初始化屏幕渲染的时间
    if (self.beginTime == 0) {
        self.beginTime = link.timestamp;//timestamp 上次屏幕渲染的时间点
        self.beginTimeInterval = [[NSDate date] timeIntervalSince1970];
        return;
    }
    self.count++;
    //刚刚屏幕渲染的时间与最开始幕渲染的时间差
    NSTimeInterval interval = link.timestamp - self.beginTime;
    if (interval < 2) {
        //每两秒统计一次帧数
        return;
    }
    
    float fps = self.count / interval;
    
    if (self.beginTimeInterval > self.enterForegroundTime) {
        [ZMAPM recordFPS:(NSInteger)fps];
    }
    
    //2秒之后，初始化时间和次数，重新开始监测
    self.beginTime = link.timestamp;
    self.beginTimeInterval = [[NSDate date] timeIntervalSince1970];
    self.count = 0;
}

+ (void)recorLuanchTime:(CGFloat)time {
    NSDictionary *dic = @{@"time":[self getTime],
                          @"counter":[[ZMAPM sharedInstance] getCounter],
                          @"type":@"luanch",
                          @"viewcontroller":[APMTools getCurrentViewControllerName],
                          @"value":@(time),
                          @"param":@"",
                          @"resq":@"",
                          @"resp":@"",
                          @"stacks":@""
                          };
    
//    [FileWriter writeDic:dic];
}

- (void)becomeActive {
    NSTimeInterval totalluanchTime = [[NSDate date] timeIntervalSince1970] - luanchTime;
    NSLog(@"luanchTime:%.2fs",totalluanchTime);
    
    [ZMAPM recorLuanchTime:totalluanchTime];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

+ (void)load {
    luanchTime = [[NSDate date] timeIntervalSince1970];
    [[NSNotificationCenter defaultCenter] addObserver:[ZMAPM sharedInstance] selector:@selector(becomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [ZMZAPMHookBase hookClassSelectorOut:NSClassFromString(@"ZMLog")
                        currentClass:self
                    originalSelector:NSSelectorFromString(@"zmhook")
                    swizzledSelector:NSSelectorFromString(@"hookzmhook")];
}

+ (void)hookzmhook {
    NSLog(@"");
}

static FILE *(*orig_fopen)(const char *, const char *);
static size_t (*orig_fwrite)(const void *, size_t, size_t, FILE *);
static size_t (*orig_malloc)(size_t __size);

FILE *mix_fopen(const char * path, const char * mode)
{
    NSString *pathString = [NSString stringWithUTF8String:path];
    if ([pathString containsString:@"apm_"] == NO) {
        //log filepath
        NSDictionary *dic = @{@"time":[ZMAPM getTime],
                              @"counter":[[ZMAPM sharedInstance] getCounter],
                              @"type":@"file_open",
                              @"viewcontroller":[APMTools getCurrentViewControllerNameThreadSafe],
                              @"value":@(0),
                              @"param":[NSString stringWithUTF8String:path],
                              @"resq":@"",
                              @"resp":@"",
                              @"stacks":@""
                              };
//        [FileWriter writeDic:dic];
    }

    return orig_fopen(path, mode);
}

size_t mix_fwrite(const void * __ptr, size_t __size, size_t __nitems, FILE * __stream)
{
        //log filepath
    NSDictionary *dic = @{@"time":[ZMAPM getTime],
                          @"counter":[[ZMAPM sharedInstance] getCounter],
                          @"type":@"file_write",
                          @"viewcontroller":[APMTools getCurrentViewControllerNameThreadSafe],
                          @"value":@(__size),
                          @"param":@"",
                          @"resq":@"",
                          @"resp":@"",
                          @"stacks":@""
                          };

//    [FileWriter writeDic:dic];
    
    return orig_fwrite(__ptr,__size,__nitems,__stream);
}

size_t mix_malloc(size_t __size)
{
//    NSLog(@"malloc:%zu",__size);
    return orig_malloc(__size);
}

+ (void)hookfopen {
    apmrebinding fopen_rebinding = (apmrebinding) {
        "fopen",
        (void *)mix_fopen,
        (void **)&orig_fopen
    };
    apmrebinding fwrite_rebinding = (apmrebinding) {
        "fwrite",
        (void *)mix_fwrite,
        (void **)&orig_fwrite
    };
    
    apmrebinding malloc_rebinding = (apmrebinding) {
        "malloc",
        (void *)mix_malloc,
        (void **)&orig_malloc
    };
    
    apmrebind_symbols(&fopen_rebinding, 1);
    apmrebind_symbols(&fwrite_rebinding, 1);
    apmrebind_symbols(&malloc_rebinding, 1);
}

@end

//主入口
__attribute__((constructor)) static void entry()
{
#ifdef DEBUG
    [ZMAPM start];
#endif
}
