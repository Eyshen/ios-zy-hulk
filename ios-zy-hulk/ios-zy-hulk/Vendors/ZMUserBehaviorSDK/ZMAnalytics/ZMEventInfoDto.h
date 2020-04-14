//
//  ZMEventInfoDto.h
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/11/4.
//  Copyright © 2019 Eason. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ZMEventType) {
    
    //单点事件
    ZMEventTypePoint = 1,
    
    //过程事件
    ZMEventTypeProgress = 2,
    
    //绑定事件
    ZMEventTypeBind = 3,
    
};


@interface ZMEventInfoDto : NSObject

@property(nonatomic, copy) NSString *eventId;//事件id

@property(nonatomic, assign) ZMEventType eventType;//事件类型 (1点事件  2过程事件  3绑定事件)

//@property(nonatomic, copy) NSString *eventName;//事件名

@property(nonatomic, copy) NSString *eventCode;//事件code

@property(nonatomic, copy) NSString *processEventId;//过程事件ID

@property(nonatomic, assign) int processStep;//过程事件步骤

@property(nonatomic, copy) NSString *processDuration;//过程事件 耗时 结束的时候统计

@property(nonatomic, copy) NSString *processCode;//过程事件code

//@property(nonatomic, copy) NSString *processName;//过程事件名称

@property(nonatomic, assign) int eventStage;//0 普通事件  1 开始 2 进行中 3结束

@property(nonatomic, copy) NSString *screenName;//当前页面名称

@property(nonatomic, copy) NSString *slotDuration;//距离上一个过程事件的时间间隔

@property(nonatomic, copy) NSString *occurTime;//事件戳

@property(nonatomic, copy) NSDictionary *eventParam;//拓展参数(code 1006,//前端或后台返回的retCode    msg  解析出错，请稍后再试"//retMsg )

@property(nonatomic, copy) NSString *eventExtInfo; //拓展字段

@end

NS_ASSUME_NONNULL_END
