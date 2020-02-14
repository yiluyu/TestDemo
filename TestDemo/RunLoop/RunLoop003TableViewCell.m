//
//  RunLoop003TableViewCell.m
//  TestDemo
//
//  Created by yu on 07/09/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "RunLoop003TableViewCell.h"



@interface RunLoop003TableViewCell () {
    
}

@property (nonatomic, readwrite, strong)UIImageView *imageView1;
@property (nonatomic, readwrite, strong)UIImageView *imageView2;
@property (nonatomic, readwrite, strong)UIImageView *imageView3;
@property (nonatomic, readwrite, strong)UIImageView *imageView4;
@property (nonatomic, readwrite, strong)UIImageView *imageView5;
@property (nonatomic, readwrite, strong)UIImageView *imageView6;

@end

@implementation RunLoop003TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubViews];
    }
    
    return self;
}


- (void)creatSubViews {
    if (_imageView1 != nil) {
        _imageView1.image = nil;
    } else {
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        [self.contentView addSubview:_imageView1];
    }
    if (_imageView2 != nil) {
        _imageView2.image = nil;
    } else {
        self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 10, 50, 50)];
        [self.contentView addSubview:_imageView2];
    }
    if (_imageView3 != nil) {
        _imageView3.image = nil;
    } else {
        self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(140, 10, 50, 50)];
        [self.contentView addSubview:_imageView3];
    }
    if (_imageView4 != nil) {
        _imageView4.image = nil;
    } else {
        self.imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 10, 50, 50)];
        [self.contentView addSubview:_imageView4];
    }
    if (_imageView5 != nil) {
        _imageView5.image = nil;
    } else {
        self.imageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(260, 10, 50, 50)];
        [self.contentView addSubview:_imageView5];
    }
    if (_imageView6 != nil) {
        _imageView6.image = nil;
    } else {
        self.imageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 10, 50, 50)];
        [self.contentView addSubview:_imageView6];
    }
    
}



- (void)setFirstImages {
    _imageView1.image = [UIImage imageNamed:@"素材"];
}
- (void)setSecondImages {
    _imageView2.image = [UIImage imageNamed:@"素材2"];
}
- (void)setThirdImages {
    _imageView3.image = [UIImage imageNamed:@"素材3"];
}
- (void)setFourthImages {
    _imageView4.image = [UIImage imageNamed:@"素材"];
}
- (void)setFifthImages {
    _imageView5.image = [UIImage imageNamed:@"素材2"];
}
- (void)setSixthImages {
    _imageView6.image = [UIImage imageNamed:@"素材3"];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
