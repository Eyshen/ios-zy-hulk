//
//  ZMAPM.h
//  ZMPerformanceTestSDK
//
//  Created by jun on 2019/8/28.
//  Copyright © 2019 jun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMZAPMSimplePing.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface ZMAPM : NSObject<SimplePingDelegate>

+ (ZMAPM *)sharedInstance;
- (NSNumber *)getCounter;
+ (NSString *)getTime;

@end

NS_ASSUME_NONNULL_END

