//
//  MVTableViewCell.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MVTableViewCell.h"

@implementation MVTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self drawView];
    }
    return self;
}
-(void)drawView{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat W = rect.size.width-30;
    
    _timeDay = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, W*2/15, W*2/15)];
    _timeDay.font = [UIFont systemFontOfSize:W*0.12];
    _timeDay.textAlignment = NSTextAlignmentCenter;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, W*2/15+10, W*2/15, 1.5)];
    label.backgroundColor = [UIColor grayColor];
    
    _timeMonth = [[UILabel alloc] initWithFrame:CGRectMake(15, W*2/15+10, W*2/15, W*1/15)];
    _timeMonth.font = [UIFont systemFontOfSize:W*0.05];
    _timeMonth.textAlignment = NSTextAlignmentCenter;
    _timeMonth.textColor = [UIColor grayColor];
    
    _descLable = [[UILabel alloc] initWithFrame:CGRectMake(W*2/15+25 , 10, W*5/6, W*2/15)];
    _descLable.font = [UIFont systemFontOfSize:W*0.05];
    _descLable.numberOfLines = 2;
    _tagName1 = [[UILabel alloc] initWithFrame:CGRectMake(W*2/15+25 , W*2/15+15, 30, 15)];
    _tagName1.font = [UIFont systemFontOfSize:13];
    _tagName1.layer.cornerRadius = 2;
    _tagName1.layer.masksToBounds = YES;
    _tagName1.textAlignment = NSTextAlignmentCenter;
    
    _tagName2 = [[UILabel alloc] initWithFrame:CGRectMake(W*2/15+20+45, W*2/15+15, 30, 15)];
    _tagName2.font = [UIFont systemFontOfSize:13];
    _tagName2.layer.cornerRadius = 2;
    _tagName2.layer.masksToBounds = YES;
    _tagName2.textAlignment = NSTextAlignmentCenter;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, W*2/15+40, W, W*0.5)];
    _imgView.layer.cornerRadius = 5;
    _imgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_timeDay];
    [self.contentView addSubview:label];
    [self.contentView addSubview:_timeMonth];
    [self.contentView addSubview:_descLable];
    [self.contentView addSubview:_tagName1];
    [self.contentView addSubview:_tagName2];
    [self.contentView addSubview:_imgView];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
