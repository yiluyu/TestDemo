//
//  BlockVC.m
//  TestDemo
//
//  Created by yu on 2020/2/11.
//  Copyright © 2020 yu. All rights reserved.
//

#import "BlockVC.h"

@interface BlockVC ()

@end

@implementation BlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    static int num = 10;
    
    void (^block) (void) = ^{
        NSLog(@"%d", num);
        num = 30;
    };
    
    num = 20;
    block();
    
    NSLog(@"%d", num);
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
