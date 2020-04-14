//
//  ZYHttpFactory.h
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
#import "IZYHttpEngine.h"

/**
 *  Http 组件工厂
 */
@interface ZYHttpFactory : NSObject

/**
 *  创建一个HttpEngine
 */
+(id<IZYHttpEngine>) buildHttpEngine;

@end
