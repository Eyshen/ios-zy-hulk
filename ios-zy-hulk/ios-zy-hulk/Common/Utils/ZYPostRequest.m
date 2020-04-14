//
//  ZYPostRequest.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/5/11.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "ZYPostRequest.h"

@implementation ZYPostRequest

-(id)initWithRequestUrl:(NSString *)url argument:(NSDictionary *)argument{
    return [self initWithRequestUrl:url argument:argument constructingBodyBlock:nil];
}

- (id)initWithRequestUrl:(NSString *)url argument:(id)argument constructingBodyBlock:(nullable AFConstructingBlock)block{
    self = [super init];
    if (self) {
        self.requestUrl = url;
        self.requestArgument = argument;
        self.constructingBodyBlock = block;//直接赋值过去即可
    }
    return self;
}


- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}


@end
