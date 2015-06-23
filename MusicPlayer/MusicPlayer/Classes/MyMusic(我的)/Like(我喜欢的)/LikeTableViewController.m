//
//  LikeTableViewController.m
//  MusicPlayer
//
//  Created by 焦鹏 on 15/6/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LikeTableViewController.h"
@interface LikeTableViewController ()

@end

@implementation LikeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyCell"];
    [self Assignment];
}


- (void)Assignment{
    
    _dataBaseManager = [DataBaseManager shareData];
    [_dataBaseManager openDB];
    _selectAllDB = [[NSMutableArray alloc]initWithArray:[_dataBaseManager selectAllDB]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _selectAllDB.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    Song *song = _selectAllDB[indexPath.row ];
    cell.textLabel.text =[NSString stringWithFormat:@"%ld. %@ - %@",indexPath.row+1,song.song_name,song.singer_name];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    return rect.size.width *0.12;
}

//编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
     Song *song = _selectAllDB[indexPath.row ];
    //根据song_id删除数据库里的song_id
    [_dataBaseManager deleteWithSong_id:song.song_id];
    //删除数组里面的第row个
    [_selectAllDB removeObjectAtIndex:indexPath.row];
    //删除UI
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Song *song = _selectAllDB[indexPath.row ];
    PlayViewController *playVC = [PlayViewController newPlay];
    playVC.song_num = indexPath.row;
    playVC.songArray = _selectAllDB;
    [playVC playMusicWithUrl:song.url];
    playVC.view.frame = [UIScreen mainScreen].bounds;
    [self.tabBarController addChildViewController:playVC];
    [self.tabBarController.view addSubview:playVC.view];
}

@end
