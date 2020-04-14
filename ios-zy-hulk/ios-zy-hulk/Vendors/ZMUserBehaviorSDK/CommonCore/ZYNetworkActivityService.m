//
//  ZYNetworkActivityManager.m
//  117goFramework
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

#import "ZYNetworkActivityService.h"
#import <UIKit/UIKit.h>

@interface ZYNetworkActivityService ()
@property (atomic, assign) int counter;
@end

@implementation ZYNetworkActivityService

DEF_SINGLETON_INIT(ZYNetworkActivityService)

-(void)start {
    @synchronized(self) {
        if (_counter == 0) {
            if ([[NSThread currentThread] isMainThread]) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
                });
            }
            
        }
        _counter++;
    }
}

-(void)stop {
    @synchronized(self) {
        if (_counter > 0 && --_counter == 0) {
            if ([[NSThread currentThread] isMainThread]) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                });
            }
        }
    }
}

-(void)stopAll {
    @synchronized(self) {
        _counter = 0;
        if ([[NSThread currentThread] isMainThread]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }
    }
}

-(void) handleApplicationDidEnterBackgroundNotification:(NSNotification*) notification {
    [self stopAll];
}

-(void) singleInit {
    _counter = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApplicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
