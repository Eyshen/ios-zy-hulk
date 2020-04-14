//
//  FilterCore.m
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

#import "ZYHttpFilterCore.h"
#import "IZYHttpFilter.h"
#import "ZYHttpEngineConfig.h"
//#import "ZYLoggingMacros.h"

static ZYHttpFilterCore *sharedObject;

@interface ZYHttpFilterCore ()
@property (nonatomic, strong) NSMutableArray *filters;
@end

@implementation ZYHttpFilterCore

-(void)filter:(id)res {
    for (id filter in _filters) {
        if ([res conformsToProtocol:@protocol(IZYHttpResponse)]) {
            if (![filter doFilter:res]) {
                break;
            }
        } else {
            if (![filter doFilterData:res]) {
                break;
            }
        }
    }
}

-(void) singleInit {
    self.filters = [[NSMutableArray alloc] init];
    
    NSArray *fs = [[ZYHttpEngineConfig sharedInstance] filters];
    for (Class f in fs) {
        [self.filters addObject:[[f alloc] init]];
    }
}

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[ZYHttpFilterCore alloc] init];
        [sharedObject singleInit];
    });
    return sharedObject;
}

-(id)mutableCopy {
    return self;
}

-(id)copy {
    return self;
}

+(id)allocWithZone:(NSZone *)zone {
    @synchronized (self) {
        if (sharedObject == nil) {
            sharedObject = [super allocWithZone:zone];
        }
    }
    return sharedObject;
}

@end
