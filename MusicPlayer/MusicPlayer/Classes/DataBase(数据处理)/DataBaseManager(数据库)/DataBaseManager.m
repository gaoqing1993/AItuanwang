//
//  DataBaseManager.m
//  JP0513第十九讲(数据库)
//
//  Created by 焦鹏 on 15/5/13.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DataBaseManager.h"

@implementation DataBaseManager

//创建一个单例，用来管理数据库
static DataBaseManager *dataBaseManager = nil;

+ (instancetype)shareData{
    
    if (nil == dataBaseManager) {
        dataBaseManager = [[DataBaseManager alloc]init];
    }
    return  dataBaseManager;
}


//数据库操作

//准备一个数据库
static sqlite3 *db = nil;


//打开数据库
- (void)openDB{
    
    //如果数据库已经打开，则不做任何操作
    if (nil != db) {
        return;
    }
    //数据库路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
    path = [path stringByAppendingPathComponent:@"MyMusic.sqlite"];
    int result = sqlite3_open(path.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开成功!");
    }else{
        NSLog(@"打开失败!失败操作数(代码)为%d",result);
    }
}

//关闭数据库
- (void)closeDB{
    
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        db = nil;
        NSLog(@"关闭成功!");
    }else{
        NSLog(@"关闭失败!错误代码是%d",result);
    }
}


//创建表
- (void)creatTable{
    
    //1.创建SQL语句
    NSString *sqlWord = @"CREATE TABLE IF NOT EXISTS MyMusic  (song_id INTEGER PRIMARY KEY NOT NULL, song_name TEXT NOT NULL, singer_name TEXT NOT NULL, url TEXT NOT NULL)";
    //2.执行SQL语句
    int result = sqlite3_exec(db, sqlWord.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建成功!");
    }else{
        NSLog(@"创建失败!错误代码是%d",result);
    }
}

//增
- (void)insertSong:(Song *)song{
    
    //1.准备SQL语句
    NSString *sqlWord = [NSString stringWithFormat:@"INSERT INTO MyMusic (song_id,song_name,singer_name,url) VALUES (%ld,'%@','%@','%@')",song.song_id, song.song_name, song.singer_name, song.url];
    //2.执行SQL语句
    int result = sqlite3_exec(db, sqlWord.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入成功!");
    }else{
        if (result == SQLITE_CONSTRAINT) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"不能重复收藏" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alertView show];
            [alertView dismissWithClickedButtonIndex:1 animated:YES];
        }
    }
}

//删（根据id删除）
- (void)deleteWithSong_id:(NSInteger)song_id{

    //1.准备SQL语句
    NSString *sqlWord = [NSString stringWithFormat:@"DELETE FROM MyMusic WHERE song_id = %ld", (long)song_id];
    //2.执行SQL语句
    int result = sqlite3_exec(db, sqlWord.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功!");
    }else{
        NSLog(@"删除失败!错误代码是%d",result);
    }
}
-(void)deleteAll{
    NSString *sqlWord = [NSString stringWithFormat:@"DELETE TABLE MyMusic"];
    //2.执行SQL语句
    int result = sqlite3_exec(db, sqlWord.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功!");
    }else{
        NSLog(@"删除失败!错误代码是%d",result);
    }
}

//删（根据song_name删除）
- (void)deleteWithSong_name:(NSString *)song_name{
    
    //1.准备SQL语句
    NSString *sqlWord = [NSString stringWithFormat:@"DELETE FROM MyMusic WHERE song_name = '%@'", song_name];
    //2.执行SQL语句
    int result = sqlite3_exec(db, sqlWord.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功!");
    }else{
        NSLog(@"删除失败!错误代码是%d",result);
    }
}

//改(根据id改姓名)
- (void)updateSong_name:(NSString *)song_name withSong_id:(NSInteger)song_id{
    
    NSString *sql = [NSString stringWithFormat:@"UPDATE MyMusic SET song_name = '%@' WHERE song_id = %ld", song_name, (long)song_id];
    int result = sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"修改成功!");
    }else{
        NSLog(@"修改失败，失败代码是%d",result);
    }
}


//查
//1.查看全部信息
- (NSArray *)selectAllDB{
    //准备数组
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:50];
    //准备SQL语句
    NSString *sqlWord = @"SELECT *FROM MyMusic";
    //创建伴随指针
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, sqlWord.UTF8String, -1, &stmt, nil);//没有实际操作，只是为下面的操作做准备
    
    if (result == SQLITE_OK) {//判断
        while (sqlite3_step(stmt) == SQLITE_ROW) {//真正的取值操作
            //执行SQL语句
            NSInteger song_id = sqlite3_column_int(stmt, 0);
            NSString *song_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString *singer_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSString *url = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            //赋值
            Song *song = [Song new];
            song.song_id = song_id;
            song.song_name = song_name;
            song.singer_name = singer_name;
            song.url = url;
            //把值添加到数组
            [array addObject:song];
        }
    }
    //释放伴随指针
    sqlite3_finalize(stmt);
    
    return array;
}
//2.根据歌手查找
- (NSArray *)selectWithSong_id:(NSInteger)song_id{
    //准备数组
    NSMutableArray *array = nil;
    //准备SQL语句
    NSString *sqlWord = [NSString stringWithFormat:@"SELECT *FROM MyMusic WHERE song_id = '%ld' ",song_id];
    //创建伴随指针
    sqlite3_stmt *stmt = nil;
    
    int result = sqlite3_prepare_v2(db, sqlWord.UTF8String, -1, &stmt, nil);
    //fuzzya
    if (result == SQLITE_OK) {
        array = [[NSMutableArray alloc]initWithCapacity:30];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //执行SQL语句
            Song *song = [Song new];
            song.song_id = sqlite3_column_int(stmt, 0);
            song.singer_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            song.singer_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            song.url = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            //把值添加到数组
            [array addObject:song];
        }
    }
    //释放
    sqlite3_finalize(stmt);
    return array;
}


@end
