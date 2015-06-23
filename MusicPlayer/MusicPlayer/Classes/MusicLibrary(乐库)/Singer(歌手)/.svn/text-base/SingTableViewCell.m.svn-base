//
//  SingTableViewCell.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SingTableViewCell.h"

@implementation SingTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self drawView];
    }
    return self;
}
-(void)drawView{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat W = rect.size.width;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 0.2*W-10, 0.2*W-10)];
    _imgView.layer.cornerRadius = 0.1*W - 5;
    _imgView.layer.masksToBounds = YES;
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0.2*W+22, 10, W*0.5, 0.2*W-20)];
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_label];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
