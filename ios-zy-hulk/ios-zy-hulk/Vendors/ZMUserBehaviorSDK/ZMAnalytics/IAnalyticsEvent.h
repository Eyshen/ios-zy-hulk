//
//  IAnalyticsEvent.h
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

//统计时间
@protocol IAnalyticsEvent <NSObject>

-(NSString*)type;

-(NSString*)uuid;

-(NSString*)uid;

-(NSString*)time;

@end
