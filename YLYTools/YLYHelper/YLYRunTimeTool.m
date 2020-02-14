//
//  YLYRunTimeTool.m
//  TestDemo
//
//  Created by yu on 2020/2/12.
//  Copyright © 2020 yu. All rights reserved.
//

#import "YLYRunTimeTool.h"

@implementation YLYRunTimeTool

// 交换方法
+ (void)exchangeInstanceMethod:(SEL)oldSELT toNewMethod:(SEL)newSELT class:(Class)ClassT {
    Method oldMethod = class_getInstanceMethod(ClassT, oldSELT);
    Method newMethod = class_getInstanceMethod(ClassT, newSELT);
    
    // 尝试对原来的SEL添加method跟impl
    BOOL canAddMethod = class_addMethod(ClassT, oldSELT, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    
    if (canAddMethod) {
        // 把新的SEL对应添加上原来的method跟impl
        class_replaceMethod(ClassT, newSELT, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    } else {
        // 原来的SEL有对应的method跟impl
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

@end
