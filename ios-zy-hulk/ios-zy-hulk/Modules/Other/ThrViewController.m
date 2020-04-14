//
//  ThrViewController.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/10/10.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "ThrViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"

@interface ThrViewController ()

@end

@implementation ThrViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    jumpBtn.frame = CGRectMake(150, 300, 220, 60);
    jumpBtn.backgroundColor = [UIColor yellowColor];
    [jumpBtn addTarget:self action:@selector(jumpClick:) forControlEvents:UIControlEventTouchUpInside];
    [jumpBtn setTitle:@"跳转1" forState:UIControlStateNormal];
    [jumpBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:jumpBtn];
    jumpBtn.tag = 10;
    
    UIButton *jumpBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    jumpBtn1.frame = CGRectMake(150, 400, 220, 60);
    jumpBtn1.backgroundColor = [UIColor yellowColor];
    [jumpBtn1 addTarget:self action:@selector(jumpClick:) forControlEvents:UIControlEventTouchUpInside];
    [jumpBtn1 setTitle:@"跳转2" forState:UIControlStateNormal];
    [jumpBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:jumpBtn1];
    jumpBtn1.tag = 11;
    
    UIButton *jumpBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    jumpBtn2.frame = CGRectMake(150, 500, 220, 60);
    jumpBtn2.backgroundColor = [UIColor yellowColor];
    [jumpBtn2 addTarget:self action:@selector(jumpClick:) forControlEvents:UIControlEventTouchUpInside];
    [jumpBtn2 setTitle:@"跳转3" forState:UIControlStateNormal];
    [jumpBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:jumpBtn2];
    jumpBtn2.tag = 12;
}
-(void)jumpClick:(UIButton *)sender{
    if(sender.tag == 10){
        OneViewController *one = [[OneViewController alloc]init];
        [self.navigationController pushViewController:one animated:YES];
    }else if(sender.tag == 11){
        TwoViewController *one = [[TwoViewController alloc]init];
        [self.navigationController pushViewController:one animated:YES];
    }else if(sender.tag == 12){
        ThrViewController *one = [[ThrViewController alloc]init];
        [self.navigationController pushViewController:one animated:YES];
    }
    
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
