//
//  StrongDelegateVC.m
//  TestDemo
//
//  Created by yu on 11/09/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "StrongDelegateVC.h"

@interface StrongDelegateVC ()

@end

@implementation StrongDelegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     AFN请求的manager是单例, 其实大部分的请求工具都是用的单例。这里面就会使用strong的delegate, 否则获取数据后的回调是不会响应的。
     是URLSession的封装
     
     这个方法中的delegate是retained, 强引用。
     [NSURLSession sessionWithConfiguration:<#(nonnull NSURLSessionConfiguration *)#> delegate:<#(nullable id<NSURLSessionDelegate>)#> delegateQueue:<#(nullable NSOperationQueue *)#>]
    delegate是self则vc不会被释放
     
     如果底层库中Apple设计的delegate是strong, 则代表这个封装库是要用单例模式来设计的。因此AFN建立在URLSession上, 就需要使用单例来做。
     
     */
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
