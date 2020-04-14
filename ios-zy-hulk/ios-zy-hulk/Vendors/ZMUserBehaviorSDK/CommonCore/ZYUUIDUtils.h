//
//  ZYUUIDUtils.h
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

#define ZY_UUID         [ZYUUIDUtils UUID]

/**
 *  UUID 工具类
 */
@interface ZYUUIDUtils : NSObject

/**
 *  生成一个UUID字符串
 *
 *  @return 返回随机UUID 去掉 "-"
 */
+(NSString*) UUID;

@end
