//
//  ZYHTTPSessionManagerStorage.m
//  ZYHttpEngineAF-example
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

#import "ZYHTTPSessionManagerStorage.h"
#import "ZYHttpEngineConfig.h"

@interface ZYHTTPSessionManagerStorage ()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation ZYHTTPSessionManagerStorage

DEF_SINGLETON_INIT(ZYHTTPSessionManager)

-(void) setMaxConcurrentCount:(NSInteger) concurrentCount {
    if (concurrentCount > 0) {
        [[self.sessionManager operationQueue] setMaxConcurrentOperationCount:concurrentCount];
    }
}

-(void) singleInit {
    //单利初始化
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableSet *cerSet = nil;
    NSArray *cerPaths = [[ZYHttpEngineConfig sharedInstance] certificatesPaths];
    if ([cerPaths count] > 0) {
        cerSet = [[NSMutableSet alloc] init];
        for (NSString *p in cerPaths) {
            NSData *data = [[NSData alloc] initWithContentsOfFile:p];
            if (data) {
                [cerSet addObject:data];
            }
        }
    }
    if ([cerSet count] > 0) {
        AFSecurityPolicy *afSecurityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        [self.sessionManager setSecurityPolicy:afSecurityPolicy];
    }
    //允许无效的SSL证书
    [self.sessionManager.securityPolicy setAllowInvalidCertificates:[[ZYHttpEngineConfig sharedInstance] allowInvalidCertificates]];
    [[self.sessionManager operationQueue] setMaxConcurrentOperationCount:5];
}

-(AFHTTPSessionManager *)defaultSessionManager {
    return _sessionManager;
}

@end
