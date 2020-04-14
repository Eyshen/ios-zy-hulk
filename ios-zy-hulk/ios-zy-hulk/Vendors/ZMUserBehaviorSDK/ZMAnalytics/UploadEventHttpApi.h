//
//  UploadEventHttpApi.h
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

#import "BaseZYHttpRequest.h"
#import "BaseZYHttpResponse.h"
#import "MsgBodyDTO.h"

@interface UploadEventHttpRequest : BaseZYHttpRequest

@property(nonatomic, strong) MsgBodyDTO *msgData;

@property (nonatomic,copy) NSDictionary *data;

@end


@interface UploadEventHttpResponse : BaseZYHttpResponse

@property(nonatomic, assign) int code;

@property(nonatomic, copy) NSString *message;

@end
