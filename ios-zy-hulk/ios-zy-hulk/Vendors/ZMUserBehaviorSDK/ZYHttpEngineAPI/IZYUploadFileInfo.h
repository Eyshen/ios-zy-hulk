//
//  IZYUploadFileInfo.h
//  ZYHttpEngineAPI-example
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

/**
 *  上传文件信息
 */
@protocol IZYUploadFileInfo <NSObject>

/**
 *  文件名称
 */
-(NSString*)fileName;

/**
 *  文件路径
 */
-(NSString*)filePath;

/**
 *  文件内容类型
 */
-(NSString*)mimeType;

@end
