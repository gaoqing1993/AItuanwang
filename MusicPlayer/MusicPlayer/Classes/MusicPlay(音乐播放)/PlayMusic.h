//
//  PlayMusic.h
//  MusicPlayer
//
//  Created by 张毅 on 15/6/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayMusic : NSObject

@property(nonatomic,assign)int bitrate;
@property(nonatomic,strong)NSString *duration;
@property(nonatomic,strong)NSString *format;
@property(nonatomic,strong)NSString *size;
@property(nonatomic,strong)NSString *type_description;
@property(nonatomic,strong)NSString *url;

@end
