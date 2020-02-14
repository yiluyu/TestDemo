//
//  HookProtocolVC.m
//  TestDemo
//
//  Created by yu on 2020/2/12.
//  Copyright © 2020 yu. All rights reserved.
//

#import "HookProtocolVC.h"
#import "UITableView+HookProtocol.h"
#import <UIKit/UIKit.h>
#import "RootVCTableViewCell.h"

@interface HookProtocolVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *vcArray;
}

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation HookProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    vcArray = @[@"RunLoopVC001", @"RunLoopVC002", @"RunLoopVC003", @"GCDSimpleVC", @"RunLoopPortVC001", @"SimpleTestVC", @"StaticDemoVC", @"BlockVC", @"RunLoopVC004", @"HookProtocolVC"];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)
                                                   style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView startHook];
    
}

#pragma -mark UITableView代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"kikiki");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RootVCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RootVCTableViewCell"];
    if (cell == nil) {
        cell = [[RootVCTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cell"];
    }
    
    cell.mainLabel.text = vcArray[indexPath.row];

    return cell;
}

#pragma -mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return vcArray.count;
}

@end
