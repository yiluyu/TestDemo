//
//  YLYRunTimeTool.h
//  TestDemo
//
//  Created by yu on 2020/2/12.
//  Copyright © 2020 yu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLYRunTimeTool : NSObject

/// 交换实例方法
+ (void)exchangeInstanceMethod:(SEL)oldSELT toNewMethod:(SEL)newSELT class:(Class)ClassT;

@end

NS_ASSUME_NONNULL_END
