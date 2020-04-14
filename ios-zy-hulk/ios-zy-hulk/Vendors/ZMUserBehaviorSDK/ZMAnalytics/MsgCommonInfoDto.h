//
//  MsgCommonInfoDto.h
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/11/4.
//  Copyright © 2019 Eason. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MsgCommonInfoDto : NSObject

@property (nonatomic,copy) NSString *reqId; //请求id

@property (nonatomic,copy) NSString *userId;//userId

@property (nonatomic,copy) NSString *deviceId;//设备id

@property (nonatomic,copy) NSString *channelId;//渠道id

@property (nonatomic,copy) NSString *appVersion;//app版本

@property (nonatomic,copy) NSString *sdkVersion;//sdk版本

@property (nonatomic,copy) NSString *appId;//appID

@property (nonatomic,copy) NSString *platform;//渠道

@property (nonatomic,copy) NSString *occurTime;//时间戳

@end

NS_ASSUME_NONNULL_END
