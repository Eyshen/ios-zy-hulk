//
//  ZYCrashStuProxy.h
//  ios-zy-hulk
//     _______________      __
//    /\______   /  \ \    / /
//    \/___  /  /    \ \  / /
//        / /  /      \ \/ /
//       / /  /        \/ /
//      / /  /______   / /
//     / /__________\ / /
//    /_____________/ \/
//
//  Created by 张学超 on 2019/4/4.
//  Copyright © 2019 Eason. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define ZYCrashProtectorNotification @"ZYCrashProtectorNotification"
#define ZYCrashProtectorIsiOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)


//user can ignore below define
#define ZYCrashProtectorDefaultReturnNil  @"ZYCrashProtector default is to return nil to avoid crash."
#define ZYCrashProtectorDefaultIgnore     @"ZYCrashProtector default is to ignore this operation to avoid crash."

#define ZYCrashProtectorSeparator         @"================================================================"
#define ZYCrashProtectorSeparatorWithFlag @"========================ZYCrashProtector Log===================="


#ifdef DEBUG

#define  ZYCrashProtectorLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])

#else

#define ZYCrashProtectorLog(...)
#endif


@interface ZYCrashStuProxy : NSObject

- (void)proxyMethod;

@end

NS_ASSUME_NONNULL_END
