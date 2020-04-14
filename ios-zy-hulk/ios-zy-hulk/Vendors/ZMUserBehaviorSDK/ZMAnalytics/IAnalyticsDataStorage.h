//
//  IAnalyticsDataStorage.h
//  ZMAnalytics-example
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
//  Created by Eason on 19/10/23.
//  Copyright (c) 2019年 张一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAnalyticsEvent.h"

//统计时间储存器
@protocol IAnalyticsDataStorage <NSObject>

//获取事件
-(NSArray*)fetchEvents:(int)count;

//删除事件
-(void)deleteEvents:(NSArray*)events;

//添加事件
-(BOOL)addEvents:(NSArray*)events;

//添加事件
-(BOOL)addEvent:(id<IAnalyticsEvent>)event;

//队列是否为空
-(BOOL)isEmpty;

@end
