//
//  MVViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MVViewController.h"
#import "MusicLibraryCollectionViewCell.h"
#import "MVCollectionViewCell.h"
#import "MVCollectionViewController.h"
#import "RecDataHandle.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MVTableViewCell.h"
#import "MVPlayViewController.h"
#import "PlayViewController.h"
@interface MVViewController ()
{
    MBProgressHUD *HUD1;
    MBProgressHUD *HUD2;
    CGRect _rect;
    NSString * _classid;
    NSArray *_arrayColltion;
    NSArray *_arrayTabel;
    NSInteger _tableSize;
    NSInteger _colltionSize;
    NSNotification *_userInfor;
    UISegmentedControl *_segment;
    UIButton *_button1;
    UIButton *_button2;
    UIView *_view;
    UIColor *_blueColor;
}
@end

@implementation MVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"MV";
    _rect = [UIScreen mainScreen].bounds;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, _rect.size.width, _rect.size.height)];
    _scrollView.contentSize = CGSizeMake(_rect.size.width*2, _rect.size.height-112);
    //tabelView
    [self drawTableView];
    [_scrollView addSubview:_tabelView];

    _blueColor = [UIColor colorWithRed:70/255.0 green:110/255.0 blue:250/255.0 alpha:1];
    //colltionView
    [self drawColltionView];
    [self information:nil];
    [_scrollView addSubview:_collectionView];
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    _button1.frame = CGRectMake(10, 0, (_rect.size.width-20)/2, 30);
    [_button1 setTitle:@"每日一发" forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(sgeAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_button1];
    
    _button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    _button2.frame = CGRectMake((_rect.size.width-20)/2+10, 0, (_rect.size.width-20)/2, 30);
    [_button2 setTitle:@"MV分类" forState:UIControlStateNormal];
    [_button2 addTarget:self action:@selector(sgeAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_button2];
    _button2.tintColor = [UIColor grayColor];
    _button1.tintColor = _blueColor;
    _view = [[UIView alloc] initWithFrame:CGRectMake(10, 27, (_rect.size.width-20)/2, 3)];
    _view.backgroundColor = _blueColor;
    [self.view addSubview:_view];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, _rect.size.width, 1)];
    label.backgroundColor = [UIColor grayColor];
    [self.view addSubview:label];
}
-(void)sgeAction:(UIButton *)button{
    if ([button.titleLabel.text isEqualToString:@"MV分类"]) {
        _button2.tintColor = _blueColor;
        _button1.tintColor = [UIColor grayColor];
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(_rect.size.width, 0);
        }];
    }else{
        _button2.tintColor = [UIColor grayColor];
        _button1.tintColor = _blueColor;
        [UIView animateWithDuration:0.5 animations:^{
            _scrollView.contentOffset = CGPointMake(0, 0);
        }];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (_scrollView.contentOffset.x == 0) {
        _button2.tintColor = [UIColor grayColor];
        _button1.tintColor = _blueColor;
    }else{
        _button2.tintColor = _blueColor;
        _button1.tintColor = [UIColor grayColor];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [UIView animateWithDuration:0.1 animations:^{
        _view.frame = CGRectMake(10+_scrollView.contentOffset.x/2.1, 27, (_rect.size.width-20)/2, 3);
    }];
}
//colltionView
-(void)drawColltionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_rect.size.width, 0, _rect.size.width, _scrollView.contentSize.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MVCollectionViewCell class] forCellWithReuseIdentifier:@"coll"];
    _classButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _classButton.frame = CGRectMake(10, 17.5, 80, 25);
    [_classButton setTitle:@"全部" forState:UIControlStateNormal];
    _classButton.layer.borderWidth = 1;
    _classButton.layer.borderColor = _blueColor.CGColor;
    _classButton.layer.cornerRadius = 3;
    _classButton.layer.masksToBounds = YES;
    [_classButton addTarget:self action:@selector(classButton:) forControlEvents:UIControlEventTouchDown];
    UIImageView *imagevV = [[UIImageView alloc] initWithFrame:CGRectMake(65, 5, 7, 15)];
    imagevV.image = [UIImage imageNamed:@"arrow.ico"];
    [_classButton addSubview:imagevV];
    [_collectionView addSubview:_classButton];
    _colltionSize = 12;
    //添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(information:) name:@"nameID" object:nil];
    //添加下拉刷新
    [_collectionView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(refreshing)];
    //添加上拉刷新
    [_collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(shuaxin)];
}
//刷新方法
-(void)refreshing{
    [_collectionView.header endRefreshing];
}
-(void)shuaxin{
    _colltionSize = _colltionSize+12;
    [self information:_userInfor];
    [_collectionView.footer endRefreshing];
}
//通知方法
-(void)information:(NSNotification *)userInfo{
    NSDictionary *dict =userInfo.userInfo;
    _userInfor = userInfo;
    if (userInfo == nil) {
        dict = @{@"name":@"全部",@"id":@"0"};
    }
    [_classButton setTitle:dict[@"name"] forState:UIControlStateNormal];
    NSString *url = [NSString stringWithFormat:@"http://api.dongting.com/song/video/type/%@?order=2&page=1&size=%@&app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music",dict[@"id"],[NSString stringWithFormat:@"%ld",_colltionSize]];
    RecDataHandle *rectdata = [RecDataHandle creatRecData];
    HUD1 = [MBProgressHUD showHUDAddedTo:_collectionView animated:YES];
    [rectdata DataHandleWithUrl:url andBlock:^(NSData *data){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _arrayColltion = [NSArray arrayWithArray:dict[@"data"]];
        [HUD1 hide:YES];
        [_collectionView reloadData];
    } failure:^(NSError *error){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接错误，请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:2 animated:YES];
        [HUD1 hide:YES];
    }];
}
-(void)classButton:(UIButton *)button{
    _colltionSize = 12;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    MVCollectionViewController *classCVC = [[MVCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
    [self.navigationController pushViewController:classCVC animated:YES];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _arrayColltion.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MVCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"coll" forIndexPath:indexPath];
    NSDictionary *dict = _arrayColltion[indexPath.row];
    [cell.imgView sd_setImageWithURL:dict[@"picUrl"]];
    cell.label1.text = dict[@"videoName"];
    cell.label2.text = dict[@"singerName"];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((_rect.size.width-30)/2, (_rect.size.width-30)/3*1.3);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(50, 50);
}

//collection点击事件:
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *dict = _arrayColltion[indexPath.row];
    NSArray *array = dict[@"mvList"];
    NSDictionary *dic = array[0];
    MVPlayViewController *MVPlayVC = [MVPlayViewController new];
    MVPlayVC.str_url = dic[@"url"];
    MVPlayVC.str_title = dict[@"videoName"];
    PlayViewController *play = [PlayViewController newPlay];
    [play stopMuisc];
    [self presentViewController:MVPlayVC animated:NO completion:nil];
}
//布局tableView
-(void)drawTableView{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _rect.size.width, _scrollView.contentSize.height)];
    [_tabelView registerClass:[MVTableViewCell class] forCellReuseIdentifier:@"table"];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tableSize = 5;
    //数据处理
    [self information];
    //添加上拉刷新
    [_tabelView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(shuaxin1)];
}
-(void)shuaxin1{
    _tableSize = _tableSize+5;
    [self information];
}
-(void)information{
    NSString *url = [NSString stringWithFormat:@"http://api.dongting.com/channel/channel/mvs?page=1&size=%@&app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music",[NSString stringWithFormat:@"%ld",_tableSize]];
    RecDataHandle *rectdata = [RecDataHandle creatRecData];
    HUD2 = [MBProgressHUD showHUDAddedTo:_tabelView animated:YES];
    [rectdata DataHandleWithUrl:url andBlock:^(NSData *data){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _arrayTabel = [NSArray arrayWithArray:dict[@"data"]];
        [HUD2 hide:YES];
        [_tabelView reloadData];
        [_tabelView.footer endRefreshing];
    } failure:^(NSError *error){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接错误，请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:2 animated:YES];
        [HUD2 hide:YES];
        [_tabelView.footer endRefreshing];
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayTabel.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"table" forIndexPath:indexPath];
    NSDictionary *dict = _arrayTabel[indexPath.row];
    NSDate *date = [NSDate date];
    NSDate *date1 = [date dateByAddingTimeInterval:-(3600*24)*indexPath.row];
    NSDateFormatter *formatt1 = [NSDateFormatter new];
    [formatt1 setDateFormat:@"MM"];
    NSDateFormatter *formatt2 = [NSDateFormatter new];
    [formatt2 setDateFormat:@"dd"];
    cell.timeDay.text = [formatt2 stringFromDate:date1];
    cell.timeMonth.text = [formatt1 stringFromDate:date1];
    cell.descLable.text = dict[@"desc"];
    if ([dict[@"tag"] count]>=2) {
        NSDictionary *tag1 = dict[@"tag"][0];
        NSDictionary *tag2 = dict[@"tag"][1];
        NSString *str1 = tag1[@"tagColor"];
        NSString *str2 = tag2[@"tagColor"];
        NSRange range1 = {5,3};
        NSRange range2 = {9,3};
        NSRange range3 = {13,3};
        NSInteger red = [[str1 substringWithRange:range1] integerValue];
        NSInteger gre = [[str1 substringWithRange:range2] integerValue];
        NSInteger blu = [[str1 substringWithRange:range3] integerValue];
        NSInteger red1 = [[str2 substringWithRange:range1] integerValue];
        NSInteger gre1 = [[str2 substringWithRange:range2] integerValue];
        NSInteger blu1 = [[str2 substringWithRange:range3] integerValue];
        cell.tagName1.text = tag1[@"tagName"];
        cell.tagName1.backgroundColor = [UIColor colorWithRed:red/255.0 green:gre/255.0 blue:blu/255.0 alpha:0.5];
        cell.tagName2.text = tag2[@"tagName"];
        cell.tagName2.backgroundColor = [UIColor colorWithRed:red1/255.0 green:gre1/255.0 blue:blu1/255.0 alpha:0.5];
        CGFloat W = [UIScreen mainScreen].bounds.size.width-30;
        CGSize size =[tag1[@"tagName"] sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]}];
        cell.tagName1.frame = CGRectMake(W*2/15+25, W*2/15+15,  size.width, 15);
        cell.tagName2.frame = CGRectMake(W*2/15+35+size.width, W*2/15+15, [tag2[@"tagName"] sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]}].width, 15);
    }
    if (indexPath.row == 0) {
        cell.timeDay.textColor = _blueColor;
    }else{
        cell.timeDay.textColor = [UIColor grayColor];
    }

    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:dict[@"bigPicUrl"]]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    return rect.size.width*0.74;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = _arrayTabel[indexPath.row];
    NSArray *array = dict[@"mvList"];
    NSDictionary *dic = array[0];
    MVPlayViewController *MVPlayVC = [MVPlayViewController new];
    MVPlayVC.str_url = dic[@"url"];
    PlayViewController *play = [PlayViewController newPlay];
    [play stopMuisc];
    [self presentViewController:MVPlayVC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
