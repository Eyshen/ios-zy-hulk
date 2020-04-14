//
//  BaseZYHttpResponse.m
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

#import "BaseZYHttpResponse.h"

@implementation BaseZYHttpResponse

+(id<IZYHttpResponse>)parseResult:(NSData*)responseData {
    return nil;
}

/**
 *  是否存在逻辑错误
 */
-(BOOL) isError {
    return NO;
}

/**
 *  服务端返回的逻辑错误码
 */
-(NSString*) errorCode {
    return nil;
}

/**
 *  服务端返回的逻辑错误说明
 */
-(NSString*) errorMsg {
    return nil;
}

@end
