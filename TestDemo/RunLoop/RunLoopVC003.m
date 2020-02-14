//
//  RunLoopVC003.m
//  TestDemo
//
//  Created by yu on 07/09/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "RunLoopVC003.h"

#import "RunLoop003TableViewCell.h"

//定义block
typedef void(^RunloopBlock)(void);

@interface RunLoopVC003 () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *tableDataArray;
    /* 数组加载最多的队列长度 -- 一个屏幕内能显示的最多cell*3 */
    NSInteger maxQueueLength;
}

/* 加载图片的数组任务 -- 因为需要在C中使用, 传入参数要使用self来抓取, 所以需要写成property */
@property (nonatomic, readwrite, strong)NSMutableArray *tasks;


@end

@implementation RunLoopVC003

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"CFRunLoop";
    
    [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(timeMethod) userInfo:nil repeats:YES];
    
    /* 所有的性能优化都是建立在知道耗时原因的基础上的,runloop一般解决大部分UI渲染耗时的卡顿现象 */
    
    /* CFRunLoopObserverRef 观察者是一个结构体指针  Ref一般都是C语言的指针,C语言中观察者效果是通过传入函数指针,然后执行来完成的 -- 类似block语法传入代码块。OC是有通知、代理、block、kvo等等方式来观察回调 */
    
    [self addRunLoopObserver];
    
    tableDataArray = @[@"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1"];
    
    UITableView *mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height) style:UITableViewStylePlain];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    [self.view addSubview:mainTable];
    
    
    /* 
     思路：
        1.每一次加载一张耗时的大图, 当图片超出显示范围后就不再加载了。
        2.在一个数组中加入每个加载操作, 每次多线程跑起来的时候减去一个代码块block
        3.在主线程的runloop中加入observer, 设定observer观察状态为runloop休眠之前唤起一次block, 即UITrackingMode与DefaultMode都没有被唤起时才进行加载block
        4.
     */
    
    maxQueueLength = 100;
    
}



#pragma -mark <关于CFRunLoop的方法 -- 都是C语言方法>
//添加任务的方法
- (void)addTask:(RunloopBlock)task {
    //将数组添加block任务
    [self.tasks addObject:task];
    
    //当超出最大显示长度时,去掉最旧的加载任务
    if (self.tasks.count > maxQueueLength) {
        [self.tasks removeObjectAtIndex:0];
    }
    
    
}

//加入一个唤醒runloop的方法
- (void)timeMethod {
    //纯粹唤醒runloop来用 -- 其他什么都不干
}


//添加runloop的观察者
- (void)addRunLoopObserver {
    //1.获取当前主线程的runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    
    //2.创建oberver
    //定义
    static CFRunLoopObserverRef runloopObserver;
    //创建
    /* 第一个初始化指向NULL  第二个什么时候监听runloop状态  第三个反复监听   第四个 0  第五个回调函数指针  第六个附带信息
     
    typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
        kCFRunLoopEntry = (1UL << 0),
        kCFRunLoopBeforeTimers = (1UL << 1),
        kCFRunLoopBeforeSources = (1UL << 2),
        kCFRunLoopBeforeWaiting = (1UL << 5),
        kCFRunLoopAfterWaiting = (1UL << 6),
        kCFRunLoopExit = (1UL << 7),
        kCFRunLoopAllActivities = 0x0FFFFFFFU
    };
     
     回调函数指针其实是有参数的
     typedef void (*CFRunLoopObserverCallBack)(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info);
     将参数一起带入callBack()方法, 否则要使用桥接方式才能将OC的对象传入C函数中
     
     callBack函数中的 void *info 是传入的上下文, 为第五个参数 context 上下文参数: CFRunLoopObserverContext *context
     
     上下文的结构:
     typedef struct {
     CFIndex	version;
     void *	info;       -- 这相当于OC暴露出来的接口
     const void *(*retain)(const void *info);
     void	(*release)(const void *info);
     CFStringRef	(*copyDescription)(const void *info);
     } CFRunLoopObserverContext;
     
     -- 以上信息都可以直接查看 CFRunLoopObserverCreate 方法可以看到参数具体配置 --
     
     */
    
    //上下文
    CFRunLoopObserverContext context = {
        0,    //一般都是0  版本管理？
        (__bridge void *)(self),    //使用万能指针 (__bridge void *)传入self
        &CFRetain,    //内存管理相关的属性
        &CFRelease,    //同上
        NULL
    };
    
    
    //因为是C的函数, 所以传入的都是指针需要取地址符&
    runloopObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &callBack, &context);
    
    //3.添加到当前runloop中去
    CFRunLoopAddObserver(runloop, runloopObserver, kCFRunLoopCommonModes);
    
    
    /*
     另一个创建方式
     
     // 第一个参数用于分配该observer对象的内存空间
     
     // 第二个参数用以设置该observer监听什么状态
     
     // 第三个参数用于标识该observer是在第一次进入run loop时执行还是每次进入run loop处理时均执行
     
     // 第四个参数用于设置该observer的优先级,一般为0
     
     // 第五个参数用于设置该observer的回调函数
     
     // 第六个参数observer的运行状态
     
     CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        // 执行代码
     }
     
     
     
     */
}


//回调函数 -- C语言函数拿OC对象, 需要做桥接/或者找参数  其中 void *xxx 为万能指针
static void callBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    //加载图片, tasks里的任务
    //拿控制器 -- C转成OC, 桥接转回来
    RunLoopVC003 *vc = (__bridge RunLoopVC003 *)info;
    
    //callBack调用非常快, 需要判断
    if (vc.tasks.count == 0) {
        //没有任务就直接退出
        return;
    }
    
    //拿出当前任务 -- 因为每次执行完都会从中去掉该任务, 所以直接拿第一个任务即可
    RunloopBlock task = vc.tasks.firstObject;
    //执行任务 -- block执行
    task();
    
    //去掉刚才这个任务
    [vc.tasks removeObjectAtIndex:0];
    
}




#pragma -mark UITableView代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RunLoop003TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RunLoop003TableViewCell"];
    if (cell == nil) {
        cell = [[RunLoop003TableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"RunLoop003TableViewCell"];
    }
    
    //耗时操作
    [self addTask:^{
        [cell setFirstImages];
    }];
    [self addTask:^{
        [cell setSecondImages];
    }];
    [self addTask:^{
        [cell setThirdImages];
    }];
    [self addTask:^{
        [cell setFourthImages];
    }];
    [self addTask:^{
        [cell setFifthImages];
    }];
    [self addTask:^{
        [cell setSixthImages];
    }];
    
    
    return cell;
}

#pragma -mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableDataArray.count;
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
