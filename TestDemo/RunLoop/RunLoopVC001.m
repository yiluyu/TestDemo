//
//  RunLoopVC001.m
//  TestDemo
//
//  Created by yu on 06/09/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "RunLoopVC001.h"

@interface RunLoopVC001 () {
    NSTimer *timer;
}

@end

@implementation RunLoopVC001

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self runLoopTest];
    
}

#pragma -mark NSRunLoop
- (void)runLoopTest {
    //定时器有几种触发方式
    //scheduledTimerWithTimeInterval 方法封装了 NSRunLoop 的处理, mode 使用的是 NSDefaultRunLoopMode
    /*
     [NSTimer scheduledTimerWithTimeInterval:1.0
     target:self
     selector:@selector(timerMethod)
     userInfo:nil
     repeats:YES];
     */
    
    //timerWithTimeInterval该方法没有处理 NSRunLoop,所以创建了 timer 线程后需要手动添加入 RunLoop
    timer = [NSTimer timerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(timerMethod)
                                           userInfo:nil
                                            repeats:YES];
    /*
     主runLoop 因为是死循环,有事件就处理,没事件就waiting
     
     mode:
     包含  1.source    2.observer    3.timer
     
     
     一共 5 种mode,同一时间在主线程下面放着
     
     1.默认模式 NSDefaultRunLoopMode:
     如果有一个timer加入到了 NSDefaultRunLoopMode 中,则当这个timer被触发的时候, 即 NSDefaultRunLoopMode.timer 会被 主runLoop 处理,在没有事件的情况下 主runLoop 会处于waiting状态
     
     2.UI模式 UITrackingRunLoopMode:    -- Apple规定UI模式为最高级别, 主runLoop 一定优先处理,但是这个触发只能是 "触摸事件" 才可以
     该模式下只有触摸事件可以唤醒,也就是没有触摸事件就不会被UI模式中的timer唤醒   主runloop 不会处理事件
     
     3.NSRunLoopCommonModes 是一种占位模式,不是一种真正的runloop的mode -- 其实是上面两种模式的结合,将timer又加入默认模式又加入UI模式。这样子runloop既可以在非触摸事件下被唤醒处理default模式下的timer也可以在触摸事件下UI模式中被唤醒处理timer。
     
     4. UIInitializationRunLoopMode: 启动程序后的过渡mode，启动完成后就不再使用。
     
     5: GSEventReceiveRunLoopMode: Graphic相关事件的mode，通常用不到。
     
     6: kCFRunLoopCommonModes: 占位mode，作为标记DefaultMode和CommonMode用。
     
     */
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

//定时器处理
- (void)timerMethod {
    static int a = 0;
    a ++;
    YLYLog(@"a = %d -- runLoop:%@", a, [NSThread currentThread]);
}


- (void)dealloc {
    [timer invalidate];
    timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
