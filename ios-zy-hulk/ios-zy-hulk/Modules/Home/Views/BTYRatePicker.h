//
//  BTYDatePicker.h
//  batiaoyuappios
//
//  Created by 花有重开 on 2017/7/4.
//  Copyright © 2017年 baolan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BTYRatePickerDelegate <NSObject>
@optional
-(void)datePicker:(id)sender DidStopOnContent:(NSString *)content;
-(void)datePicker:(id)sender DidStopOnIndex:(NSInteger)index;
@end

@interface BTYRatePicker : UIView
@property(nonatomic,weak)id<BTYRatePickerDelegate>delegate;
@property(nonatomic,copy)NSArray *words;
-(instancetype)initWithFrame:(CGRect)frame wordsArray:(NSArray <NSString *> *)array colorsArray:(NSArray <UIColor *> *)colors;
-(void)resetAnimation;
//didappear 时调用
-(void)becomeVisible;

@end
