//
//  SongTableViewCell.h
//  MusicPlayer
//
//  Created by 张毅 on 15/6/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
#import "DataBaseManager.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
@interface SongTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *autName;//歌曲名
@property (nonatomic, strong) UILabel *autSingerName;//歌手名
@property (nonatomic, strong) UILabel *autFavorites;//喜欢数
@property (nonatomic, strong) UIImageView *autPicUrl;//自定义喜欢图标
@property (nonatomic, strong) UILabel *autLabel;//自定义歌曲序号
@property (nonatomic, strong) Song *song;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) NSString *strSong;
@property (nonatomic, strong) NSString *strSinger;
@property (nonatomic,assign)BOOL isFavorite;  //是否已收藏
@property (nonatomic, strong)DataBaseManager *dataBaseManager;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)NSArray *songArray;
@property(nonatomic,strong)NSFileManager *manager;
@property(nonatomic,assign)CGRect rect;
@property(nonatomic,strong) NSString *downPath;
@end
