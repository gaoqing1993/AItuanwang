//
//  MVCollectionViewCell.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MVCollectionViewCell.h"

@implementation MVCollectionViewCell
{
    CGSize _size;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawView];
    }
    return self;
}
-(void)drawView{
    _size = self.contentView.frame.size;
    CGFloat W = _size.width;
    CGFloat H = _size.height;
    CGFloat imagH = _size.height*3/4;
    CGFloat label1H = (H-imagH)*3/5;
    CGFloat label2H = H-imagH-label1H;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, W, imagH)];
    _imgView.layer.cornerRadius = 4;
    _imgView.layer.masksToBounds = YES;
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, imagH, W, label1H)];
    _label1.font = [UIFont systemFontOfSize:label1H*0.8];
    
    _label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, imagH + label1H, W, label2H)];
    _label2.font = [UIFont systemFontOfSize:label2H*0.8];
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_label1];
    [self.contentView addSubview:_label2];
}
-(void)layoutSubviews{
    CGFloat W = _size.width;
    CGFloat H = _size.height;
    CGFloat imagH = _size.height*3/4;
    CGFloat label1H = (H-imagH)*3/5;
    CGFloat label2H = H-imagH-label1H;
    _imgView.frame = CGRectMake(0, 0, W, imagH);
    _label1.frame = CGRectMake(0, imagH, W, label1H);
    _label2.frame = CGRectMake(0, imagH +label1H, W, label2H);
}





@end
