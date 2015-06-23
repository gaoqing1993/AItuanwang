//
//  MVPlayViewController.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MVPlayViewController.h"
#import "MVPlayTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface MVPlayViewController ()

@end

@implementation MVPlayViewController
-(void)setStr_url:(NSString *)str_url{
    if (_str_url != str_url) {
        _str_url = str_url;
    }
    [self playMVWithUrl:str_url];
  }

-(void)playMVWithUrl:(NSString *)str{
    _rect = [UIScreen mainScreen].bounds;
    NSURL *url = [NSURL URLWithString:str];
    _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
    _moviePlayer.view.frame = CGRectMake(0, 20, _rect.size.width, _rect.size.width*0.5);
    _button = [UIButton buttonWithType:UIButtonTypeSystem ];
    _button.frame = CGRectMake(10, 10, 30, 30);
    [_button setImage:[UIImage imageNamed:@"箭头1"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(backNextPage) forControlEvents:UIControlEventTouchUpInside];
    [_moviePlayer.view addSubview:_button];
    [_moviePlayer play];
    [self.view addSubview:_moviePlayer.view];
}



-(void)setStr_title:(NSString *)str_title{
    if (_str_title != str_title) {
        _str_title = str_title;
    }
    _rect = [UIScreen mainScreen].bounds;
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, _rect.size.width*0.5+25, _rect.size.width-20, 30)];
    _titleLabel.text = str_title;
    [self.view addSubview:_titleLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _rect = [UIScreen mainScreen].bounds;
    _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, _rect.size.width * 0.5+60, _rect.size.width,_rect.size.height-_rect.size.width * 0.5-60) style:UITableViewStylePlain];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    [_tabView registerClass:[MVPlayTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tabView];
    [self requestData];
}

-(void)backNextPage{
    [_moviePlayer stop];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)requestData{
    NSString *url = @"http://api.dongting.com/sim/mv/682085/similarity?app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music";
      RecDataHandle *rectdata = [RecDataHandle creatRecData];
    [rectdata DataHandleWithUrl:url andBlock:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dict[@"data"];
        _MVArray = [NSMutableArray arrayWithCapacity:30];
        for (NSDictionary *dic in array) {
            [_MVArray addObject:dic];
        }
        [_tabView reloadData];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接错误，请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:2 animated:YES];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _MVArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    return  rect.size.width*0.3+10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MVPlayTableViewCell *cell = [_tabView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dict = _MVArray[indexPath.row];
    NSArray *array = dict[@"mvList"];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:array[0][@"picUrl"]]];
    cell.title_Label.text = dict[@"videoName"];
    cell.singerLabel.text = dict[@"singerName"];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"推荐MV";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = _MVArray[indexPath.row];
    NSArray *array = dict[@"mvList"];
    _titleLabel.text = dict[@"videoName"];
    [self playMVWithUrl:array[0][@"url"]];
}

@end
