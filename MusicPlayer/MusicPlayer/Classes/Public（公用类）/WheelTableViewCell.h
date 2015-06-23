//
//  WheelTableViewCell.h
//  MusicPlayer
//
//  Created by 张毅 on 15/6/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
#import "DataBaseManager.h"

@interface WheelTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *autName;//歌曲名
@property (nonatomic, strong) UILabel *autSingerName;//歌手名
@property (nonatomic, strong) UILabel *autFavorites;//喜欢ID
@property (nonatomic, strong) UIImageView *autPicUrl;//自定义喜欢图标
@property (nonatomic, strong) UILabel *autLabel;//自定义歌曲序号

@property (nonatomic, strong) Song *song;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, assign) BOOL isFavorite;//状态标识
@property (nonatomic, strong)DataBaseManager *dataBaseManager;

@end
