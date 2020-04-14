//
//  BTYDatePicker.m
//  batiaoyuappios
//
//  Created by 花有重开 on 2017/7/4.
//  Copyright © 2017年 baolan. All rights reserved.
//

#import "BTYRatePicker.h"
#import <QuartzCore/QuartzCore.h>
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))
#define Screen_height  [[UIScreen mainScreen] bounds].size.height
#define Screen_width  [[UIScreen mainScreen] bounds].size.width

#pragma mark 部分UI参数
#define thumb_width (29)
#define thumb_height (29)
#define thumb_image_name (@"big")
#define bottom_background_color ([UIColor whiteColor].CGColor)

#define animation_duration (2)
#define scale_values (@[@(0.6),@(1),@(1.4),@(2)])
#define scale_keytimes (@[@(0),@(0.5),@(0.8),@(1.0)])
#define alpha_values (@[@(0),@(0.8),@(1),@(0.4),@(0)])
#define alpha_keytimes (@[@(0),@(0.1),@(0.5),@(0.8),@(1.0)])
#define trans_values (@[@(Screen_width/7),@(0),@(-Screen_width/9),@(-Screen_width/3)])
#define trans_keytimes (@[@(0),@(0.5),@(0.8),@(1.0)])
#define words_layer_font_size (self.frame.size.height/2)

#define line_height (10)
#define line_width (2)
#define word_height (14)
#define word_width (self.frame.size.width/(self.words.count-1))
#define scale_layer_font_size (12)
#define line_jump_height (20)
#define text_scale (1.3)
#define text_color ([UIColor whiteColor])

#pragma mark 中部文字

@interface WordsLayer : CALayer
@property(nonatomic,copy)NSArray<NSString *>* words;
+(instancetype)layerWithFrame:(CGRect)frame;
-(void)resetAnimation;
@end

@implementation WordsLayer

+(instancetype)layerWithFrame:(CGRect)frame {
    WordsLayer *layer = [super layer];
    if (layer) {
        layer.frame = frame;
        layer.speed = 0;
    }
    return layer;
}

