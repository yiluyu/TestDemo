//
//  RunLoopVC004.m
//  TestDemo
//
//  Created by yu on 2020/2/12.
//  Copyright © 2020 yu. All rights reserved.
//

/**
 要注意有一些 GCD 的 API 不一定会激活 runloop，需要自己去手动激活一下
 */


#import "RunLoopVC004.h"

@interface RunLoopVC004 ()

@end

@implementation RunLoopVC004

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"1");
    
    dispatch_queue_t queue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        // 这个 API 是不会启用内部 runloop 的
        [self performSelector:@selector(show) withObject:nil afterDelay:0];
        // 这个 API 必须传入 waitUntilDone:YES 才会激活内部 runloop
        [self performSelector:@selector(show) onThread:[NSThread currentThread] withObject:nil waitUntilDone:NO];
        
        // 解决上面不激活 runloop 问题
        [[NSRunLoop currentRunLoop] run];
    });
    
    NSLog(@"3");
}

- (void)show {
    NSLog(@"asd");
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
