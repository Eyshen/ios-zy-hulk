//
//  UploadEventHttpApi.m
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

#import "UploadEventHttpApi.h"
#import "ZMAnalyticsContext.h"
#import "ZYJSON.h"

@implementation UploadEventHttpRequest

#pragma mark Overridings
-(NSString*) getURL {
#ifdef DEBUG
    return @"http://10.28.142.200:8080/ube-collector/collect/data";
#else
    return @"http://10.28.142.200:8080/ube-collector/collect/data";
#endif
}

-(NSString *)getMethod {
    return HTTP_METHOD_POST;
}

-(NSDictionary *)getParams {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    [params setObject:[ZYJSON toJsonString:_newData] forKey:@"msgBodyData"];
    NSString *jasonStr = [ZYJSON toJsonString:_msgData];
    NSDictionary *para = (NSDictionary *)[ZYJSON fromJsonString:jasonStr];
    ZYLogDebug(@"收集的数据%@",para);
    //+(id) fromJsonString:(NSString*) json;
    [params addEntriesFromDictionary:_data];
    return params;
}

@end

@implementation UploadEventHttpResponse

#pragma mark Overridings
+(id<IZYHttpResponse>)parseResult:(NSData*)responseData {
    UploadEventHttpResponse *res = nil;
#ifdef DEBUG
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    ZYLogDebug(@"%@",responseString);
#endif
    @try {
        res = [ZYJSON fromJsonData:responseData type:[UploadEventHttpResponse class]];
        [res setMessage:@"数据解析错误~"];
        [res setCode:-1];
    } @catch (NSException *exception) {
        res = [[UploadEventHttpResponse alloc] init];
    }
    return res;
}

-(BOOL) isError {
    return _code < 0;
}

-(int)code{
    return _code;
}

-(NSString *)message{
    return _message;
}

@end



