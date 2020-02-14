//
//  ObjectTest.m
//  TestDemo
//
//  Created by yu on 2020/2/14.
//  Copyright © 2020 yu. All rights reserved.
//

#import "ObjectTest.h"

@interface ObjectTest ()

@end

@implementation ObjectTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *aaa = [[NSMutableArray alloc] initWithCapacity:0];
    [aaa addObject:@"123"];
    
    if ([aaa isKindOfClass:[NSObject class]]) {
        NSLog(@"kind YES");
    } else {
        NSLog(@"kind NO");
    }
    
    if ([aaa isMemberOfClass:[NSMutableArray class]]) {
        NSLog(@"member YES");
    } else {
        NSLog(@"member NO");
    }
    
    
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
