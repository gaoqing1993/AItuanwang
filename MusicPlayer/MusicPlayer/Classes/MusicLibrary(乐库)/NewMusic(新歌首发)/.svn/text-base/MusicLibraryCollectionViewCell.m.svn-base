//
//  MusicLibraryCollectionViewCell.m
//  TTYT
//
//  Created by lanou3g on 15/5/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicLibraryCollectionViewCell.h"

@implementation MusicLibraryCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawView];
    }
    return self;
}

-(void)drawView{
    
    _view = [[UIView alloc] initWithFrame:self.contentView.bounds];
    CGFloat imgWH = _view.frame.size.width;
    CGFloat labH = imgWH/9;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWH, imgWH)];
    _imageView.layer.cornerRadius = 8;
    _imageView.layer.masksToBounds = YES;
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, imgWH, imgWH, labH)];
    _label.tintColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:imgWH/9];
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, imgWH+labH, imgWH, _view.frame.size.height-imgWH-labH)];
    _label2.font = [UIFont systemFontOfSize:_label2.frame.size.height/3];
    [_view addSubview:_label2];
    [_view addSubview:_label];
    [_view addSubview:_imageView];
    [self.contentView addSubview:_view];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imgWH = self.contentView.frame.size.width;
    CGFloat labH = imgWH/9;
    _imageView.frame = CGRectMake(0, 0, imgWH, imgWH);
    _label.frame = CGRectMake(0, imgWH, imgWH, labH);
    _view.frame = self.contentView.frame;
    _label.font = [UIFont systemFontOfSize:imgWH/9];
    _label2.frame = CGRectMake(0, imgWH+labH, imgWH, _view.frame.size.height-imgWH-labH);
    _label2.font = [UIFont systemFontOfSize:_label2.frame.size.height/3];
}

@end




