//
//  ZMAppAnalyticsDataStorage.h
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

#import <Foundation/Foundation.h>
#import "IAnalyticsDataStorage.h"
#import "AbstractZYBusinessObject.h"
#import "ZMSingleton.h"

@interface ZMAppAnalyticsDataStorage : AbstractZYBusinessObject<IAnalyticsDataStorage>

AS_SINGLETON(ZMAppAnalyticsDataStorage)

@end
