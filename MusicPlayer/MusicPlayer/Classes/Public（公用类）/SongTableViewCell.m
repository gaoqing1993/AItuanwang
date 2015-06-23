//
//  SongTableViewCell.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SongTableViewCell.h"
#import "AFNetworking.h"

@implementation SongTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _dataBaseManager = [DataBaseManager shareData];
        //打开数据库
        [_dataBaseManager openDB];
        [self setupSubviews];
    }
    return self;
    
}
- (void)setupSubviews{
    _rect = [UIScreen mainScreen].bounds;
    _manager = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    _downPath = [cachePath stringByAppendingPathComponent:@"myMusic"];
    _autName = [[UILabel alloc]initWithFrame:CGRectMake(_rect.size.width/4 + 15, _rect.size.width/10 - 30, _rect.size.width/2 + 15, _rect.size.width*0.13)];
    _autName.font = [UIFont systemFontOfSize:18];
    
    _autSingerName = [[UILabel alloc]initWithFrame:CGRectMake(_rect.size.width/4 + 15, _rect.size.width/10 + 5, _rect.size.width/2 + 15, _rect.size.width*0.11)];
    _autSingerName.font = [UIFont systemFontOfSize:15];
    
    _autFavorites = [[UILabel alloc]initWithFrame:CGRectMake(10, _rect.size.width/10, _rect.size.width*0.13, _rect.size.width*0.13)];
    _autFavorites.font = [UIFont systemFontOfSize:11];
    _autFavorites.textAlignment = NSTextAlignmentCenter;//居中
    
    _autLabel = [[UILabel alloc]initWithFrame:CGRectMake(_rect.size.width/4 - 15, _rect.size.width/10 - 30, _rect.size.width*0.13, _rect.size.width*0.11)];
    _autLabel.textColor = [UIColor orangeColor];
    _autLabel.font = [UIFont systemFontOfSize:18];
    
    //button
    self.isFavorite = NO;//是否已收藏(一个标识，用作判断button当前状态)
    
    _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button1.frame = CGRectMake(10, _rect.size.width/8 - 35, _rect.size.width*0.12, _rect.size.width*0.12);
    _button1.tag = 102;
    _button1.layer.cornerRadius = 10;
    _button1.layer.masksToBounds = YES;
    [_button1 setBackgroundImage:[UIImage imageNamed:@"mind1"] forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _button2.frame = CGRectMake(_rect.size.width - _rect.size.width*0.12 - 10, (_rect.size.width/4 - 10)/2 - 25, _rect.size.width*0.16, _rect.size.width*0.16);
    _button2.tag = 103;
    _button2.layer.cornerRadius = 10;
    _button2.layer.masksToBounds = YES;
    [_button2 setBackgroundImage:[UIImage imageNamed:@"下载"] forState:UIControlStateNormal];
    [_button2 addTarget:self action:@selector(downMusic:) forControlEvents:UIControlEventTouchUpInside];
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
   _songArray = [_dataBaseManager selectWithSong_id:song.song_id];
    if (_songArray.count != 0) {
         [_button1 setBackgroundImage:[UIImage imageNamed:@"mind2"] forState:UIControlStateNormal];
    }else{
          [_button1 setBackgroundImage:[UIImage imageNamed:@"mind1"] forState:UIControlStateNormal];
    }
      NSArray *localMusicArray = [_manager subpathsAtPath:_downPath];
        for (NSString *p in localMusicArray) {
            if ([p isEqualToString:[NSString stringWithFormat:@"%@.mp3",song.song_name]]) {
                [_button2 setBackgroundImage:[UIImage imageNamed:@"下载完成"] forState:UIControlStateNormal];
                break;
            }else{
                  [_button2 setBackgroundImage:[UIImage imageNamed:@"下载"] forState:UIControlStateNormal];
            }
        }
    if (song.pick_count > 4999) {
        _autFavorites.text = [NSString stringWithFormat:@"%.1lf万",song.pick_count/10000.0];
    }else{
        _autFavorites.text = [NSString stringWithFormat:@"%d",song.pick_count];
    }
}


//收藏按钮点击事件:
- (void)test:(UIButton *)sender{
    self.isFavorite = !self.isFavorite;
    UIImage *img = self.isFavorite ? [UIImage imageNamed:@"mind2"] : [UIImage imageNamed:@"mind1"];
    
    if (self.isFavorite == YES) {
        //添加提示框
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"收藏成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
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
    [sender setBackgroundImage:img forState:UIControlStateNormal];

}

//下载按钮点击事件:
- (void)downMusic:(UIButton *)button{
    _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
    _progressView.frame = CGRectMake(10, _rect.size.width/4 -14, _rect.size.width-20, 20);
    [button.superview addSubview:_progressView];
    [self downLoadMusicWithUrl:_song.url fileName:_song.song_name button:button];
}
//下载方法:
-(void)downLoadMusicWithUrl:(NSString *)url fileName:(NSString*)name button:(UIButton *)button{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *downPath = [cachePath stringByAppendingString:@"/myMusic"];
    if (![manager fileExistsAtPath:downPath]) {
          [manager createDirectoryAtPath:downPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *path = [downPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3",name]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.outputStream = [NSOutputStream
                              outputStreamWithURL:URL append:NO];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        _song.progress = (float)totalBytesRead/totalBytesExpectedToRead;
         [_progressView setProgress:_song.progress animated:YES];
         }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        _song.downloaded = YES;
        NSData *data = responseObject;
        [data writeToFile:path atomically:YES];
        [_button2 setBackgroundImage:[UIImage imageNamed:@"下载完成"] forState:UIControlStateNormal];
        [_progressView setHidden:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    [operation start];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
