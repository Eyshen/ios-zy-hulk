//
//  ZMAppAnalyticsDataStorage.m
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

#import "ZMAppAnalyticsDataStorage.h"

#define MAX_CACHE_EVENTS_NUMBER     10000

@interface ZMAppAnalyticsDataStorage()

@property(nonatomic, strong) NSMutableArray *cacheArray;

@end

@implementation ZMAppAnalyticsDataStorage

DEF_SINGLETON_INIT(ZMAppAnalyticsDataStorage)

- (void)singleInit {
    self.cacheArray = [[NSMutableArray alloc] init];
}

//获取事件
-(NSArray*)fetchEvents:(int)count {
    if (count < [self.cacheArray count]) {
        return [self.cacheArray subarrayWithRange:NSMakeRange(0, count)];
    } else {
        return [self.cacheArray copy];
    }
}

//删除事件
-(void)deleteEvents:(NSArray*)events {
    [self.cacheArray removeObjectsInArray:events];
}

//添加事件
-(BOOL)addEvents:(NSArray*)events {
    if ([events count] > 0) {
        if ([self.cacheArray count] > MAX_CACHE_EVENTS_NUMBER && [events count] < MAX_CACHE_EVENTS_NUMBER) [self.cacheArray removeObjectsInRange:NSMakeRange(0, [events count])];
        [self.cacheArray addObjectsFromArray:events];
        return YES;
    }
    return NO;
}

//添加事件
-(BOOL)addEvent:(id<IAnalyticsEvent>)event {
    if (event) {
        if ([self.cacheArray count] > MAX_CACHE_EVENTS_NUMBER) [self.cacheArray removeObjectAtIndex:0];
        [self.cacheArray addObject:event];
        return YES;
    }
    return NO;
}

//队列是否为空
-(BOOL)isEmpty {
    return [self.cacheArray count] == 0;
}


@end
