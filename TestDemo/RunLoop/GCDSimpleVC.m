//
//  GCDSimpleVC.m
//  TestDemo
//
//  Created by yu on 12/09/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "GCDSimpleVC.h"

@interface GCDSimpleVC ()

@property (nonatomic, readwrite, strong)dispatch_source_t timer;

@end

@implementation GCDSimpleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"sourceVC -- GCD";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     一切皆 source : 即事件源/输入源
     
     按照函数的调用栈 source 分为两类 -- source0, source1
     
     source1: 通过系统内核事件接收和分发出来的
     包含一个 mach_port 和一个回调，被用于通过内核和其他线程发送的消息，能主动唤醒runloop。
     
     
     source0: 非内核事件
     例如: touchesBegan 事件是用户点击触发的, 因此是属于 source0 的
     timer也是一个source
     
     event事件，只含有回调，需要标记待处理（signal），然后手动将runloop唤醒（wakeup）；

     */
    
    
    
    //创建timer
    /*
     第一个参数: source 的类型
     第二个: 回调的句柄, 回调函数地址
     第三个: 线程优先级
     第四个: 线程队列
     */
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    
    //设置timer
    /*
     第一个参数: 定时器对象
     第二个: 定时器开始执行的时间 DISPATCH_TIME_NOW这个时钟会随着系统休眠而停止
     第三个: 定时器的间隔时间 GCD 中的时间单位为纳秒 ull 与 OC 中的时间不同, 是 NSEC_PER_SEC    1s = 1亿 ull
     第四个: 误差容忍度
     */
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0);
    
    //设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        YLYLog(@"---- _%@", [NSThread currentThread]);
    });
    
    //启动timer
    dispatch_resume(self.timer);
    
    
    /*
     
     CADisplayLink 是一个和屏幕刷新率一致的定时器，如果在两次屏幕刷新之间执行了一个长任务，那其中就会有一帧被跳过去（和 NSTimer 相似，只是没有tolerance容忍时间），造成界面卡顿的感觉。
     
     */
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    /*
     函数调用栈中可以看到 CFRunLoopDoSource0 这个方法, 代表点击事件是 source0
     
     */
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
