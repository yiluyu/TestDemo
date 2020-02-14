//
//  SDWebImageDemo.m
//  TestDemo
//
//  Created by yu on 12/09/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "SDWebImageDemo.h"

@interface SDWebImageDemo ()

@end

@implementation SDWebImageDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*
     SD使用的AutoPurgeCache继承NSCache 来管理Cache的, 同时监听到MemoryWaring状态时, 调用NSCache的removeAllObject来清空Cache
     
     
     */
    
    
}


@end
