//
//  IZYHttpFilter.h
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

@protocol IZYHttpResponse;

/**
 *  HTTP 结果 过滤器
 */
@protocol IZYHttpFilter <NSObject>

/**
 *  HTTP 响应结果过滤器
 *
 *  @param res 响应结果
 *
 *  @return YES:向后继续过滤  NO:做拦截处理，不向后继续过滤
 */
-(BOOL) doFilter:(id<IZYHttpResponse>) res;

/**
 *  过滤源数据
 */
-(BOOL) doFilterData:(id) resData;

@end
