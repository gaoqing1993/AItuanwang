//
//  ClassCollectionViewCell.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ClassCollectionViewCell.h"

@implementation ClassCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = self.contentView.frame;
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, rect.size.height/2 - 10, rect.size.width, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLabel];
    }
    return self;
}


-(void)layoutSubviews{
    CGRect rect = self.contentView.frame;
    _nameLabel.frame = CGRectMake(0, rect.size.height/2 - 10, rect.size.width, 20);
}


@end
