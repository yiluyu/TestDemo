//
//  UITableView+HookProtocol.m
//  TestDemo
//
//  Created by yu on 2020/2/12.
//  Copyright © 2020 yu. All rights reserved.
//

#import "UITableView+HookProtocol.h"
#import "YLYRunTimeTool.h"

@implementation UITableView (HookProtocol)

- (void)startHook {
    // 过滤是否是tableview代理类
    if (self.delegate
        && [self.delegate conformsToProtocol:@protocol(UITableViewDelegate)]) {
        if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            // 获取delegate的method
            Method delegateMethod = class_getInstanceMethod([self.delegate class], @selector(tableView:didSelectRowAtIndexPath:));
            Method hookMethod = class_getInstanceMethod([self class], @selector(new_tableView:didSelectRowAtIndexPath:));
            
            // 把delegate的class跟自己的交换
            method_exchangeImplementations(delegateMethod, hookMethod);
        }
    }
}

- (void)new_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @try {
        // 这里的 self 是 self.delegate，应该是tableview内部处理的结果，不能直接使用self，而是需要拿到tableview实例
        [tableView new_tableView:tableView didSelectRowAtIndexPath:indexPath];
        NSLog(@"点击%ld", (long)indexPath.row);
    } @catch (NSException *exception) {
        NSLog(@"exception = %@", exception);
    } @finally {
        ;
    }
}

@end
