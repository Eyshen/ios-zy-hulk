//
//  AppDelegate.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/4/3.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
//#import "ZYCrashProtector.h"

#import "QDUIHelper.h"
#import "QDCommonUI.h"
#import "QDTabBarViewController.h"
#import "QDNavigationController.h"

#import "HomeViewController.h"
#import "AddressViewController.h"
#import "FindViewController.h"
#import "MyViewController.h"

//#import "YTKNetwork.h"
//#import "ZMAppAnalyticsDataStorage.h"
//#import "ZMMobClick.h"
#import "CocoaLumberjack.h"
#import <AdSupport/ASIdentifierManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
#ifdef DEBUG
    NSLog(@"启动时间App delegate：%f",CFAbsoluteTimeGetCurrent());
#endif
//    [ZYCrashProtectorManager enabledCrashProtector:ZYCrashProtectorTypeAll];//开启保护
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:ZYCrashProtectorNotification object:nil];
    
    //DDLlog配置
    [self logConfig];
    
    //配置事件统计
//    [ZMMobClick registerAppConfig:[ZMAnalyticsConfig instanceWithUserId:@"123456" andAppId:@"666" andAppCode:@"686" policy:ZMReportPolicyRealTime] dataStoreage:[ZMAppAnalyticsDataStorage sharedInstance]];
    
    //QD自定义的全局样式渲染
    [QDCommonUI renderGlobalAppearances];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [QDUIHelper qmuiEmotions];
    });
    
    //域名配置
//    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
//    config.baseUrl = @"https://appapi-test.zmlearn.com";
    
//    config.securityPolicy.allowInvalidCertificates = YES;
//
//    config.securityPolicy.validatesDomainName = NO;
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    ZYLogDebug(@"UUID 唯一标识:%@",result);
    
    //界面
    self.window =[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self createTabBarController];
    //启动动画
    [self startLaunchingAnimation];
    return YES;
}
-(void)logConfig {
#ifdef DEBUG
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:DDLogLevelAll];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
#else
    [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:DDLogLevelError];
#endif
}

-(void)createTabBarController{
    QDTabBarViewController *tabBarViewController = [[QDTabBarViewController alloc]init];
    
    //Home
    HomeViewController *homeVc = [[HomeViewController alloc]init];
    homeVc.hidesBottomBarWhenPushed = NO;
    QDNavigationController *homeNavC = [[QDNavigationController alloc]initWithRootViewController:homeVc];
    homeNavC.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"学习" image:[UIImageMake(@"tabbar_mainframe") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"tabbar_mainframeHL") tag:0];
    AddAccessibilityHint(homeNavC.tabBarItem, @"聊天");
    
    //Address
    AddressViewController *addressVc = [[AddressViewController alloc]init];
    addressVc.hidesBottomBarWhenPushed = NO;
    QDNavigationController *addressNavC = [[QDNavigationController alloc]initWithRootViewController:addressVc];
    addressNavC.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"通讯录" image:[UIImageMake(@"tabbar_contacts") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"tabbar_contactsHL") tag:0];
    AddAccessibilityHint(addressNavC.tabBarItem, @"通讯录");
    
    //Find
    FindViewController *findVc = [[FindViewController alloc]init];
    findVc.hidesBottomBarWhenPushed = NO;
    QDNavigationController *findNavC = [[QDNavigationController alloc]initWithRootViewController:findVc];
    findNavC.tabBarItem =  [QDUIHelper tabBarItemWithTitle:@"朋友圈" image:[UIImageMake(@"tabbar_discover") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"tabbar_discoverHL") tag:0];
    AddAccessibilityHint(findNavC.tabBarItem, @"朋友圈");
    
    //My
    MyViewController *myVc = [[MyViewController alloc]init];
    myVc.hidesBottomBarWhenPushed = NO;
    QDNavigationController *myNavC = [[QDNavigationController alloc]initWithRootViewController:myVc];
    myNavC.tabBarItem = [QDUIHelper tabBarItemWithTitle:@"我" image:[UIImageMake(@"tabbar_me") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"tabbar_meHL") tag:0];
    AddAccessibilityHint(myNavC.tabBarItem, @"我");
    
    // window root controller
    tabBarViewController.viewControllers = @[homeNavC, addressNavC, findNavC , myNavC];
    self.window.rootViewController = tabBarViewController;
    [self.window makeKeyAndVisible];
}

-(void)startLaunchingAnimation{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    UIView *launchScreenView = [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil].firstObject;
    launchScreenView.frame = window.bounds;
    [window addSubview:launchScreenView];
    
    UIImageView *backgroundImageView = launchScreenView.subviews[0];
    backgroundImageView.clipsToBounds = YES;
    
    UIImageView *logoImageView = launchScreenView.subviews[1];
    UILabel *copyrightLabel = launchScreenView.subviews.lastObject;
    
    UIView *maskView = [[UIView alloc] initWithFrame:launchScreenView.bounds];
    maskView.backgroundColor = UIColorWhite;
    [launchScreenView insertSubview:maskView belowSubview:backgroundImageView];
    
    [launchScreenView layoutIfNeeded];
    
    
    [launchScreenView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:@"bottomAlign"]) {
            obj.active = NO;
            [NSLayoutConstraint constraintWithItem:backgroundImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:launchScreenView attribute:NSLayoutAttributeTop multiplier:1 constant:NavigationContentTop].active = YES;
            *stop = YES;
        }
    }];
    
    [UIView animateWithDuration:.15 delay:0.9 options:QMUIViewAnimationOptionsCurveOut animations:^{
        [launchScreenView layoutIfNeeded];
        logoImageView.alpha = 0.0;
        copyrightLabel.alpha = 0;
    } completion:nil];
    [UIView animateWithDuration:1.2 delay:0.9 options:UIViewAnimationOptionCurveEaseOut animations:^{
        maskView.alpha = 0;
        backgroundImageView.alpha = 0;
    } completion:^(BOOL finished) {
        [launchScreenView removeFromSuperview];
    }];
}


#pragma mark --APPCrashProtectorNotification
- (void)dealwithCrashMessage:(NSNotification *)note {
    //异常拦截并且通过bugly上报
    NSDictionary *info = note.userInfo;
    NSString *errorReason = [NSString stringWithFormat:@"【ErrorReason】%@========【ErrorPlace】%@========【DefaultToDo】%@========【ErrorName】%@", info[@"errorReason"], info[@"errorPlace"], info[@"defaultToDo"], info[@"errorName"]];
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
