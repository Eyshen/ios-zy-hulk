//
//  MsgBodyDTO.h
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

//#import <WJCommon/WJCommon.h>

#import "MsgCommonInfoDto.h"

@interface MsgBodyDTO : NSObject

//appKey
@property(nonatomic, copy) NSString *appKey;//暂时不用

//appCode
@property(nonatomic, copy) NSString *appCode;

//基本信息
@property(nonatomic, strong) MsgCommonInfoDto *commonInfo;

//事件列表
@property(nonatomic, copy) NSArray *statList;

////渠道
//@property(nonatomic, copy) NSString *channel;
//
////设备号
//@property(nonatomic, copy) NSString *dcode;
//
////版本号
//@property(nonatomic, copy) NSString *appVersion;


-(instancetype)initWithAppCode:(NSString*)appCode userId:(NSString *)userId channel:(NSString*)channel appId:(NSString *)appId dcode:(NSString*)dcode;

@end
