//
//  HomeInfoHttpRequest.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/5/8.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "HomeInfoHttpRequest.h"

@implementation HomeInfoHttpRequest

-(NSString *)requestUrl{
    return @"students-api/api/index/pad/indexInfo";
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}
-(id)requestArgument{
    return @{};
}


@end
