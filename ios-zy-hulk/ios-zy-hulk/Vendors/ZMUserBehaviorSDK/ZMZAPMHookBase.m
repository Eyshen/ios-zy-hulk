//
//  HookBase.m
//  ZMLog
//
//  Created by jun2 on 2019/5/7.
//  Copyright © 2019 jun2. All rights reserved.
//

#import "ZMZAPMHookBase.h"
#import "objc/runtime.h"


@implementation ZMZAPMHookBase

+ (void)hookClass:(Class)classObject
 originalSelector:(SEL)originalSelector
 swizzledSelector:(SEL)swizzledSelector {
    //第三版Hook核心思想是，
    //如果本类中有 originalSelector 方法，直接交换。
    //如果本类中没有 originalSelector 方法，添加父类的的方法到子类，然后再直接交换。
    
    Method originalMethod = class_getInstanceMethod(classObject, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(classObject, swizzledSelector);
    
    //class_addMethod 添加的SEL是 originalSelector ，IMP 是 method_getImplementation(originalMethod)，我称他们为原配，
    //如果本类中，已经有 originalSelector，再添加 originalSelector， 肯定返回NO，添加失败，那就直接交换了，跟第一版hook流程一模一样了,
    //如果本类中，没有此SEL，那就会去父类里找，返回的就是父类里的信息，然后将父类的信息，添加到本类中，就相当于，本类完全的继承了父类的方法，
    BOOL didAddMethod = class_addMethod(classObject, originalSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    if (didAddMethod) {
        //添加成功后，本类中，已经有一个originalSelector方法了
        //我们第一次获得originalMethod是返回父类的originalMethod
        //我们需要再重新获得一下originalMethod，这次返回的不是父类的originalMethod
        //而是我们刚刚class_addMethod添加的到本类的originalMethod
        originalMethod = class_getInstanceMethod(classObject, originalSelector);
    }
    //走到这，就证明了，本类中肯定已经有这两个方法了，那就这样直接交换吧。
    method_exchangeImplementations(swizzledMethod, originalMethod);
}

+ (void)hookClassOut:(Class)targetClass
        currentClass:(Class)currentClass
    originalSelector:(SEL)originalSelector
    swizzledSelector:(SEL)swizzledSelector {
    
    Class class = targetClass;

    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    
    if (originalMethod == NULL) {
        return;
    }
    
    Method swizzledMethod = class_getInstanceMethod(currentClass, swizzledSelector);//class和上面不一样
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    if (didAddMethod) {
        originalMethod = class_getInstanceMethod(class, originalSelector);
    }
    method_exchangeImplementations(swizzledMethod, originalMethod);
    
    //实现在外面调用交换也可以调用原始方法
    class_addMethod(class, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
}

+ (void)hookClassSelectorOut:(Class)targetClass
                currentClass:(Class)currentClass
            originalSelector:(SEL)originalSelector
            swizzledSelector:(SEL)swizzledSelector {
    
    Class class = targetClass;

    Method originalMethod = class_getClassMethod(class, originalSelector);
    
    if (originalMethod == NULL) {
        return;
    }
    
    Method swizzledMethod = class_getClassMethod(currentClass, swizzledSelector);//class和上面不一样
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    if (didAddMethod) {
        originalMethod = class_getClassMethod(class, originalSelector);
    }
    method_exchangeImplementations(swizzledMethod, originalMethod);
    
    //实现在外面调用交换也可以调用原始方法
    class_addMethod(class, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
}


@end
