//
//  SimpleTestVC.m
//  TestDemo
//
//  Created by yu on 2019/2/24.
//  Copyright © 2019 yu. All rights reserved.
//

#import "SimpleTestVC.h"
#import "RealItem.h"
#import <objc/runtime.h>

@interface SimpleTestVC ()
{
    NSMutableArray *aaa;
}

@end

@implementation SimpleTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 测试copy
//    [self copyTest];
    
    // 测试类簇
    [self classTest];
    
    // 测试performselect
//    [self perTest];
    
}

- (void)copyTest {
    /**
     可变数组使用copy会返回一个不可变数组指针
     */
    NSMutableArray *testArr = [[NSMutableArray alloc] initWithCapacity:0];
    [testArr addObject:@"aaa"];
    
    NSMutableArray *copyArr = [testArr copy];
//    [copyArr addObject:@"bbb"];
    [testArr addObject:@"ccc"];
    
    
    NSLog(@"testArr = %@, addr = %p\n", testArr, testArr);
    NSLog(@"copyArr = %@, addr = %p", copyArr, copyArr);
}

- (void)classTest {
    NSArray *a1 = [NSArray alloc];
    NSArray *a2 = [NSArray alloc];
    NSMutableArray *a3 = [NSMutableArray alloc];
    NSMutableArray *a4 = [NSMutableArray alloc];
//
//    NSObject *o1 = [NSObject alloc];
//    NSObject *o2 = [NSObject alloc];
//    NSObject *o3 = [NSObject alloc];

    NSArray *c1 = [a1 init];
    NSArray *c2 = [a2 init];
    
    NSMutableArray *c3 = [a3 init];
    NSMutableArray *c4 = [a4 init];
    
    
//    NSArray *b1 = [a1 initWithObjects:@"b1", nil];
//    NSArray *b2 = [a2 initWithObjects:@"b2", nil];
    NSArray *b3 = [a3 initWithObjects:@"b3", nil];
}

- (void)perTest {
    aaa = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (NSInteger i = 0; i < 5; i ++) {
        RealItem *item = [[RealItem alloc] init];
        [item performSelector:@selector(setValue123) withObject:[NSString stringWithFormat:@"%ld", i]];
        
        [aaa addObject:item];
    }
    
    for (PerItem *pi in aaa) {
        if ([pi respondsToSelector:@selector(value123)]) {
            NSLog(@"%@", [pi performSelector:@selector(value123)]);
        }
    }
}


@end
