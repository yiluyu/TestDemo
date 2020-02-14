//
//  RunTimeBaseVC.m
//  TestDemo
//
//  Created by yu on 12/09/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "RunTimeBaseVC.h"

@interface RunTimeBaseVC ()

@end

@implementation RunTimeBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /*
     runTime 概念
     
     平时写的OC代码, 在程序运行的时候, 其实都是转变为了 runTime 的 C 语言代码。
     runTime 其实就是 OC 的幕后工作者
     
     作用:
     runTime 是与属于 OC 的底层实现, 可以进行一些非常底层的操作 (用 OC 无法实现的)
     1.利用 runTime 在程序运行过程中, 动态创建一个类、属性、方法等
     2.利用 runTime 创建类别, 为类别添加属性。类似继承一个类, 然后写私有属性
     3.遍历一个类的所有成员变量和方法
     
     
     
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
