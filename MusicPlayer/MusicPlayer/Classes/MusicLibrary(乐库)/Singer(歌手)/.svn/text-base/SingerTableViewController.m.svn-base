//
//  SingerTableViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SingerTableViewController.h"
#import "SingTableViewCell.h"
#import "CommonDefine.h"
#import "RecDataHandle.h"
#import "UIImageView+WebCache.h"
#import "WheelTableViewController.h"
#import "SongListTableViewController.h"
#import "MBProgressHUD.h"
static NSString *cellID = @"cell";

@interface SingerTableViewController ()

{
    NSMutableDictionary *_dict;
    MBProgressHUD *HUD;
}

@end

@implementation SingerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [self.tableView registerClass:[SingTableViewCell class] forCellReuseIdentifier:cellID];
    NSLog(@"===%@",_urlid);
    NSString *str = [NSString stringWithFormat:@"http://v1.ard.tj.itlily.com/ttpod?a=getnewttpod&id=%@&size=1000&page=1",_urlid];
    NSString *str2 = [str stringByAppendingString:COM_URL];
    NSLog(@"%@",str2);
    RecDataHandle *recdata = [RecDataHandle creatRecData];
    [recdata DataHandleWithUrl:str2 andBlock:^(NSData *data) {
         [HUD hide:YES];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _dict = [NSMutableDictionary dictionaryWithDictionary:dict];
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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _dict[@"data"];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSArray *array = _dict[@"data"];
    NSDictionary *dict = array[indexPath.row];
    cell.label.text = dict[@"singer_name"];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:dict[@"pic_url"]]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat W = rect.size.width;
    return 0.2*W;
}

//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SongListTableViewController *song = [SongListTableViewController new];
    NSArray *array = _dict[@"data"];
    NSDictionary *dict = array[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"http://api.dongting.com/song/singer/%@/songs?page=1&size=50&app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music",dict[@"singer_id"]];
     song.url = url;
     [self.navigationController pushViewController:song animated:YES];
}


@end
