//
//  NSObject+ZYCrashProtector.h
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/4/4.
//  Copyright © 2019 Eason. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZYCrashProtector)

/**
 *  ifDealWithNoneSel : 是否开启"unrecognized selector sent to instance"异常的捕获
 */
+ (void)zyCrashExchangeMethodIfDealWithNoneSel:(BOOL)ifDealWithNoneSel;

+ (void)setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings;

+ (void)setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs;

@end

NS_ASSUME_NONNULL_END
