//
//  StaticDemoVC.m
//  TestDemo
//
//  Created by yu on 2019/3/2.
//  Copyright © 2019 yu. All rights reserved.
//

#import "StaticDemoVC.h"
#import "StaticItem.h"

@interface StaticDemoVC ()
{
    // 基础数据
    NSArray *baseDataArray;
    
}

@end

@implementation StaticDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 构建数据
    [self initBaseData];
    
    // 运算
    [self calcuateData];
    
    
    
}

- (void)initBaseData {
    baseDataArray = [self readCSVData];
}

- (void)calcuateData {
    for (NSInteger i = 0; i < baseDataArray.count; i ++) {
        NSArray *tempArr = baseDataArray[i];
        
        /*
         
         规则：
         1 - 9 之间每一个数发生的概率都是一样的都为 1/9，预测下一个可能出现的数字是几
         
         1. 统计所有数字出现的总数，即数组上限；
         2. 将总数 - 出现过的数字次数 作为分子，总数为分母获得一个补正；
         例如：1出现了5次，一共10个数字，那么1继续出现的概率为 (10-5)/10 * 1/9, 2出现了0次，那么继续出现的概率为 (10-0)/10 * 1/9
         
         */
    }
}

- (NSArray *)readCSVData{
    NSMutableArray *_InfoArray;
    
    if (_InfoArray) {
        return NULL;
    }
    _InfoArray=[[NSMutableArray alloc]init];
    
    NSString *filepath=[[NSBundle mainBundle] pathForResource:@"sheet" ofType:@"csv"];
    FILE *fp=fopen([filepath UTF8String], "r");
    if (fp) {
        char buf[BUFSIZ];
        fgets(buf, BUFSIZ, fp);
        while (!feof(fp)) {
            char buf[BUFSIZ];
            // 每次读取一行, 如果有值则返回给第一个参数 buf
            fgets(buf, BUFSIZ, fp);
            
            // 拿到一行字符串
            NSString *s = [[NSString alloc] initWithUTF8String:(const char *)buf];
            // 新建一个数组保存数据
            NSMutableArray *smallArr = [[NSMutableArray alloc] initWithCapacity:0];
            // 加工这一行字符串
            NSString *ss = [s stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            // 某一条属性可能为空，也要保存下来
            ss = [ss stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            // 解析分割字符串 横着为一条完整的数据
            NSArray *a = [ss componentsSeparatedByString:@","];
            [smallArr addObject:a];
            
            [_InfoArray addObject:smallArr];
        }
    }
    NSLog(@"%@",_InfoArray);
    return _InfoArray;
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
