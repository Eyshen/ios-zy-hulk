//
//  ZYBaseRequest.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/5/11.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "ZYBaseRequest.h"

#import "YTKNetworkConfig.h"

@implementation ZYBaseRequest

-(instancetype)init{
    self = [super init];
    if (self) {
        [YTKNetworkConfig sharedConfig].debugLogEnabled = YES;
        
        self.verifyJSONFormat = YES;
    }
    return self;
}

-(NSString *)baseUrl{
    return @"https://appapi-test.zmlearn.com";
}

-(NSTimeInterval)requestTimeoutInterval{
    return 5;
}

-(id)jsonValidator{
    if (self.verifyJSONFormat) {
        return @{
                 @"data":[NSObject class],
                 @"code":[NSNumber class],
                 @"message":[NSString class]
                 };
    }else{
        return nil;
    }
}

-(void)startWithCompletionBlockWithSuccess:(ZYBaseRequestCompletionBlock)success failure:(ZYBaseRequestCompletionFailureBlock)failure{
    [super startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSDictionary * result = [request responseObject];
        BOOL isSuccess = YES;
        //校验格式
//        if(self.verifyJSONFormat){
//            isSuccess = [[result objectForKey:@"success"] boolValue];
//        }
        success(request,result,isSuccess);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        failure(request,self.errorInfo);
    }];
}

-(NSString *)description{
    //
    return [NSString stringWithFormat:@"%@ \nstatusCode:%ld\nresponseJSONObject:\n%@",self.description,self.responseStatusCode,self.responseJSONObject];
}

-(NSString *)errorInfo{
    NSString *info = @"";
    if (self && self.error) {
        if(self.error.code == NSURLErrorNotConnectedToInternet){
            info = @"请检查网络";
        }else if (self.error.code==NSURLErrorTimedOut) {
            info = @"请求超时,请重试!";
        }
    }
    return info;
}

@end
