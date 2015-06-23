//
//  SecondTableViewCell.m
//  TTYT
//
//  Created by 张毅 on 15/5/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation SecondTableViewCell

//重写setter方法:
-(void)setArray:(NSMutableArray *)array{
    if (_array != array) {
        _array = array;
    }
    for (int i = 0; i < _array.count; i++) {
          RecRow *row = _array[i];
        _imgView = (UIImageView *)[self.contentView viewWithTag:100+i];
        _label = (UILabel *)[self.contentView viewWithTag:110+i];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:row.pic_url]];
        _label.text = row.name;
    }
}

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
    _imgArray = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i< 3; i++) {
       UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(5 + ((rect.size.width-20)/3 + 5) * i, 5, (rect.size.width-20)/3, (rect.size.width-20)/3)];
        imgView.layer.cornerRadius = 4;
        imgView.layer.masksToBounds = YES;
        imgView.tag = 100 +i;
        _label = [[UILabel alloc]initWithFrame:CGRectMake(5 + ((rect.size.width-20)/3 + 5) * i, (rect.size.width-20)/3 + 5, (rect.size.width-20)/3, 30)];
        _label.tag = 110+i;
        _label.font = [UIFont systemFontOfSize:11];
        _label.numberOfLines = 2;
        [_imgArray addObject:imgView];
        imgView.userInteractionEnabled = YES;
        [self.contentView addSubview:imgView];
        [self.contentView addSubview:_label];
    }
}

-(void)test:(UIImageView *)imgView{
     
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
