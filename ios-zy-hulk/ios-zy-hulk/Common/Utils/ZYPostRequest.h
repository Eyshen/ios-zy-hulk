//
//  ZYPostRequest.h
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/5/11.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "ZYBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZYPostRequest : ZYBaseRequest

/**
 POST 请求
 
 @param url 网址
 @param argument 参数
 @return ZYBaseRequest
 */

-(id)initWithRequestUrl:(NSString *)url argument:(id)argument;


/**
 POST 请求
 @param url 网址
 @param argument 参数
 @param block 支持附件
 @return HXRequest
 */
- (id)initWithRequestUrl:(NSString *)url argument:(id)argument constructingBodyBlock:(nullable AFConstructingBlock)block;


@end

NS_ASSUME_NONNULL_END
