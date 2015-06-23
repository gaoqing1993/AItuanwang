//
//  SongListTableViewController.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SongListTableViewController.h"
#import "MBProgressHUD.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeader.h"
#import "DataBaseManager.h"
static NSString *songID = @"songID";

@interface SongListTableViewController ()
{
    MBProgressHUD *HUD;
    DataBaseManager *_data;
}
@end

@implementation SongListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _name;
    
    HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    self.tabBarController.tabBar.hidden = YES;    
    [self.tableView registerClass:[SongTableViewCell class] forCellReuseIdentifier:songID];
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


- (void)BackPrePage{
    //返回上一页
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//网络请求数据:
-(void)requestSongDataWithUrl:(NSString *)url{
    
    _songArray = [NSMutableArray arrayWithCapacity:30];
    
    [[RecDataHandle creatRecData] DataHandleWithUrl:url andBlock:^(NSData *data) {
        
        [HUD hide:YES];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *_array = dict[@"data"];
        
        for (NSDictionary *dic in _array) {
            Song *song = [[Song alloc] init];
            [song setValue:dic[@"name"] forKey:@"song_name"];
            [song setValue:dic[@"singerName"] forKey:@"singer_name"];
            [song setValue:dic[@"singerId"] forKey:@"singer_id"];
            [song setValue:dic[@"favorites"] forKey:@"pick_count"];
            [song setValue:dic[@"songId"] forKey:@"song_id"];
            [song setValue:dic[@"urlList"][0][@"url"] forKey:@"url"];
            [_songArray addObject:song];
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

#pragma mark - Table view 代理方法:

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return _songArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:songID forIndexPath:indexPath];
    Song *song = _songArray[indexPath.row];
    cell.song = song;
    cell.autLabel.text = [NSString stringWithFormat:@"%.2ld.",indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    return rect.size.width/4 - 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Song *song = [Song new];
    song = _songArray[indexPath.row];
    PlayViewController *playVC = [PlayViewController newPlay];
    playVC.song_num = indexPath.row;
    playVC.songArray = _songArray;
    [playVC playMusicWithUrl:song.url];
    playVC.view.frame = [UIScreen mainScreen].bounds;
    [self.tabBarController addChildViewController:playVC];
    [self.tabBarController.view addSubview:playVC.view];
}

@end
