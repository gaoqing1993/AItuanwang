//
//  StationCollectionViewCell.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "StationCollectionViewCell.h"

@implementation StationCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = self.contentView.bounds;
        _imagViewS = [[UIImageView alloc] initWithFrame:rect];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(rect.size.width - 40, rect.size.height - 40, 30, 30)];
        imageV.image = [UIImage imageNamed:@"1.png"];
        
        _tag_nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/2 - 30, rect.size.height/2 - 15, 60, 20)];
        _tag_nameLabel.font = [UIFont systemFontOfSize:20];
        _tag_nameLabel.textColor = [UIColor whiteColor];
        _tag_nameLabel.textAlignment = NSTextAlignmentCenter;
        
        _quantityLabel = [[UILabel alloc] initWithFrame:CGRectMake(rect.size.width/2 - 30, rect.size.height/2 + 5, 60, 10)];
        _quantityLabel.font = [UIFont systemFontOfSize:10];
        _quantityLabel.textColor = [UIColor whiteColor];
        _quantityLabel.textAlignment = NSTextAlignmentCenter;
        [_imagViewS addSubview:imageV];
        [_imagViewS addSubview:_tag_nameLabel];
        [_imagViewS addSubview:_quantityLabel];
        [self.contentView addSubview:_imagViewS];
        
    }
    return self;
}
//重写此方法,让cell在布局的时候自动去适应外界的尺寸
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect rect = self.contentView.bounds;
    _imagViewS.frame = rect;
}




@end
