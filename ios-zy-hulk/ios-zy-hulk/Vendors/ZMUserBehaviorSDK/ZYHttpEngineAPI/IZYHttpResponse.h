//
//  IZYHttpResponse.h
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

/**
 *  HTTP 响应接口
 */
@protocol IZYHttpResponse <NSObject>

/**
 *  解析响应结果
 *
 *  @param responseString 响应字符串
 *
 *  @return 响应对象
 */
+(id<IZYHttpResponse>) parseResult:(NSData*) responseData;

@optional
/**
 *  是否存在逻辑错误
 */
-(BOOL) isError;

/**
 *  服务端返回的逻辑错误码
 */
-(NSString*) errorCode;

/**
 *  服务端返回的逻辑错误说明
 */
-(NSString*) errorMsg;

@end
