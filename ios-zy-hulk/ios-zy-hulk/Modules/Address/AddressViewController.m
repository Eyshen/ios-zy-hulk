//
//  AddressViewController.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/5/6.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "AddressViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThrViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel * alabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 80, 214, 600)];
    alabel.backgroundColor = [UIColor yellowColor];
    alabel.textAlignment = NSTextAlignmentCenter;
    alabel.center = self.view.center;
    alabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    alabel.text = @"学习强国";
    [self.view addSubview:alabel];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
