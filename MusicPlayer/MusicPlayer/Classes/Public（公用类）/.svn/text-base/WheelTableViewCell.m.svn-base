//
//  WheelTableViewCell.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "WheelTableViewCell.h"

@implementation WheelTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _dataBaseManager = [DataBaseManager shareData];
        //打开数据库
        [_dataBaseManager openDB];
        [self drawView];
    }
    return self;
}

-(void)drawView{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    _autName = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/4 + 15, rect.size.width/10 - 30, rect.size.width/2 + 15, rect.size.width *0.13)];
    _autName.font = [UIFont systemFontOfSize:18];
    
    _autSingerName = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/4 + 15, rect.size.width/10 + 5, rect.size.width/2 + 15, rect.size.width*0.11)];
    _autSingerName.font = [UIFont systemFontOfSize:15];
    
    _autFavorites = [[UILabel alloc]initWithFrame:CGRectMake(10, rect.size.width/10, rect.size.width*0.13, rect.size.width*0.13)];
    _autFavorites.font = [UIFont systemFontOfSize:11];
    _autFavorites.textAlignment = NSTextAlignmentCenter;//居中
    
    _autLabel = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/4 - 15, rect.size.width/10 - 30, rect.size.width*0.13, rect.size.width*0.11)];
    _autLabel.textColor = [UIColor orangeColor];
    _autLabel.font = [UIFont systemFontOfSize:18];
    
    //button
    self.isFavorite = NO;//是否已收藏(一个标识，用作判断button当前状态)
    
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button1.frame = CGRectMake(10, rect.size.width/8 - 35, rect.size.width*0.12, rect.size.width*0.12);
    _button1.tag = 102;
    _button1.layer.cornerRadius = 10;
    _button1.layer.masksToBounds = YES;
    
    [_button1 addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    [_button1 setBackgroundImage:[UIImage imageNamed:@"mind1"] forState:UIControlStateNormal];
    
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button2.frame = CGRectMake(rect.size.width - rect.size.width*0.12 - 10, (rect.size.width/4 - 10)/2 - 20, rect.size.width*0.12, rect.size.width*0.12);
    _button2.tag = 103;
    _button2.layer.cornerRadius = 10;
    _button2.layer.masksToBounds = YES;
    
    [_button2 addTarget:self action:@selector(event:) forControlEvents:UIControlEventTouchUpInside];
    [_button2 setBackgroundImage:[UIImage imageNamed:@"下载"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:_autName];
    [self.contentView addSubview:_autSingerName];
    [self.contentView addSubview:_autFavorites];
    [self.contentView addSubview:_autLabel];
    [self.contentView addSubview:_button1];
    [self.contentView addSubview:_button2];
}

- (void)setSong:(Song *)song{
    
    _song = song;
    
    _autName.text = song.song_name;
    _autSingerName.text = song.singer_name;
    
    if (song.pick_count > 4999) {
        _autFavorites.text = [NSString stringWithFormat:@"%.1lf万",song.pick_count/10000.0];
    }else{
        _autFavorites.text = [NSString stringWithFormat:@"%d",song.pick_count];
    }
}


- (void)test:(UIButton *)sender{
    self.isFavorite = !self.isFavorite;
    UIImage *img = self.isFavorite ? [UIImage imageNamed:@"mind2"] : [UIImage imageNamed:@"mind1"];
    
    if (self.isFavorite == YES) {
        //添加提示框
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show];
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
        if (_song.pick_count <= 4999) {
            _autFavorites.text = [NSString stringWithFormat:@"%d",_song.pick_count+1];
        }
        //创建表
        [_dataBaseManager creatTable];
        //添加数据
        [_dataBaseManager insertSong:_song];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"已取消收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show];
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
        if (_song.pick_count <= 4999) {
            _autFavorites.text = [NSString stringWithFormat:@"%d",_song.pick_count];
        }
        //根据song_id删除数据库数据
        [_dataBaseManager deleteWithSong_id:_song.song_id];
    }
    [sender setImage:img forState:UIControlStateNormal];
}


- (void)event:(UIButton *)button{
    
    if (self.isFavorite == YES)  {
        [button setBackgroundImage:[UIImage imageNamed:@"下载完成"] forState:UIControlStateNormal];
    }
    _isFavorite = !_isFavorite;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
