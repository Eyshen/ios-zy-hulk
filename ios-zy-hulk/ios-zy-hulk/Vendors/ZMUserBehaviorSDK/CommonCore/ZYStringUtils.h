//
//  ZYStringUtils.h
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


#define ZY_STRING_EQUAL(str1, str2)            [ZYStringUtils equal:str1 str:str2]
#define ZY_STRING_IS_BLANK(str)                [ZYStringUtils isBlank:str]
#define ZY_STRING_IS_NOT_BLANK(str)            [ZYStringUtils isNotBlank:str]
#define ZY_STRING_IS_EMPTY(str)                [ZYStringUtils isEmpty:str]
#define ZY_STRING_IS_NOT_EMPTY(str)            [ZYStringUtils isNotEmpty:str]
#define ZY_STRING_SPLIT(str,separator)         [ZYStringUtils split:str separator:separator]
#define ZY_STRING_JOIN(strList,separator)      [ZYStringUtils join:strList separator:separator]


/**
 *  字符串 工具类
 */
@interface ZYStringUtils : NSObject

/**
 *  字符串是否为空串
 *
 *  @param string 判断字符串
 *
 *  @return 判断结果（YES:nil、“”）
 */
+(BOOL) isBlank:(NSString*) str;

/**
 *  字符串是否为空
 *
 *  @param string 判断字符串
 *
 *  @return 判断结果（YES:[NSNull null]、null、(null)、nil、“”）
 */
+(BOOL) isEmpty:(NSString*) str;

/**
 *  字符串是否不为空串
 *
 *  @param string 判断字符串
 *
 *  @return 判断结果（YES:nil、“”）
 */
+(BOOL) isNotBlank:(NSString*) str;

/**
 *  字符串是否不为空
 *
 *  @param string 判断字符串
 *
 *  @return 判断结果（YES:[NSNull null]、null、(null)、nil、“”）
 */
+(BOOL) isNotEmpty:(NSString*) str;

/**
 *  比较字符串
 *
 *  @param str1 字符串1
 *  @param str2 字符串2
 *
 *  @return 结果
 */
+(BOOL) equal:(NSString*) str1 str:(NSString*) str2;

/**
 *  分拆字符串
 *
 *  @param str       被分拆字符串
 *  @param separator 分拆符
 *
 *  @return 分拆结果
 */
+(NSArray*) split:(NSString*) str separator:(NSString*) separator;

/**
 *  连接字符串数组
 *
 *  @param strs       字符串列表
 *  @param separator 连接符
 *
 *  @return 连接字符串结果
 */
+(NSString*) join:(NSArray*) strs separator:(NSString*) separator;

@end