-(void)dealloc {
    
    [self removeAllSublayers];
    [self removeAllAnimations];
}
- (void)removeAllSublayers {
    while (self.sublayers.count) {
        [self.sublayers.lastObject removeFromSuperlayer];
    }
}
#pragma mark 传值
-(void)setWords:(NSArray<NSString *> *)words {
    _words = words;
    [self resetAnimation];
}
#pragma mark 刷新动画
-(void)resetAnimation {
    
    [self removeAllSublayers];
    for (NSInteger i = 0; i<self.words.count; i++) {
        NSString *content = [self.words objectAtIndex:i];
        CATextLayer *layer = [self pieceLayer:content delay:(CGFloat)i];
        [self addSublayer:layer];
    }
}
#pragma mark 工厂
-(CATextLayer *)pieceLayer:(NSString *)content delay:(CGFloat)delay {
    
    __block CATextLayer * theLayer = [CATextLayer layer];
    
    theLayer.opacity = 0.0;
    
    [theLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    NSAttributedString *mutStr = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:words_layer_font_size],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    theLayer.string = mutStr;
    theLayer.truncationMode = kCATruncationMiddle;
    theLayer.alignmentMode = kCAAlignmentCenter;
    theLayer.contentsScale = [UIScreen mainScreen].scale;
    
    CAKeyframeAnimation *scaleAni = [CAKeyframeAnimation animation];
    scaleAni.keyPath = @"transform.scale";
    scaleAni.values = scale_values;
    scaleAni.keyTimes = scale_keytimes;
    scaleAni.duration = animation_duration;
    scaleAni.beginTime = self.timeOffset+delay;
    
    [theLayer addAnimation:scaleAni forKey:@"sca"];
    
    CAKeyframeAnimation *alphaAni = [CAKeyframeAnimation animation];
    alphaAni.keyPath = @"opacity";
    alphaAni.values = alpha_values;
    alphaAni.keyTimes = alpha_keytimes;
    alphaAni.duration = animation_duration;
    alphaAni.beginTime = self.timeOffset+delay;
    alphaAni.fillMode = kCAFillModeForwards;
    [theLayer addAnimation:alphaAni forKey:@"alp"];
    
    CAKeyframeAnimation *transAni = [CAKeyframeAnimation animation];
    transAni.keyPath = @"transform.translation.x";
    transAni.values = trans_values;
    transAni.keyTimes = trans_keytimes;
    transAni.duration = animation_duration;
    transAni.beginTime = self.timeOffset+delay;
    [theLayer addAnimation:transAni forKey:@"tra"];
    
    [theLayer setPosition:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    return theLayer;
}

@end

#pragma mark 底部刻度

@interface ScalesLayer : CALayer
@property(nonatomic,copy)NSArray<NSString *> * words;
+(instancetype)layerWithFrame:(CGRect)frame;
-(void)resetAnimation;
@end

@implementation ScalesLayer

+(instancetype)layerWithFrame:(CGRect)frame {
    ScalesLayer *layer = [super layer];
    if (layer) {
        layer.frame = frame;
        layer.speed = 0;
    }
    return layer;
}
-(void)dealloc {
    
    [self removeAllSublayers];
    [self removeAllAnimations];
}
#pragma mark 传值
-(void)setWords:(NSArray<NSString *> *)words {
    _words = words;
    [self resetAnimation];
}
#pragma mark 刷新动画
-(void)resetAnimation {
    [self removeAllSublayers];
    [self removeAllAnimations];
    for (NSInteger i = 0; i<self.words.count; i++) {
        [self addSublayer:[self lineLayerForIndex:i]];
        [self addSublayer:[self textlayerForIndex:i]];
    }
}
- (void)removeAllSublayers {
    while (self.sublayers.count) {
        [self.sublayers.lastObject removeFromSuperlayer];
    }
}
#pragma mark 工厂
-(CALayer *)lineLayerForIndex:(NSInteger )index {
    CALayer *layer = [CALayer layer];
    CGFloat onePiece = (self.frame.size.width)/(self.words.count-1);
    [layer setFrame:CGRectMake(0, 0, line_width, line_height)];
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [layer setPosition:CGPointMake(onePiece*index+line_width/2-line_width/2, self.frame.size.height-5-line_height/2)];
    layer.opacity = 0.6;
    
    CAKeyframeAnimation *transAni = [CAKeyframeAnimation animation];
    transAni.keyPath = @"transform.translation.y";
    transAni.values = @[@(0),@(-line_jump_height/30*self.words.count),@(-line_jump_height)];
    transAni.keyTimes = @[@(0),@(0.5),@(1)];
    transAni.duration = 2;
    transAni.autoreverses = true;
    transAni.beginTime = self.timeOffset+index-1;
    [layer addAnimation:transAni forKey:@"tra"];
    
    CAKeyframeAnimation *opaAni = [CAKeyframeAnimation animation];
    opaAni.keyPath = @"opacity";
    opaAni.values = @[@(0.6),@(0.65),@(1)];
    opaAni.keyTimes = @[@(0),@(0.5),@(1)];
    opaAni.duration = 2;
    opaAni.autoreverses = true;
    opaAni.beginTime = self.timeOffset+index-1;
    [layer addAnimation:opaAni forKey:@"opa"];
    
    return layer;
}

-(CATextLayer *)textlayerForIndex:(NSInteger )index {
    CATextLayer *theLayer = [CATextLayer layer];
    
    [theLayer setFrame:CGRectMake(0, 0, word_width, word_height)];
    NSString *content = [self.words objectAtIndex:index%self.words.count];
    theLayer.opacity = 0.6;
    
    NSAttributedString *mutStr = [[NSAttributedString alloc]initWithString:content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:scale_layer_font_size],NSForegroundColorAttributeName:text_color}];
    theLayer.string = mutStr;
    theLayer.alignmentMode = kCAAlignmentCenter;
    theLayer.contentsScale = [UIScreen mainScreen].scale;
    [theLayer setValue:@(0.8) forKeyPath:@"transform.scale"];
    
    CAKeyframeAnimation *transAni = [CAKeyframeAnimation animation];
    transAni.keyPath = @"transform.translation.y";
    transAni.values = @[@(0),@(-line_jump_height/30*self.words.count),@(-line_jump_height)];
    transAni.keyTimes = @[@(0),@(0.5),@(1)];
    transAni.duration = 2;
    transAni.autoreverses = true;
    transAni.beginTime = self.timeOffset+index-1;
    [theLayer addAnimation:transAni forKey:@"tra"];
    
    CAKeyframeAnimation *opaAni = [CAKeyframeAnimation animation];
    opaAni.keyPath = @"opacity";
    opaAni.values = @[@(0.6),@(0.65),@(1)];
    opaAni.keyTimes = @[@(0),@(0.5),@(1)];
    opaAni.duration = 2;
    opaAni.autoreverses = true;
    opaAni.beginTime = self.timeOffset+index-1;
    [theLayer addAnimation:opaAni forKey:@"opa"];
    
    CAKeyframeAnimation *scaleAni = [CAKeyframeAnimation animation];
    scaleAni.keyPath = @"transform.scale";
    scaleAni.values = @[@(0.8),@(0.8+(text_scale-0.8)/30*self.words.count),@(text_scale)];
    scaleAni.keyTimes = @[@(0),@(0.5),@(1)];
    scaleAni.duration = 2;
    scaleAni.autoreverses = true;
    scaleAni.beginTime = self.timeOffset+index-1;
    [theLayer addAnimation:scaleAni forKey:@"sca"];
    
    CGFloat onePiece = (self.frame.size.width)/(self.words.count-1);
    [theLayer setPosition:CGPointMake(onePiece*index, self.frame.size.height-10-word_height/2-line_height)];
    
    return  theLayer;
}

