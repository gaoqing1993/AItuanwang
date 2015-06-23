//
//  RankTableViewCell.m
//  TTYT
//
//  Created by 焦鹏 on 15/5/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RankTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation RankTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setupSubviews];
    }
    return self;
    
}

- (void)setupSubviews{

    CGRect rect = [UIScreen mainScreen].bounds;
    
    _rankPicture = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, rect.size.width/2 - 50, rect.size.width/2 - 50)];
    _rankPicture.layer.cornerRadius = 4;
    _rankPicture.layer.masksToBounds = YES;

    _ranktitle = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/2 - 30, 5, rect.size.width/2, 30)];
    _ranktitle.font = [UIFont systemFontOfSize:16];
    
    
    _rankFirst = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/2 - 30, (rect.size.width/2 - 50)/3.2, rect.size.width/2 + 15, 30)];
    _rankFirst.font = [UIFont systemFontOfSize:13];
    
    _rankSecond = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/2 - 30, (rect.size.width/2 - 50)/1.8 , rect.size.width/2 + 15, 30)];
    _rankSecond.font = [UIFont systemFontOfSize:13];
    
    _rankThird = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/2 - 30, (rect.size.width/2 - 50)/1.25, rect.size.width/2 + 15, 30)];
    _rankThird.font = [UIFont systemFontOfSize:13];
    
    
    _rankDividing = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/2 - 30, (rect.size.width/2 - 50)/3.5, rect.size.width/2 + 15, 1)];
    _rankDividing.backgroundColor = [UIColor lightGrayColor];
    

    [self.contentView addSubview:_rankPicture];
    [self.contentView addSubview:_ranktitle];
    [self.contentView addSubview:_rankFirst];
    [self.contentView addSubview:_rankSecond];
    [self.contentView addSubview:_rankThird];
    [self.contentView addSubview:_rankDividing];
}


- (void)setRank:(Rank *)rank{
    
    if (_rank != rank) {
        _rank = rank;
    }
    _rankFirst.text = [NSString stringWithFormat:@"1 %@ - %@",rank.songlist[0][@"songName"],rank.songlist[0][@"singerName"]];

    _rankSecond.text = [NSString stringWithFormat:@"2 %@ - %@",rank.songlist[1][@"songName"],rank.songlist[1][@"singerName"]];

    _rankThird.text = [NSString stringWithFormat:@"3 %@ - %@",rank.songlist[2][@"songName"],rank.songlist[2][@"singerName"]];
    
    [_rankPicture sd_setImageWithURL:[NSURL URLWithString:rank.big_pic_url]];
    
    _ranktitle.text = rank.title;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
