//
//  BaseZYHttpRequest.m
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

#import "BaseZYHttpRequest.h"
#import "ZYHttpEngineConfig.h"

@implementation BaseZYHttpRequest

-(NSString*) getURL {
    return nil;
}

-(BOOL) validateParams {
    return YES;
}

-(NSDictionary*) getHeaders {
    return nil;
}

-(NSDictionary*) getParams {
    return nil;
}

-(NSData*) getBodyData {
    return nil;
}

-(NSString*) getMethod {
    return HTTP_METHOD_GET;
}

-(long) getTimeoutDuration {
    return [[ZYHttpEngineConfig sharedInstance] defaultTimeoutDuration];
}

-(NSDictionary*) getUploadFiles {
    return nil;
}

-(BOOL) existUploadFile {
    if ([[self getUploadFiles] count] > 0) {
        return YES;
    }
    return NO;
}

-(BOOL)hideNetworkActivityIndicator {
    return [[ZYHttpEngineConfig sharedInstance] defaultNetworkActivityEnabled];
}

@end
