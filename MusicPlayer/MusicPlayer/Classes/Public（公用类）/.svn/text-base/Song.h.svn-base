//
//  Song.h
//  MusicPlayer
//
//  Created by 张毅 on 15/6/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Song : NSObject

@property (nonatomic, assign) int pick_count;
@property (nonatomic, assign) int singer_id;
@property (nonatomic, strong) NSString *singer_name;
@property (nonatomic, assign) NSInteger song_id;//
@property (nonatomic, strong) NSString *song_name;//歌手名
@property (nonatomic, strong) NSString *url;//包含播放链接的数组
@property (nonatomic, assign) BOOL downloaded;//默认为NO
@property (nonatomic, assign) CGFloat progress; // 当前进度


- (instancetype)initWithDic:(NSDictionary *)dic;

-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (NSString *)description;

@end
