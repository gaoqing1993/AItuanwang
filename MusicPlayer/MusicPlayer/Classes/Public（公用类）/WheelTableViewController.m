//
//  WheelTableViewController.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "WheelTableViewController.h"
#import "MBProgressHUD.h"
#import "CommonDefine.h"
#import "RecDataHandle.h"
#import "Wheel.h"
#import "Song.h"
#import "UIImageView+WebCache.h"
#import "SongTableViewCell.h"
static NSString *songCell = @"songCell";
@interface WheelTableViewController ()

{
    RecDataHandle *_recData;
    MBProgressHUD *HUD;
    PlayViewController *_playVC;
}

@end

@implementation WheelTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.tableView registerClass:[SongTableViewCell class] forCellReuseIdentifier:songCell];
     HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
     _recData = [RecDataHandle creatRecData];
    [self requestData];
}
- (void)BackPrePage{
    //返回上一页
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//请求网络数据:
-(void)requestData{
    NSString *URL = [NSString stringWithFormat:@"%@?msg_ids=%%5B%@%%5D&%@",WHEEL_URL,_num_id,COM_URL];
    NSLog(@"%@",URL);
    [_recData DataHandleWithUrl:URL andBlock:^(NSData *data) {
        NSDictionary *Dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = Dict[@"data"];
        _Array = [NSMutableArray arrayWithCapacity:30];
        for (NSDictionary *dic in array) {
            Wheel *wheel = [Wheel new];
            [wheel setValuesForKeysWithDictionary:dic];
            [_Array addObject:wheel];
        }
        
            [self requestListData:_Array];
            [self.tableView reloadData];
        
    
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接错误，请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:2 animated:YES];
        [HUD hide:YES];
    }];
}

//将上一级数据中的song_id拼接到网址中,请求歌曲列表数据:
-(void)requestListData:(NSMutableArray *)array{
    Wheel *wheel = [Wheel new];
    wheel = [array lastObject];
    NSMutableString *string = [NSMutableString string];
    self.navigationItem.title = wheel.songlistname;
    if (wheel.songlist.count != 0) {
    string = [NSMutableString stringWithString:wheel.songlist[0][@"song_id"]];
        for (int i =1; i< wheel.songlist.count; i++) {
            [string appendFormat:@",%@",wheel.songlist[i][@"song_id"]];
        }
    }
    NSString *url = [NSString stringWithFormat:@"%@?song_id=%@&%@",LIST_URL,string,COM_URL];
    [_recData DataHandleWithUrl:url andBlock:^(NSData *data) {
        [HUD hide:YES];
        NSDictionary *Dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = Dict[@"data"];
        _songArray = [NSMutableArray arrayWithCapacity:30];

            for (NSDictionary *dic in array) {
                Song *song = [Song new];
                [song setValue:dic[@"pick_count"] forKey:@"pick_count"];
                [song setValue:dic[@"singer_id"] forKey:@"singer_id"];
                if (![dic[@"singer_name"]isEqual:[NSNull null]]) {
                    [song setValue:dic[@"singer_name"] forKey:@"singer_name"];
                }
                [song setValue:dic[@"song_id"] forKey:@"song_id"];
                [song setValue:dic[@"song_name"] forKey:@"song_name"];
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
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   
    return _songArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:songCell];
    Song *song = _songArray[indexPath.row];
    cell.song = song;
    cell.autLabel.text = [NSString stringWithFormat:@"%ld.",indexPath.row + 1];
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
    playVC.songID = song.song_id;
    playVC.songArray = _songArray;
    [playVC playMusicWithUrl:song.url];
    playVC.view.frame = [UIScreen mainScreen].bounds;
    [self.tabBarController addChildViewController:playVC];
    [self.tabBarController.view addSubview:playVC.view];
}

@end
