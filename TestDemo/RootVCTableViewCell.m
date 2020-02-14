//
//  RootVCTableViewCell.m
//  TestDemo
//
//  Created by yu on 2020/2/12.
//  Copyright © 2020 yu. All rights reserved.
//

#import "RootVCTableViewCell.h"
#import "RootVCTableViewModel.h"

@implementation RootVCTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCustomViews];
    }
    
    return self;
}

- (void)initCustomViews {
    self.mainLabel = [[UILabel alloc] init];
    _mainLabel.textAlignment = NSTextAlignmentCenter;
    _mainLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    _mainLabel.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    _mainLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_mainLabel];
}


#pragma mark - < 刷新 >
- (void)refreshModel:(RootVCTableViewModel *)modelT {
    self.mainLabel.text = modelT.mainContent;
}

@end
