//
//  FirstTableViewCell.m
//  TTYT
//
//  Created by 张毅 on 15/5/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

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
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, rect.size.width/4 - 10, rect.size.width/4 -10)];
    _imgView.layer.cornerRadius = 4;
    _imgView.layer.masksToBounds = YES;
    _imgView.image = [UIImage imageNamed:@"1.jpg"];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/4, 5, rect.size.width *3/4 - 10, 25)];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/4, 30, rect.size.width *3/4 - 10, 40)];
    _label.font = [UIFont systemFontOfSize:14];
    _label.numberOfLines = 3;
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_label];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