@end
#pragma mark 整体实现
@interface BTYRatePicker ()
@property(nonatomic,strong)UISlider *dateSlider;
@property(nonatomic,strong)WordsLayer *wordsLayer;
@property(nonatomic,strong)CAShapeLayer *bottomLayer;
@property(nonatomic,strong)ScalesLayer *scaleLayer;
@end
@implementation BTYRatePicker {
    CAGradientLayer *_bgLayer;
    NSTimer *_timer;
    NSInteger _timerCount;
    NSInteger _theIndex;
}

- (instancetype)initWithFrame:(CGRect)frame wordsArray:(NSArray<NSString *> *)array colorsArray:(NSArray<UIColor *> *)colors
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, MAX(frame.size.width, frame.size.height), MAX(frame.size.width, frame.size.height))];
    NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:colors.count];
    for (UIColor *color in colors) {
        [temp addObject:(id)color.CGColor];
    }
    if (self) {
        [self addBackGroundLayer:temp];
        _theIndex = -1;
        self.words = array;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (becomeForeGround) name: UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark 传值
-(void)setWords:(NSArray *)words {
    NSString *string = [words componentsJoinedByString:@""];
    NSString *currentString = [_words componentsJoinedByString:@""];
    if (IsArrEmpty(words)||[string isEqualToString:currentString]) {
        return;
    }
    _words = words;
    [self flyWords:self.words];
    [self.layer addSublayer:self.scaleLayer];
    [self.scaleLayer setWords:self.words];
    [self.layer addSublayer:self.bottomLayer];
    [self addSubview:self.dateSlider];

}
#pragma mark 刷新动画与刷新初始值
-(void)becomeForeGround {
    [self resetAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self becomeVisible];
    });
}
-(void)resetAnimation {
    [self.dateSlider setValue:0.0];
    
    [self addBgAnimation];
    
    [self.wordsLayer removeFromSuperlayer];
    self.wordsLayer = nil;
    [self flyWords:self.words];
    
    self.wordsLayer.timeOffset = 0.0;
    self.scaleLayer.timeOffset = 0.0;
    
    [self.scaleLayer resetAnimation];
}
-(void)becomeVisible {
    [self sliderValueChange:self.dateSlider];
}
#pragma mark 添加背景
-(void)addBackGroundLayer:(NSArray *)colors {
    _bgLayer = [[CAGradientLayer alloc]init];
    [_bgLayer setFrame:CGRectMake(0, 0, self.frame.size.width*colors.count, self.frame.size.height*colors.count)];
    [_bgLayer setColors:colors];
    _bgLayer.startPoint = CGPointMake(0, 1);
    _bgLayer.endPoint = CGPointMake(1, 0);
    [_bgLayer setAnchorPoint:CGPointMake(0.5, 0.5)];
    [_bgLayer setPosition:CGPointMake(_bgLayer.frame.size.width/2, -_bgLayer.frame.size.height/2+self.frame.size.height)];
    
    CGFloat piece = 1.0/(colors.count - 1);
    NSMutableArray *locations = [[NSMutableArray alloc]initWithCapacity:4];
    for (int i = 0; i<colors.count; i++) {
        [locations addObject:@(piece*i)];
    }
    
    [_bgLayer setLocations:locations];
    self.clipsToBounds = true;
    
    _bgLayer.speed = 0.0;
    [self addBgAnimation];
    [self.layer addSublayer:_bgLayer];
}

