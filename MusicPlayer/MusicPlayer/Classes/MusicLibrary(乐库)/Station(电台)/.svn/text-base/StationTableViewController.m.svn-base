//
//  StationTableViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "StationTableViewController.h"
#import "SongTableViewCell.h"
#import "RecDataHandle.h"
#import "Song.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "PlayViewController.h"
@interface StationTableViewController ()
{
    MBProgressHUD *HUD;
}
@end

@implementation StationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    [self.tableView registerClass:[SongTableViewCell class] forCellReuseIdentifier:@"cellid"];
    NSLog(@"%@",_url);
    [self requestSongDataWithUrl:_url];
    //下拉刷新
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
}

//下拉刷新对应的方法
-(void)refreshData{
    
    [self requestSongDataWithUrl:_url];
    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
}

//网络请求数据:
-(void)requestSongDataWithUrl:(NSString *)url{
    
    _songArray = [NSMutableArray arrayWithCapacity:30];
    
    [[RecDataHandle creatRecData] DataHandleWithUrl:url andBlock:^(NSData *data) {
        
        [HUD hide:YES];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dict[@"data"];
        //NSLog(@"%@",array);
        for (NSDictionary *dic in array) {
            Song *song = [[Song alloc] init];
            if (![dic[@"url_list"] isEqual:[NSNull null]]&&![dic[@"song_name"] isEqual:[NSNull null]]&&![dic[@"album_name"] isEqual:[NSNull null]]) {
                [song setValue:dic[@"song_name"] forKey:@"song_name"];
                [song setValue:dic[@"album_name"] forKey:@"singer_name"];
                [song setValue:dic[@"url_list"][0][@"url"] forKey:@"url"];
                [_songArray addObject:song];
            }
            
        }
        [self.tableView reloadData];//刷新数据
        
    } failure:^(NSError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接错误，请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:2 animated:YES];
        [HUD hide:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _songArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    return rect.size.width/4 - 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    Song *song = _songArray[indexPath.row];
    cell.song = song;
    cell.autLabel.text = [NSString stringWithFormat:@"%.2ld.",indexPath.row + 1];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Song *song = [Song new];
    song = _songArray[indexPath.row];
    PlayViewController *playVC = [PlayViewController newPlay];
    playVC.song_num = indexPath.row;
    playVC.songArray = _songArray;
    [playVC playMusicWithUrl:song.url];
    playVC.view.frame =[UIScreen mainScreen].bounds;
    [self.tabBarController addChildViewController:playVC];
    [self.tabBarController.view addSubview:playVC.view];
}



@end
