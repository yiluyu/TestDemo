//
//  main.m
//  TestDemo
//
//  Created by yu on 29/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//主线程也是一个普通的线程, 要想线程不死掉就需要runloop一直跑起来, 主线程就是通过 main() 函数跑起来的保证 APP 一直运行
int main(int argc, char * argv[]) {
    @autoreleasepool {
        //开启了主线程
//        NSLog(@"%@", [NSThread currentThread]);
        //死循环runloop -- 保证了主线程不退出
        /*
         1.保证线程不退出
         2.监听iOS中的所有事件:例如 网络、触摸交互、时间等
         3.负责渲染UI
         
         Mode:
         Source
         Observer
         Timer
         
         其中source包涵了timer
         observer就是观察者
         
         */
        
        
        //第三个参数:nil == UIApplication
        //第四个参数:指定UIApplication的代理为 --> AppDelegate
        //在"AppDelegate"里面实现代理方法  didFinishLaunch...等
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
