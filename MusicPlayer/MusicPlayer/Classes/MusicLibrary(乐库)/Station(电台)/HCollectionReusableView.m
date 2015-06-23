//
//  HCollectionReusableView.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HCollectionReusableView.h"

@implementation HCollectionReusableView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawView];
    }
    return self;
}

-(void)drawView{
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 30)];
    _headerLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_headerLabel];
}

@end
