//
//  ViewController.m
//  TestDemo
//
//  Created by yu on 29/08/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "ViewController.h"

/* views */
#import "RootVCTableViewCell.h"

/* VC */
#import "RunLoopVC001.h"
#import "RunLoopVC002.h"
#import "RunLoopVC003.h"
#import "GCDSimpleVC.h"
#import "RunLoopPortVC001.h"
#import "SimpleTestVC.h"
#import "StaticDemoVC.h"
#import "BlockVC.h"

/* model */
#import "RootVCTableViewModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *tableDataArray;
    NSArray *vcArray;
    
    NSArray *modelArray;
}

@property (nonatomic, readwrite, strong)id observer;//监听对象

@end

@implementation ViewController

- (instancetype)init {
    if (self = [super init]) {
        //注册通知
        [self registerNotifications];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 说明
    tableDataArray = @[@"runloop基础篇", @"runloop子线程", @"CFRunLoop", @"Source", @"RunLoopPortVC001", @"simpleTest", @"统计数demo", @"block测试", @"runloop激活问题", @"tablviewHook", @"Object测试"];
    
    // 类名
    vcArray = @[@"RunLoopVC001", @"RunLoopVC002", @"RunLoopVC003", @"GCDSimpleVC", @"RunLoopPortVC001", @"SimpleTestVC", @"StaticDemoVC", @"BlockVC", @"RunLoopVC004", @"HookProtocolVC", @"ObjectTest"];
    
    
    // model
    NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithCapacity:tableDataArray.count];
    for (NSInteger i = 0; i < tableDataArray.count; i ++) {
        RootVCTableViewModel *model = [[RootVCTableViewModel alloc] init];
        model.mainContent = tableDataArray[i];
        [tmpArr addObject:model];
    }
    
    modelArray = [NSArray arrayWithArray:tmpArr];
    
    
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)
                                                   style:UITableViewStylePlain];
    tv.delegate = self;
    tv.dataSource = self;
    [self.view addSubview:tv];

}

#pragma -mark UITableView代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YLYRootViewController *nextVC = nil;
    
    if (indexPath.row <= vcArray.count) {
        Class vcClass = NSClassFromString(vcArray[indexPath.row]);
        if (vcClass) {
            nextVC = (YLYRootViewController *)[[vcClass alloc] init];
        }
    }
    
    
    nextVC.title = tableDataArray[indexPath.row];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RootVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RootVCTableViewCell"];
    if (cell == nil) {
        cell = [[RootVCTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    
    [cell refreshModel:modelArray[indexPath.row]];
    
    return cell;
}

#pragma -mark UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableDataArray.count;
}



#pragma -mark 功能方法
//注册通知
- (void)registerNotifications {
    
    
}

//doSomething
- (void)doSomething {
    ;
}


#pragma -mark 控制器生命周期
- (void)viewWillDisappear:(BOOL)animated {
    //注销特殊情况下的通知、KVO、键盘检测等
    
    //使用addObserverForName
    if (self.observer != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
        self.observer = nil;
    }
    
    
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    //注册特殊情况下的通知、KVO、键盘检测等
    
    
    //使用addObserverForName
    __weak typeof(self)weakSelf = self;
    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:@"NoteName"
                                                                      object:nil
                                                                       queue:[NSOperationQueue mainQueue]
                                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                                      [weakSelf doSomething];
                                                                  }];
    
    [super viewWillAppear:animated];
}

- (void)dealloc {
    //注销所有通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //使用addObserverForName
    if (self.observer != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
        self.observer = nil;
    }
    //注销可能的强引用代理 (XMPP代理)
    //进行最后的一些服务器通信
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
