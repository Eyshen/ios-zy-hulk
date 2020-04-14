//
//  IZYHttpRequest.h
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

#define HTTP_METHOD_GET         @"GET"
#define HTTP_METHOD_POST        @"POST"
#define HTTP_METHOD_PUT         @"PUT"
#define HTTP_METHOD_DELETE      @"DELETE"

/**
 *  HTTP 请求接口
 */
@protocol IZYHttpRequest <NSObject>

/**
 *  HTTP请求URL
 */
-(NSString*) getURL;

/**
 *  验证参数
 */
-(BOOL) validateParams;

/**
 *  HTTP Headers
 */
-(NSDictionary*) getHeaders;

/**
 *  HTTP Params
 */
-(NSDictionary*) getParams;

/**
 *  HTTP Body
 *  当服务器端有自定义HTTP格式时，用此方法代替 getParams
 */
-(NSData*) getBodyData;

/**
 *  HTTP Method
 */
-(NSString*) getMethod;

/**
 *  HTTP 请求超时时间
 *
 *  @return 秒数
 */
-(long) getTimeoutDuration;

/**
 *  上传文件列表
 *
 *  @return 文件列表 key：name value：filePath    OR  key:name value:IWJUploadFileInfo
 */
-(NSDictionary*) getUploadFiles;

/**
 *  是否存在上传文件
 */
-(BOOL) existUploadFile;

/**
 *  请求是否隐藏状态栏网络标识
 *  Default NO
 */
-(BOOL) hideNetworkActivityIndicator;


@optional

/**
 *  验证参数是否正确
 */
- (void)validateParamsByError:(NSError**)error;

@end
