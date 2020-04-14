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
    self.view.backgroundColor = [UIColor clearColor];
    
    UILabel *refName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    refName.text = @"Wellcome to Hulk World!";
    refName.font = [UIFont systemFontOfSize:30];
    refName.textAlignment = NSTextAlignmentCenter;
    refName.textColor = [UIColor lightGrayColor];
    [self.view addSubview:refName];
    _refNameLabel = refName;
    
    [SMCallTrace stop];
    [SMCallTrace save];
//    [self performSelector:@selector(protectorAPP) withObject:self afterDelay:10];
//    [self testMethod];
//    NSDictionary *dic = @{@"1":@"1",
//                          @"2":@"2",
//                          @"3":@"3",
//                          @"4":@"4",
//                          };
//    NSLog(@"字典:%d",(int)dic.count);
    
}

-(void) protectorAPP{
    NSArray *arr = @[@"1",@"2",@"3",@"4",@"5"];
    _refNameLabel.text = arr[6];
    _refNameLabel.text = @"发生array越界 crash";
    [self performSelector:@selector(protectorAPPone) withObject:self afterDelay:2];
}

-(void)testMethod{
//    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@(6),@(1),nil];
//    [self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count - 1];
//    NSLog(@"快速%@",arr);
//    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@(6),@(1),nil];
//    [self maopaoSortArray:arr];
//    NSLog(@"冒泡%@",arr);
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@(6),@(1),nil];
    [self selectSortArray:arr];
    NSLog(@"选择:%@",arr);
}

-(void)selectSortArray:(NSMutableArray *)array{
    int len = (int)array.count;
    int minIndex = 0;
    id temp;
    for (int i = 0; i<len-1; i++) {
        minIndex = i;
        for (int j = i+1; j < len; j++) {
            if(array[j]<array[minIndex]){
                minIndex = j;
            }
        }
        temp = array[i];
        array[i] = array[minIndex];
        array[minIndex] = temp;
    }
}

-(void)maopaoSortArray:(NSMutableArray *)array{
    int len = (int)array.count - 1;
    for (int i = 0; i<len; i++) {
        for (int j = 0; j<len-i; j++) {
            if ([array[j] intValue] > [array[j+1] intValue]) {
                id temp = array[j+1];
                array[j+1] = array[j];
                array[j]   = temp;
            }
        }
    }
}


- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex{
    if(leftIndex >= rightIndex){
        return;
    }
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    
    NSInteger key = [array[i] integerValue];
    while (i<j) {
        while (i<j&&[array[j] integerValue] >= key) {
            j--;
        }
        array[i] = array[j];
        while (i<j&&[array[i] integerValue] <= key) {
            i++;
        }
        array[j] = array[i];
    }
    array[i] = @(key);
    
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i-1];
    [self quickSortArray:array withLeftIndex:i+1 andRightIndex:rightIndex];
}

-(void) protectorAPPone{
    _refNameLabel.text = @"protector app success";
}
@end
