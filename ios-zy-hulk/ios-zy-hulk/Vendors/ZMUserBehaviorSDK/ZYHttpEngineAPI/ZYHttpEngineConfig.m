//
//  ZYHttpEngineConfig.m
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

#import "ZYHttpEngineConfig.h"
#import "IZYHttpEngine.h"
#import "IZYHttpFilter.h"
#import "ZYConfig.h"



@interface ZYHttpEngineConfig ()
@property (nonatomic, strong) NSMutableArray *fs;
@property (nonatomic, strong) NSMutableSet *cerPaths;
@end

@implementation ZYHttpEngineConfig

DEF_SINGLETON_INIT(ZYHttpEngineConfig)

-(void) singleInit {
    _defaultTimeoutDuration = 60;
    _defaultNetworkActivityEnabled = YES;
    _fs = [[NSMutableArray alloc] init];
    self.defaultEngineName = @"AFZYHttpEngine";
    self.cerPaths = [[NSMutableSet alloc] init];
    
    NSDictionary *config = [[ZYConfig sharedInstance] getConfig:@"ZYHttpEngineAPI"];
    if ([[config allKeys] containsObject:@"timeoutDuration"]) {
        id o = [config objectForKey:@"timeoutDuration"];
        if ([o isKindOfClass:[NSNumber class]]) {
            _defaultTimeoutDuration = [(NSNumber*)o intValue];
        }
    }
    if ([[config allKeys] containsObject:@"defaultEngineName"]) {
        id o = [config objectForKey:@"defaultEngineName"];
        if ([o isKindOfClass:[NSString class]]) {
            self.defaultEngineName = o;
        }
    }
    if ([[config allKeys] containsObject:@"networkActivityEnabled"]) {
        id o = [config objectForKey:@"networkActivityEnabled"];
        if ([o isKindOfClass:[NSNumber class]]) {
            _defaultNetworkActivityEnabled = [(NSNumber*)o boolValue];
        }
    }
    if ([[config allKeys] containsObject:@"allowInvalidCertificates"]) {
        id o = [config objectForKey:@"allowInvalidCertificates"];
        if ([o isKindOfClass:[NSNumber class]]) {
            _allowInvalidCertificates = [(NSNumber*)o boolValue];
        }
    }
    if ([[config allKeys] containsObject:@"filters"]) {
        id o = [config objectForKey:@"filters"];
        if ([o isKindOfClass:[NSArray class]]) {
            for (id item in o) {
                if ([item isKindOfClass:[NSString class]]) {
                    [self addFilter:NSClassFromString(item)];
                }
            }
        }
    }
    if ([[config allKeys] containsObject:@"cers"]) {
        id o = [config objectForKey:@"cers"];
        if ([o isKindOfClass:[NSArray class]]) {
            for (id item in o) {
                if ([item isKindOfClass:[NSString class]]) {
                    if ([(NSString*)item hasSuffix:@"cer"]) {
                        [self addCertificater:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:item]];
                    }
                }
            }
        }
    }
}

-(void) setTimeoutDuration:(int) timeoutDuration {
    if (timeoutDuration > 0) {
        _defaultTimeoutDuration = timeoutDuration;
    }
}

-(void) setNetworkActivityEnabled:(BOOL) enabled {
    _defaultNetworkActivityEnabled = enabled;
}

-(void) addFilter:(Class) filterClazz {
    if (filterClazz) {
        if ([filterClazz conformsToProtocol:@protocol(IZYHttpFilter)]) {
            [_fs addObject:filterClazz];
        } else {
            NSString *reason = [NSString stringWithFormat:@"%@ 没有实现过滤器协议 IZYHttpFilter",NSStringFromClass(filterClazz)];
            @throw [NSException exceptionWithName:@"ZYHttpEngineException" reason:reason userInfo:nil];
        }
    }
}

-(NSArray *)filters {
    return _fs;
}

/**
 *  添加证书
 */
-(void) addCertificater:(NSString*) path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] && [[path pathExtension] isEqualToString:@"cer"]) {
        [_cerPaths addObject:path];
    }
}

/**
 *  证书列表
 */
-(NSArray*) certificatesPaths {
    return _cerPaths.allObjects;
}

@end
