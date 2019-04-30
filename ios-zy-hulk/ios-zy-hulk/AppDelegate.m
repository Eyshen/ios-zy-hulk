//
//  AppDelegate.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/4/3.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ZYCrashProtector.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef DEBUG
    NSLog(@"%f",CFAbsoluteTimeGetCurrent());
#endif
    [ZYCrashProtectorManager enabledCrashProtector:ZYCrashProtectorTypeAll];//开启保护
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:ZYCrashProtectorNotification object:nil];
    
    self.window =[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window setRootViewController:[[ViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealwithCrashMessage:(NSNotification *)note {
    //异常拦截并且通过bugly上报
    
    NSDictionary *info = note.userInfo;
    NSString *errorReason = [NSString stringWithFormat:@"【ErrorReason】%@========【ErrorPlace】%@========【DefaultToDo】%@========【ErrorName】%@", info[@"errorReason"], info[@"errorPlace"], info[@"defaultToDo"], info[@"errorName"]];
//    NSArray *callStack = info[@"callStackSymbols"];
    
    NSLog(@"%@",errorReason);
}



- (void)applicationWillResignActive:(UIApplication *)application {
   
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
