//
//  UITableView+HookProtocol.h
//  TestDemo
//
//  Created by yu on 2020/2/12.
//  Copyright © 2020 yu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HookProtocol)

/// 开启hook
- (void)startHook;

@end

NS_ASSUME_NONNULL_END
