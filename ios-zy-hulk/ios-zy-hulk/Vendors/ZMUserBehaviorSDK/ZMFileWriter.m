//
//  FileWriter.m
//  ZMPerformanceTestSDK
//
//  Created by jun on 2019/8/28.
//  Copyright © 2019 jun. All rights reserved.
//

#import "ZMFileWriter.h"

static NSTimeInterval luanchTime = 0;
static NSFileHandle *fileHandle = nil;
@implementation ZMFileWriter

+ (void)load {
    luanchTime = [[NSDate date] timeIntervalSince1970];
}

+ (void)writeDic:(NSDictionary *)dic {
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *dicString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (error == nil) {
        if (![[NSFileManager defaultManager] fileExistsAtPath:[self getFilePath]]) {
            NSLog(@"%@",@"创建文件");
            [dicString writeToFile:[self getFilePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        if (fileHandle == nil) {
            fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self getFilePath]];
        }
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[@"\n---------\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle writeData:data];        
    }
}

+ (NSString *)getFilePath {
    
    NSString *docmentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [docmentDir stringByAppendingPathComponent:[NSString stringWithFormat:@"apm_%.1f.json",luanchTime]];
}

@end
