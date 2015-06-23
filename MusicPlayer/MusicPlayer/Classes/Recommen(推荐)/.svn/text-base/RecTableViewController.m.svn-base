
//
//  RecTableViewController.m
//  TTYT
//
//  Created by 张毅 on 15/5/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RecTableViewController.h"
#import "FirstTableViewCell.h"
#import "SecondTableViewCell.h"
#import "RecSection.h"
#import "MBProgressHUD.h"
#import "RecRow.h"
#import "UIImageView+WebCache.h"
#import "WheelTableViewController.h"
#import "WebViewController.h"
#import "AFNetworking.h"
#import "SongListTableViewController.h"
#import "NewMicCollectionViewController.h"
static NSString *firstCell = @"firstCell";
static NSString *secondCell = @"secondCell";

@interface RecTableViewController ()
{
    RecDataHandle *_recData;
    WebViewController *webVC;
    MBProgressHUD *HUD;
}
@end

@implementation RecTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    _rect = [UIScreen mainScreen].bounds;
     [self.tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:firstCell];
    [self.tableView registerClass:[SecondTableViewCell class] forCellReuseIdentifier:secondCell];
     HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    _recData = [RecDataHandle creatRecData];
     [self requestData];
    
  }
//下拉刷新数据:
-(void)refreshData{
    [_RecArray removeAllObjects];
    [self.tableView reloadData];
    [self requestData];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

//请求网络数据:
-(void)requestData{
    NSString *Rec_url = [NSString stringWithFormat:@"%@?%@&version=0",RECOM_URL,COM_URL];
    [_recData DataHandleWithUrl:Rec_url andBlock:^(NSData *data) {
        [HUD hide:YES];
        NSDictionary *Dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *Dic = Dict[@"data"];
        NSArray *Array = Dic[@"songlists"];
        _RecArray = [NSMutableArray arrayWithCapacity:30];
        for (NSDictionary *dic in Array) {
            RecSection *recSec = [RecSection new];
            [recSec setValue:dic[@"_id"] forKey:@"_id"];
            [recSec setValue:dic[@"action"] forKey:@"action"];
            [recSec setValue:dic[@"data"] forKey:@"data"];
            [recSec setValue:dic[@"desc"] forKey:@"desc"];
            [recSec setValue:dic[@"name"] forKey:@"name"];
            [recSec setValue:dic[@"order"] forKey:@"order"];
            [recSec setValue:dic[@"style"] forKey:@"style"];
            NSString *type = [NSString stringWithFormat:@"%@",recSec.action[@"type"]];
            if (![type isEqualToString:@"200"]) {
                [_RecArray addObject:recSec];
            }
        }
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接错误，请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:2 animated:YES];
         [HUD hide:YES];
    }];
}


//跳转到wheelVC页面:
-(void)pushWheelVC:(RecRow *)row{
    WheelTableViewController *wheelVC = [WheelTableViewController new];
    wheelVC.num_id = row.num_id;
    [self.navigationController pushViewController:wheelVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理方法:

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    
    return _RecArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    RecSection *rec = [RecSection new];
    rec = _RecArray[section];
    [self reloadRowDataInSection:section];
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 1;
            break;
          default:
            if (rec.style == 2) {
                return _RowArray.count;
            }
            break;
    }
    return 1;
}
//解析分组行的数据:
-(void)reloadRowDataInSection:(NSInteger)section{
    RecSection *rec = [RecSection new];
    rec = _RecArray[section];
    NSArray *array = rec.data;
    _RowArray = [NSMutableArray arrayWithCapacity:30];
    for (NSDictionary *dic in array) {
        RecRow *row = [RecRow new];
        [row setValue:dic[@"_id"] forKey:@"_id"];
        [row setValue:dic[@"action"] forKey:@"action"];
        [row setValue:dic[@"desc"] forKey:@"desc"];
        [row setValue:dic[@"name"] forKey:@"name"];
        [row setValue:dic[@"order"] forKey:@"order"];
        [row setValue:dic[@"pic_url"] forKey:@"pic_url"];
        [row setValue:dic[@"author"] forKey:@"author"];
        [row setValue:dic[@"id"] forKey:@"num_id"];
        [row setValue:dic[@"listen_count"] forKey:@"listen_count"];
        [_RowArray addObject:row];
    }
    if ([rec.name isEqualToString:@"个性化推荐"]) {
        [_RowArray removeObjectAtIndex:0];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecSection *rec = [RecSection new];
    rec = _RecArray[indexPath.section];
    [self reloadRowDataInSection:indexPath.section];
    if (rec.style == 2) {
        FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCell forIndexPath:indexPath];
        RecRow *row = [RecRow new];
        row = _RowArray[indexPath.row];
            cell.titleLabel.text = row.name;
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:row.pic_url]];
            cell.label.text = row.desc;
        return cell;
    }
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCell forIndexPath:indexPath];
    cell.array = _RowArray;
    for (int i =0; i< 3;i++ ) {
        UIImageView *imgView = cell.imgArray[i];
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImgView:)];
         [imgView addGestureRecognizer:tap];
    }
    

    return cell;
}
//每张图片的tap手势的事件:
- (void)tapImgView:(UITapGestureRecognizer *)tapGR
{
    SecondTableViewCell * cell = (SecondTableViewCell *)[[tapGR.view superview] superview];
       NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    RecSection *rec = [RecSection new];
    rec = _RecArray[indexPath.section];
    [self reloadRowDataInSection:indexPath.section];
        RecRow *row = [RecRow new];
    if (_RowArray.count != 0) {
          row = _RowArray[tapGR.view.tag - 100];
    }
    NSString *type = [NSString stringWithFormat:@"%@",row.action[@"type"]];
    if ([type isEqualToString:@"1"]) {
            [self loadWebView:row];
    }else{
        [self pushWheelVC:row];
    }
}

