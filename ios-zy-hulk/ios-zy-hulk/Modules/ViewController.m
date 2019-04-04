//
//  ViewController.m
//  ios-zy-hulk
//
//  Created by 张学超 on 2019/4/3.
//  Copyright © 2019 Eason. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,weak) UILabel *refNameLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UILabel *refName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    refName.text = @"Wellcome to Hulk World!";
    refName.font = [UIFont systemFontOfSize:30];
    refName.textAlignment = NSTextAlignmentCenter;
    refName.textColor = [UIColor lightGrayColor];
    [self.view addSubview:refName];
    _refNameLabel = refName;
    [self performSelector:@selector(protectorAPP) withObject:self afterDelay:10];
}
-(void) protectorAPP{
    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5"];
    _refNameLabel.text = arr[6];
}

@end
