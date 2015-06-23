//
//  SearchTableViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SearchTableViewController.h"
#import "SongTableViewCell.h"
#import "Song.h"
#import "RecDataHandle.h"
#import "MBProgressHUD.h"
#import "PlayViewController.h"
#import "Song.h"
@interface SearchTableViewController ()
{
    NSMutableDictionary *_dict;
    NSMutableArray *_array;
    MBProgressHUD *HUD;
    Song *_song;
}
@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    [self.tableView registerClass:[SongTableViewCell class] forCellReuseIdentifier:@"cell"];
    NSString *str = [NSString stringWithFormat:@"http://so.ard.iyyin.com/s/song_with_out?q=%@&page=1&size=50&app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music",_searchText];
    NSString *str1 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    RecDataHandle *recdataha = [RecDataHandle creatRecData];
    _array = [NSMutableArray arrayWithCapacity:10];
    _songArray = [NSMutableArray arrayWithCapacity:20];
    HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [recdataha DataHandleWithUrl:str1 andBlock:^(NSData *data) {
         [HUD hide:YES];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dict[@"data"];
        for (NSDictionary *dic in array) {
            Song *song = [[Song alloc] init];
            _array =[NSMutableArray arrayWithArray:[dic allKeys]];
            for (NSString *str in _array) {
                if([str isEqualToString:@"pick_count"]){
                     [song setValue:dic[@"pick_count"] forKey:@"pick_count"];
                };
            }
            [song setValue:dic[@"song_name"] forKey:@"song_name"];
            [song setValue:dic[@"singer_name"] forKey:@"singer_name"];
            [song setValue:dic[@"song_id"] forKey:@"song_id"];
            [song setValue:dic[@"url_list"][0][@"url"] forKey:@"url"];
            [_songArray addObject:song];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接错误，请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:2 animated:YES];
        [HUD hide:YES];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    return rect.size.width/2-40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    _song  = _songArray[indexPath.row];
    cell.song = _song;
    cell.autLabel.text = [NSString stringWithFormat:@"%.2ld.",indexPath.row + 1];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    return rect.size.width/4 - 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Song *song1 = [Song new];
    song1 = _songArray[indexPath.row];
    PlayViewController *playVC = [PlayViewController newPlay];
    playVC.song_num = indexPath.row;
    playVC.songArray = _songArray;
    [playVC playMusicWithUrl:song1.url];
    playVC.view.frame = [UIScreen mainScreen].bounds;
    [self.tabBarController addChildViewController:playVC];
    [self.tabBarController.view addSubview:playVC.view];
}



@end
