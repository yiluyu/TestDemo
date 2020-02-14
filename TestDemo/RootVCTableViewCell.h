//
//  RootVCTableViewCell.h
//  TestDemo
//
//  Created by yu on 2020/2/12.
//  Copyright © 2020 yu. All rights reserved.
//

#import "YLYRootCell.h"

@class RootVCTableViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface RootVCTableViewCell : YLYRootCell

@property (nonatomic, strong)UILabel *mainLabel;


/// 刷新
- (void)refreshModel:(RootVCTableViewModel *)modelT;

@end

NS_ASSUME_NONNULL_END
