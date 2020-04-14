//
//  ZYBaseRequest.h
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/5/11.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "YTKRequest.h"

@class ZYBaseRequest;

typedef void(^ZYBaseRequestCompletionBlock)(__kindof ZYBaseRequest *request,NSDictionary *result,BOOL success);

typedef void(^ZYBaseRequestCompletionFailureBlock)(__kindof ZYBaseRequest *request,NSString *errorInfo);

NS_ASSUME_NONNULL_BEGIN

@interface ZYBaseRequest : YTKRequest

@property (nonatomic, strong) NSString *requestUrl;

@property (nonatomic, strong) id requestArgument;

@property (nonatomic, strong) NSString * errorInfo;

//请求类型
@property (nonatomic, assign) YTKRequestSerializerType requestSerializerType;

@property (nonatomic, assign) BOOL verifyJSONFormat;

//开始请求
- (void)startWithCompletionBlockWithSuccess:(nullable ZYBaseRequestCompletionBlock)success failure:(nullable ZYBaseRequestCompletionFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
