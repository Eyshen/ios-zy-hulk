//
//  HomeViewController.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/5/6.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeInfoHttpRequest.h"

#import "ZYPostRequest.h"

#import "BTYRatePicker.h"


@interface HomeViewController ()<BTYRatePickerDelegate>

@end

@implementation HomeViewController


-(void)initDataSource{
    [super initDataSource];
    //显示
    [SMCallTrace startWithMaxDepth:0];
    self.dataSource = @[@"Message1",
                        @"Message2",
                        @"Message3",
                        @"Message4",
                        @"Message5",
                        @"Message6",];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //显示
    [SMCallTrace startWithMaxDepth:0];
    
    BTYRatePicker * refRatePicker = [[BTYRatePicker alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 80) wordsArray:@[@"one",@"two",@"thr",@"fou"] colorsArray:@[[UIColor yellowColor],[UIColor whiteColor],[UIColor orangeColor],[UIColor yellowColor]]];
    refRatePicker.delegate = self;
    [self.view addSubview:refRatePicker];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //消失
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [SMCallTrace stopSaveAndClean];
    });
}

-(void)didSelectCellWithTitle:(NSString *)title{
//    UIViewController *vc = nil;
    if ([title isEqualToString:@"Message1"]){
        NSLog(@"%@",title);
        [self queryHomeData];
    }
    if ([title isEqualToString:@"Message2"]){
        NSLog(@"%@",title);
    }
}

-(void) queryHomeData{
//    HomeInfoHttpRequest *homeInfoApi = [[HomeInfoHttpRequest alloc]init];
//    [homeInfoApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSString *responseString = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
//        NSLog(@"loginResponse Success:%@",responseString);
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSString *responseString = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
//        NSLog(@"loginResponse Error:%@",responseString);
//    }];
    
    
    
//    ZYPostRequest * request = [[ZYPostRequest alloc] initWithRequestUrl:@"students-api/api/index/pad/indexInfo" argument:@{}];
//    [request startWithCompletionBlockWithSuccess:^(__kindof ZYBaseRequest *request, NSDictionary *result, BOOL success) {
//        NSLog(@"loginResponse Success:%@",result);
//    } failure:^(__kindof ZYBaseRequest *request, NSString *errorInfo) {
//        NSLog(@"loginResponse Success:%@",errorInfo);
//    }];
}

-(void)setupNavigationItems{
    [super setupNavigationItems];
    self.title = @"学习";
    
}

@end
