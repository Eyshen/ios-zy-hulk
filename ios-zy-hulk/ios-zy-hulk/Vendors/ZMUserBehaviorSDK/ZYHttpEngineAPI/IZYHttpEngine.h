//
//  IZYHttpEngine.h
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

@protocol IZYHttpRequest;
@protocol IZYHttpResponse;

/**
 *  回调block
 *
 *  @param res   http response
 *  @param error error
 */
typedef void(^ZYHttpEngineResponseBlock)(id<IZYHttpResponse> res, NSError *error);

/**
 *  响应block
 */
typedef void(^ZYHttpEngineNativeResponseBlock)(NSData* resData, NSError *error);


/**
 *  下载响应block
 *
 *  @param filePath 下载文件名
 *  @param error    错误
 */
typedef void (^ZYHttpEngineDownloadResponseBlock)(NSString* filePath, NSError *error);

/**
 *  进度条
 *
 *  @param progress 进度（0.0f~1.0f）
 */
typedef void (^ZYHttpEngineProgressBlock)(float progress);



@protocol IZYHttpEngine <NSObject>

/**
 *  是否在请求中
 */
- (BOOL)hasLoading;

/**
 *  异步请求
 *
 *  @param request  http request
 *  @param resClass http response Class
 *  @param resBlock response block
 */
- (void)asynRequest:(id<IZYHttpRequest>) request
      responseClass:(Class) resClass
      responseBlock:(ZYHttpEngineResponseBlock) resBlock;


/**
 *  异步调用
 *
 *  @param url          url
 *  @param method       method
 *  @param params       请求参数
 *  @param failBlock    失败block
 */
- (void)asynRequestURL:(NSString*) url
                method:(NSString*) method
                params:(NSDictionary*) params
         responseBlock:(ZYHttpEngineNativeResponseBlock) nativeResBlock;



/**
 *  异步调用
 *
 *  @param url          url
 *  @param method       method
 *  @param params       请求参数
 *  @param headers      头
 *  @param successBlock 成功block
 *  @param failBlock    失败block
 */
- (void)asynRequestURL:(NSString*) url
                method:(NSString*) method
                params:(NSDictionary*) params
               headers:(NSDictionary*) headers
         responseBlock:(ZYHttpEngineNativeResponseBlock) nativeResBlock;


/**
 *  同步请求(使用dispatch_semaphore_t阻塞达到同步效果,不要在主线程调用)
 *
 *  @param request  http request
 *  @param resClass http response Class
 *  @param error    error
 *
 *  @return http response
 */
- (id<IZYHttpResponse>)syncRequest:(id<IZYHttpRequest>) request
                     responseClass:(Class) resClass
                             error:(NSError**) error;

/**
 *  同步调用(使用dispatch_semaphore_t阻塞达到同步效果,不要在主线程调用)
 *
 *  @param url          url
 *  @param method       method
 *  @param params       请求参数
 *  @param error        错误信息
 *
 *  @return response data
 */
- (NSData*)syncRequestURL:(NSString*) url
                method:(NSString*) method
                params:(NSDictionary*) params
                 error:(NSError**) error;


/**
 *  同步调用(使用dispatch_semaphore_t阻塞达到同步效果,不要在主线程调用)
 *
 *  @param url          url
 *  @param method       method
 *  @param params       请求参数
 *  @param headers      头
 *  @param error        错误信息
 *
 *  @return response data
 */
- (NSData*)syncRequestURL:(NSString*) url
                   method:(NSString*) method
                   params:(NSDictionary*) params
                  headers:(NSDictionary*) headers
                    error:(NSError**) error;



/**
 *  异步下载
 *
 *  @param url           下载文件url
 *  @param resBlock      响应block
 *  @param progressBlock 下载进度block
 */
- (void)asynDownloadByURL:(NSString*)url
             responseBlock:(ZYHttpEngineDownloadResponseBlock)resBlock
                  progress:(ZYHttpEngineProgressBlock)progressBlock;



/**
 *  取消任务
 */
-(void) cancel;

@end
