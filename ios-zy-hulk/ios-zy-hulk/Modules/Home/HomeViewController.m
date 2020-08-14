//
//  HomeViewController.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/5/6.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "HomeViewController.h"




#import "BTYRatePicker.h"


@interface HomeViewController ()<BTYRatePickerDelegate>

@end

@implementation HomeViewController


-(void)initDataSource{
    [super initDataSource];

    self.dataSource = @[@"Message1",
                        @"Message2",
                        @"Message3",
                        @"Message4",
                        @"Message5",
                        @"Message6",];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    BTYRatePicker * refRatePicker = [[BTYRatePicker alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 80) wordsArray:@[@"one",@"two",@"thr",@"fou"] colorsArray:@[[UIColor yellowColor],[UIColor whiteColor],[UIColor orangeColor],[UIColor yellowColor]]];
    refRatePicker.delegate = self;
    [self.view addSubview:refRatePicker];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}

-(void)didSelectCellWithTitle:(NSString *)title{

}

-(void) queryHomeData{

}

-(void)setupNavigationItems{
    [super setupNavigationItems];
    self.title = @"学习";
    
}

@end
