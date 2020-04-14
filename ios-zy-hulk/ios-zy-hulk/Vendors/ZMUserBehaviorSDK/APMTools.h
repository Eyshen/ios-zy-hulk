//
//  APMTools.h
//  ZMPerformanceTestSDK
//
//  Created by jun on 2019/8/28.
//  Copyright © 2019 jun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const DataCounterKeyWWANSent = @"WWANSent";
static NSString *const DataCounterKeyWWANReceived = @"WWANReceived";
static NSString *const DataCounterKeyWiFiSent = @"WiFiSent";
static NSString *const DataCounterKeyWiFiReceived = @"WiFiReceived";


@interface APMTools : NSObject

+ (NSString *)getCurrentViewControllerName;
+ (NSString *)getCurrentViewControllerNameThreadSafe;

+ (int64_t)memoryUsage;
+ (double)availableMemory;
+ (long long)getTotalMemorySize;
+ (float)cpuUsage;
+ (NSDictionary *)trackDataBytes;

@end

NS_ASSUME_NONNULL_END
