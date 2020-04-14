//
//  ZMScreenInfoDto.h
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/11/4.
//  Copyright © 2019 Eason. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZMScreenInfoDto : NSObject

@property(nonatomic, copy) NSString *screenType;//1 Controller 2view

@property(nonatomic, copy) NSString *screenName;//当前页面名字

@property(nonatomic, copy) NSString *preScreenName;//前面页面名字

/*
    screenIn  screenOut  crash  appOut   4选1
 */
@property(nonatomic, copy) NSDictionary *screenIn;//进入页面信息(occurTime 时间戳 duration 上个页面out至本页面in)

@property(nonatomic, copy) NSDictionary *screenOut;//页面离开(occurTime 时间戳 duration 上个页面out至本页面in)

@property(nonatomic, copy) NSDictionary *crash;//appcrash信息(occurTime 时间戳 crashInfo crash堆栈信息)

@property(nonatomic, copy) NSDictionary *appOut;//退出app信息(occurTime 时间戳)

@property(nonatomic, copy) NSDictionary *screenExtInfo;//拓展信息

@end

NS_ASSUME_NONNULL_END
