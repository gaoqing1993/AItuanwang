//
//  MVPlayTableViewCell.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MVPlayTableViewCell.h"

@implementation MVPlayTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self drawView];
    }
    return self;
}

-(void)drawView{
    CGRect rect = [UIScreen mainScreen].bounds;
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, rect.size.width/2-5, rect.size.width*0.3)];
    _imgView.layer.cornerRadius = 4;
    _imgView.layer.masksToBounds = YES;
    _title_Label = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/2+5, 10, rect.size.width/2-10, 40)];
    _singerLabel = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/2+5, 50, rect.size.width/2-10, 30)];
    _singerLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_title_Label];
    [self.contentView addSubview:_singerLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
