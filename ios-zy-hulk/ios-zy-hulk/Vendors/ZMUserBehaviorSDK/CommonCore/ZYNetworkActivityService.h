//
//  ZYNetworkActivityManager.h
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
//  Created by Eason on 19/10/22.
//  Copyright (c) 2019年 张一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZMSingleton.h"

@interface ZYNetworkActivityService : NSObject

AS_SINGLETON(ZYNetworkActivityService)

/**
 *  开始让状态栏中的数据标示旋转
 */
-(void)start;

/**
 *  停止让状态栏中的数据标示旋转
 */
-(void)stop;

/**
 *  立即停止状态栏中的数据标示旋转
 */
-(void)stopAll;

@end