//设置每个分区的头标题:
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    RecSection *rec = [RecSection new];
    rec = _RecArray[section];
    return rec.name;
}
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecSection *rec = [RecSection new];
    rec = _RecArray[indexPath.section];
    if (rec.style == 2) {
        return _rect.size.width/4;
    }
    return (_rect.size.width-20)/3 + 35;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecSection *rec = [RecSection new];
    rec = _RecArray[indexPath.section];
    [self reloadRowDataInSection:indexPath.section];
    if (rec.style == 2) {
        RecRow *row = [RecRow new];
        row = _RowArray[indexPath.row];
        NSString *type = [NSString stringWithFormat:@"%@",row.action[@"type"]];
        if ([type isEqualToString:@"1"]) {
            [self loadWebView:row];
        }else if ([type isEqualToString:@"6"]){
            SongListTableViewController *songVC = [SongListTableViewController new];
            NSString *str_url = [NSString stringWithFormat:@"%@&%@",EVEFAV_URL,COM_URL];
            songVC.url = str_url;
            songVC.name = row.name;
        [self.navigationController pushViewController:songVC animated:YES];
        }else if ([type isEqualToString:@"10"]){
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            NewMicCollectionViewController *newCVC = [[NewMicCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
            [self.navigationController pushViewController:newCVC animated:YES];
        }else{
            [self pushWheelVC:row];
        }
    }
}

//设置第一个分区头为轮播图:
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    [self reloadRowDataInSection:section];
    if (section == 0) {
        NSMutableArray *imgArray = [NSMutableArray arrayWithCapacity:10];
        NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:10];
        for (RecRow *r in _RowArray) {
            [imgArray addObject:[NSURL URLWithString:r.pic_url]];
            [titleArray addObject:r.name];
        }
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 5, _rect.size.width - 20, _rect.size.width*2/5 - 5) imageURLsGroup:imgArray];
    cycleScrollView.titlesGroup = titleArray; // 设置title数组
        cycleScrollView.autoScrollTimeInterval = 4;
        cycleScrollView.delegate = self;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, _rect.size.width*2/5)];
        [view addSubview:cycleScrollView];
        return view;
    }
    return nil;
}

//轮播图点击事件:(代理方法)
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    [self reloadRowDataInSection:0];
    RecRow *row = [RecRow new];
    row = _RowArray[index];
    NSString *type = [NSString stringWithFormat:@"%@",row.action[@"type"]];
    if ([type isEqualToString:@"1"]) {
        [self loadWebView:row];
    }else{
        [self pushWheelVC:row];
    }
}
//加载网页:
-(void)loadWebView:(RecRow *)row{
    webVC = [WebViewController new];
    webVC.name = row.name;
    webVC.str_url = row.action[@"value"];
    [self.navigationController pushViewController:webVC animated:YES];
}
//设置分区头高度:
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return _rect.size.width*2/5;
    }
    return 30;
}


@end
