//
//  LocalTableViewController.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/11.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LocalTableViewController.h"

@interface LocalTableViewController ()
{
    NSString *downPath;
    NSFileManager *manager;
}
@end

@implementation LocalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    downPath = [cachePath stringByAppendingString:@"/myMusic"];
    _musicArray = [NSMutableArray arrayWithArray:[manager subpathsAtPath:downPath]];
    _musicPathArray = [NSMutableArray arrayWithCapacity:20];
    for (NSString *p in _musicArray) {
        NSString *musicPath = [downPath stringByAppendingPathComponent:p];
        [_musicPathArray addObject:musicPath];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"localMusic"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _musicArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"localMusic" forIndexPath:indexPath];
      cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row +1,_musicArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayViewController *playVC = [PlayViewController newPlay];
    playVC.song_num = indexPath.row;
    playVC.localMusicArray = _musicPathArray;
    playVC.songNameArray = _musicArray;
    NSString *path = _musicPathArray[indexPath.row];
    [playVC playLocalMusicWithfileName:path];
    playVC.view.frame = [UIScreen mainScreen].bounds;
    [self.tabBarController addChildViewController:playVC];
    [self.tabBarController.view addSubview:playVC.view];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [manager removeItemAtPath:_musicPathArray[indexPath.row] error:nil];
    [_musicArray removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
