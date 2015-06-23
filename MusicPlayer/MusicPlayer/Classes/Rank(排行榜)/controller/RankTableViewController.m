//
//  RankTableViewController.m
//  TTYT
//
//  Created by 焦鹏 on 15/5/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RankTableViewController.h"
#import "MBProgressHUD.h"
#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeader.h"

static NSString *RankID = @"rankID";

@interface RankTableViewController ()

{
    RecDataHandle *_rankData;
     MBProgressHUD *HUD;
    PlayViewController *_playVC;
}

@end

@implementation RankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [self.tableView registerClass:[RankTableViewCell class] forCellReuseIdentifier:RankID];
    
    [self requestData];
    
    //下拉刷新
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
}

//下拉刷新方法
-(void)refreshData{
    [self requestData];
    [self.tableView reloadData];
   }

//请求网络数据:
-(void)requestData{
    //拼接字符串
    NSString *rankURL = [NSString stringWithFormat:@"%@&%@",Rank1_URL,COM_URL];
    _rankArray = [NSMutableArray arrayWithCapacity:30];
    [[RecDataHandle creatRecData] DataHandleWithUrl:rankURL andBlock:^(NSData *data) {
        [HUD hide:YES];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *_array = dict[@"data"];
        for (NSDictionary *dic in _array) {
            Rank *rank = [[Rank alloc] initWithDic:dic];
            [_rankArray addObject:rank];
        }
        [self.tableView reloadData];//刷新数据
        [self.tableView.header endRefreshing];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接错误，请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:2 animated:YES];
        [HUD hide:YES];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)reloadData{
    
    [self.tableView reloadData];
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
    return _rankArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RankID forIndexPath:indexPath];
    Rank *rank = _rankArray[indexPath.row];
    cell.rank = rank;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    return rect.size.width/2 - 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Rank *rank = _rankArray[indexPath.row];
    SongListTableViewController *songVC = [SongListTableViewController new];
    NSString *str_url =[NSString stringWithFormat:@"http://api.dongting.com/channel/ranklist/%ld/songs?page=1&%@",(long)rank.name_id,COM_URL];
    songVC.url = str_url;
    songVC.name = rank.title;
    [self.navigationController pushViewController:songVC animated:YES];
}

@end
