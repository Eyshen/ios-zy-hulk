//
//  main.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/4/3.
//  Copyright © 2019 Eason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
#ifdef DEBUG
        NSLog(@"启动时间Main：%f",CFAbsoluteTimeGetCurrent());
#endif
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
