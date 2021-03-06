//
//  MLTableViewController.m
//  TTYT
//
//  Created by lanou3g on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MLTableViewController.h"
#import "MLTableViewCell.h"
#import "NewMicCollectionViewController.h"
#import "SingerCollectionViewController.h"
#import "StationCollectionViewController.h"
#import "ClassCollectionViewController.h"
#import "SearchTableViewController.h"
#import "RecDataHandle.h"
#import "SongTableViewCell.h"
#import "SeBarTableViewController.h"
#import "SongListTableViewController.h"
#import "SongListTableViewController.h"
#import "MJRefresh.h"
#import "WebViewController.h"
static NSString *MLCellID = @"mlcellid";

@interface MLTableViewController ()
{
    NSMutableArray *_array;
    NSString *_mutstr;
}
@end

@implementation MLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加刷新
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshing)];
    _mutstr = [NSMutableString stringWithCapacity:1];

    [self.tableView registerClass:[MLTableViewCell class] forCellReuseIdentifier:MLCellID];
    //添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xiangqing:) name:@"title" object:nil];
    //搜索
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = left;
}
//刷新方法
-(void)refreshing{
    [self.tableView.header endRefreshing];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
//搜索:
-(void)search{
    SeBarTableViewController *sebar = [SeBarTableViewController new];
    [self.navigationController pushViewController:sebar animated:YES];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MLCellID  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    return rect.size.width*1.31;
}

//通知方法
-(void)xiangqing:(NSNotification *)button{
    NSString *tag = button.object;
    NSLog(@"%@",tag);
    if ([tag isEqualToString:@"1"]) {
        UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc] init];
        NewMicCollectionViewController *newCVC = [[NewMicCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        [self.navigationController pushViewController:newCVC animated:YES];
    }else if([tag isEqualToString:@"2"]){
        UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
        SingerCollectionViewController *singer = [[SingerCollectionViewController alloc] initWithCollectionViewLayout:flowLayout2];
        [self.navigationController pushViewController:singer animated:YES];
    }else if ([tag isEqualToString:@"3"]){
        UICollectionViewFlowLayout *flowLayout3 = [[UICollectionViewFlowLayout alloc] init];
        StationCollectionViewController *stationCVC = [[StationCollectionViewController alloc] initWithCollectionViewLayout:flowLayout3];
        [self.navigationController pushViewController:stationCVC animated:YES];
    }else if ([tag isEqualToString:@"4"]){
        SongListTableViewController *song = [SongListTableViewController new];
        song.url = @"http://api.dongting.com/channel/channel/0/songs?size=50&app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music";
          [self.navigationController pushViewController:song animated:YES];
    }else if ([tag isEqualToString:@"5"]){
        UICollectionViewFlowLayout *flowLayout4 = [UICollectionViewFlowLayout new];
        ClassCollectionViewController *classCVC = [[ClassCollectionViewController alloc] initWithCollectionViewLayout:flowLayout4];
        [self.navigationController pushViewController:classCVC animated:YES];
    }else if ([tag isEqualToString:@"6"]){
        WebViewController *webViewC = [[WebViewController alloc] init];
        webViewC.str_url = @"http://fm.ttpod.com/mindex.html";
        webViewC.name = @"FM";
        [self.navigationController pushViewController:webViewC animated:YES];
    }
}


@end
