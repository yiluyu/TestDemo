//
//  RunLoopPortVC001.m
//  TestDemo
//
//  Created by yu on 20/09/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "RunLoopPortVC001.h"

@interface RunLoopPortVC001 ()

@end

@implementation RunLoopPortVC001

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"PortVC001";
    
    
    
    
    
    
    
    
    
}

/*
 线程之间的通信:
 使用 port 来进行通信
 1.在 A 线程中创建 NSMachPort 对象, 将 port 加入到 runloop 的指定 mode 下。
 2.在 A 线程中创建 B 线程, 将 port 传给 B 线程, 在 B 线程的 runloop 中加入这个 port, 其实就是两个 runloop 之间使用 port 来进行通信。其中在 B 线程运行时, 设定一个签到规则, 告诉 A 线程现在 B 线程正在正常运行。一般在这个签到方法中将 B 线程的这个port 再返回给 A。
 3.通过这个 port 的 message 带入消息。
 
 */











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
