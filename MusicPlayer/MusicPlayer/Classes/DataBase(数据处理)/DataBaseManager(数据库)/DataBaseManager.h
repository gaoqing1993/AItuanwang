//
//  DataBaseManager.h
//  JP0513第十九讲(数据库)
//
//  Created by 焦鹏 on 15/5/13.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"
#import <sqlite3.h>
#import <UIKit/UIKit.h>
@interface DataBaseManager : NSObject


//创建单利
+ (instancetype)shareData;



//数据库操作

//打开数据库
- (void)openDB;
//关闭数据库
- (void)closeDB;

//创建表
- (void)creatTable;
//增
- (void)insertSong:(Song *)song;
//删
- (void)deleteWithSong_id:(NSInteger)song_id;//根据song_id删除
- (void)deleteWithSong_name:(NSString *)song_name;//根据song_name删除
-(void)deleteAll;
//改
- (void)updateSong_name:(NSString *)song_name withSong_id:(NSInteger)song_id;
//查
- (NSArray *)selectAllDB;
- (NSArray *)selectWithSong_id:(NSInteger)song_id;



@end
