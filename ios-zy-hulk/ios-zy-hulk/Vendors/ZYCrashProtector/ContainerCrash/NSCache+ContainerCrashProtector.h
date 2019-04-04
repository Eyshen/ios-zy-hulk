//
//  NSCache+ContainerCrashProtector.h
//  WJCrashProtector-example
//
//  Created by ada on 2019/3/11.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCache (ContainerCrashProtector)

+ (void)enabledCacheCrashProtector;

@end