-(void)addBgAnimation {
    [_bgLayer removeAllAnimations];
    _bgLayer.timeOffset = 0.0;
    CABasicAnimation * bgAniX = [CABasicAnimation animation];
    bgAniX.keyPath = @"position.x";
    bgAniX.fromValue = @(_bgLayer.frame.size.width/2);
    bgAniX.toValue = @(-_bgLayer.frame.size.width/2+self.frame.size.width);
    bgAniX.duration = self.words.count - 1;
    [_bgLayer addAnimation:bgAniX forKey:@"bgAniX"];
    
    CABasicAnimation * bgAniY = [CABasicAnimation animation];
    bgAniY.keyPath = @"position.y";
    bgAniY.fromValue = @(-_bgLayer.frame.size.height/2+self.frame.size.height);
    bgAniY.toValue = @(_bgLayer.frame.size.height/2);
    bgAniY.duration = self.words.count - 1;
    [_bgLayer addAnimation:bgAniY forKey:@"bgAniY"];
}
#pragma mark 添加中部文字
-(void)flyWords:(NSArray *)words {
    [self.wordsLayer setWords:words];
    [self.layer addSublayer:self.wordsLayer];
}
-(WordsLayer *)wordsLayer {
    if (!_wordsLayer) {
        _wordsLayer = [WordsLayer layerWithFrame:CGRectMake(0, self.frame.size.height/3, self.frame.size.width, self.frame.size.height/3)];
    }
    return _wordsLayer;
}
#pragma mark 添加刻度文字
-(ScalesLayer *)scaleLayer {
    if (!_scaleLayer) {
        _scaleLayer = [ScalesLayer layerWithFrame:CGRectMake(10+thumb_width/2, self.frame.size.height*4/5 - self.frame.size.height/20 - 5, self.frame.size.width-20-thumb_width, self.frame.size.height/5)];
    }
    return _scaleLayer;
}
#pragma mark 正态分布曲线图层
-(CAShapeLayer *)bottomLayer {
    if(!_bottomLayer) {
        _bottomLayer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(-self.frame.size.width, self.frame.size.height*19/20-5, self.frame.size.width*3, self.frame.size.height/20 + 5)];
        [path moveToPoint:CGPointMake(10-2*thumb_width, self.frame.size.height*19/20-5)];
        CGFloat cigma = sqrt(0.618);
        //控制曲线形态的两个参数
        CGFloat miu = 0;
        CGFloat ratio = 2;
        for (CGFloat i = 0; i<2*ratio+0.03; i+=0.03) {
            CGFloat x = i-ratio;
            //正态分布曲线方程
            CGFloat equationY = 1/(cigma*sqrt(2*M_PI))*pow(2.718281828, (-pow((x-miu), 2)/(2*pow(cigma, 2))));
            CGFloat valueY = self.frame.size.height - equationY*thumb_height- self.frame.size.height/20 - 5;
            CGFloat valueX = (10+thumb_width/2) + (thumb_width*3/ratio/2)*x;
            [path addLineToPoint:CGPointMake(valueX, valueY)];
        }
        [path addLineToPoint:CGPointMake(10+3*thumb_width, self.frame.size.height*19/20-5)];
        [path closePath];
        _bottomLayer.fillColor = bottom_background_color;
        _bottomLayer.path = path.CGPath;
        [path fill];
    }
    return _bottomLayer;
}
#pragma mark 滑动选择器和响应事件
-(UISlider *)dateSlider {
    if (!_dateSlider) {
        _dateSlider = [[UISlider alloc]initWithFrame:CGRectMake(10, self.frame.size.height*0.9, self.frame.size.width-20, self.frame.size.height/10)];
        _dateSlider.maximumValue =  self.words.count;
        [_dateSlider setThumbImage:[UIImage imageNamed:thumb_image_name] forState:UIControlStateNormal];
        [_dateSlider addTarget: self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
        [_dateSlider addTarget:self action:@selector(sliderDragEnd:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
        _dateSlider.minimumTrackTintColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        _dateSlider.maximumTrackTintColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        _dateSlider.minimumValue = 1;
    }
    return _dateSlider;
}
-(void)sliderValueChange:(UISlider *)sender {
    CGFloat value = sender.value;
    [_bgLayer setTimeOffset:value - 1];
    [_wordsLayer setTimeOffset:value];
    [_scaleLayer setTimeOffset:value];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [_bottomLayer setValue:@((self.frame.size.width-self.dateSlider.frame.origin.x*2-thumb_width)/(self.words.count-1)*(value-1)) forKeyPath:@"transform.translation.x"];
    [CATransaction commit];
    NSInteger index = lroundf(value);
    [self dealSelectedEvent:index];
}
-(void)sliderDragEnd:(UISlider *)sender {
    CGFloat value = sender.value;
    NSInteger intValue = lroundf(value);
    [sender setValue:intValue animated:true];
    CGFloat piece = (intValue - _wordsLayer.timeOffset)/120;
    _timerCount = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1/60 target:self selector:@selector(timerAction:) userInfo:@{@"piece":@(piece)} repeats:true];
    
    [_bgLayer setTimeOffset:(intValue - 1)];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [_bottomLayer setValue:@((self.frame.size.width-self.dateSlider.frame.origin.x*2-thumb_width)/(self.words.count-1)*(intValue-1)) forKeyPath:@"transform.translation.x"];
    [CATransaction commit];
    [self dealSelectedEvent:intValue];
}

-(void)timerAction:(NSTimer *)timer {
    CGFloat piece = [[timer.userInfo objectForKey:@"piece"] floatValue];
    [_wordsLayer setTimeOffset:_wordsLayer.timeOffset + piece];
    _timerCount ++;
    if (_timerCount == 120) {
        [_timer invalidate];
        _timerCount = 0;
    }
}

-(void)dealSelectedEvent:(NSInteger)index {
    if (index-1 != _theIndex) {
        _theIndex = index - 1;
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(datePicker:DidStopOnIndex:)]) {
                [self.delegate datePicker:self DidStopOnIndex:_theIndex];
            }
            if ([self.delegate respondsToSelector:@selector(datePicker:DidStopOnContent:)]) {
                [self.delegate datePicker:self DidStopOnContent:[self.words objectAtIndex:_theIndex]];
            }
        }
    }
}
@end

