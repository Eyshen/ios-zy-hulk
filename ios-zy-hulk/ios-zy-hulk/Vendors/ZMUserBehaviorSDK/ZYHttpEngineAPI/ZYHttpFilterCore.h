//
//  FilterCore.h
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
#import "IZYHttpResponse.h"

/**
 *  http 过滤器管理类
 */
@interface ZYHttpFilterCore : NSObject

-(void) filter:(id) res;

+(instancetype) sharedInstance;

@end
