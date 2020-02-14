//
//  YLYDefine.h
//  TestDemo
//
//  Created by yu on 31/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

/*
 该对象用定义宏
 */

/* debug总开关 */
#define YLYTest    //开发状态,注释掉则为发布状态




/* 自定义log输出,替换系统NSLog
 NSLog does 2 things:
 
 It writes log messages to the Apple System Logging (asl) facility. This allows log messages to show up in Console.app.
 It also checks to see if the application's stderr stream is going to a terminal (such as when the application is being run via Xcode). If so it writes the log message to stderr (so that it shows up in the Xcode console).
 To send a log message to the ASL facility, you basically open a client connection to the ASL daemon and send the message. BUT - each thread must use a separate client connection. So, to be thread safe, every time NSLog is called it opens a new asl client connection, sends the message, and then closes the connection.
 属于系统级别标准错误输出使用,属于高级封装。
 
 而fprintf()是c级别的函数,文件输出流。速度快很多。
 */
#ifndef YLYTest
#define YLYLog(FORMAT, ...)
#else
#define YLYLog(FORMAT, ...) fprintf(stderr, "[%s:%d行] %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#endif



/* 设备屏幕 */
#define ScreenSize [UIScreen mainScreen].bounds.size










