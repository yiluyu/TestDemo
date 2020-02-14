//
//  RunLoopVC002.m
//  TestDemo
//
//  Created by yu on 06/09/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "RunLoopVC002.h"
#import <mach/mach_time.h>

@interface RunLoopVC002 () {
    //用于监测关闭子线程
    BOOL threadFinished;
}

@property (nonatomic, readwrite, strong)NSTimer *timer;

@end

@implementation RunLoopVC002

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self runLoopTest];
}





#pragma -mark NSRunLoop
- (void)runLoopTest {
    
    threadFinished = NO;

    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        _timer = [NSTimer timerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(timerMethod)
                                               userInfo:nil
                                                repeats:YES];
        
        /* 使用 runloop 来保护该线程不会被CUP销毁 
         
         runloop在 currentRunLoop 时才会懒加载, 被创建出来。
         */
        
        //获取该子线程自己的runloop
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
        //run则进入这个runloop的死循环了   使用跳出条件 threadFinished
        [[NSRunLoop currentRunLoop] run];
    }];
    
    //将thread的代码丢入CUP多线程管理 -- 开始run
    [thread start];
    
}







//定时器处理
- (void)timerMethod {
    //判断timer是否已经被终止
    if (threadFinished == YES) {
        //关闭CUP中当前的thread -- 线程都销毁后,属于该线程的runloop找不到任何线程后会自动销毁
        [NSThread exit];
    }
    
    //模拟耗时操作  要丢入子线程来做，不能卡主主线程
    [NSThread sleepForTimeInterval:1.0];
    
    static int a = 0;
    a ++;
    YLYLog(@"a = %d -- thread:%@", a, [NSThread currentThread]);
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    threadFinished = YES;
}


- (void)willDealloc {
    //子线程对象要清空 -- 只有消除相互强引才会进入dealloc
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc {
    //结束CUP中的线程
    threadFinished = YES;
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
