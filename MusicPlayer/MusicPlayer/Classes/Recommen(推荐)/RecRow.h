//
//  RecRow.h
//  MusicPlayer
//
//  Created by 张毅 on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecRow : NSObject
@property(nonatomic,assign)int _id;
@property(nonatomic,strong)NSDictionary *action;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *order;
@property(nonatomic,strong)NSString *pic_url;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *num_id;
@property(nonatomic,strong)NSString *listen_count;
@end
