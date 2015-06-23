//
//  StationCollectionViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "StationCollectionViewController.h"
#import "StationCollectionViewCell.h"
#import "HCollectionReusableView.h"
#import "RecDataHandle.h"
#import "CommonDefine.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "SongListTableViewController.h"
#import "StationTableViewController.h"
static NSString *scellID = @"scell";

@interface StationCollectionViewController ()

{
    NSMutableDictionary *_dict;
     MBProgressHUD *HUD;
}

@end

@implementation StationCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    HUD = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [self.collectionView registerClass:[StationCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //注册页眉
    [self.collectionView registerClass:[HCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //请求数据
    RecDataHandle *recdatah = [RecDataHandle creatRecData];
    [recdatah DataHandleWithUrl:Radio_URL andBlock:^(NSData *data) {
         [HUD hide:YES];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _dict = [NSMutableDictionary dictionaryWithDictionary:dict];
        [self.collectionView reloadData];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSArray *array = _dict[@"data"];
    return array.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = _dict[@"data"];
    NSDictionary *dict = array[section];
    NSArray *array1 = dict[@"data"];
    return array1.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSArray *array = _dict[@"data"];
    NSDictionary *dict = array[indexPath.section];
    NSArray *array1 = dict[@"data"];
    NSDictionary *dict1 = array1[indexPath.row];
    [cell.imagViewS sd_setImageWithURL:[NSURL URLWithString:dict1[@"pic_url_240_200"]]];
    cell.tag_nameLabel.text = dict1[@"tag_name"];
    cell.quantityLabel.text = [NSString stringWithFormat:@"%@首", dict1[@"quantity"]];
    return cell;
}
//设置大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat W = (rect.size.width-30)/2;
    return CGSizeMake(W, W*3/4);
}
//设置间隔
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}
//设置分区行高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(50, 30);
}
//每分区行头
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    NSArray *array = _dict[@"data"];
    NSDictionary *dict = array[indexPath.section];
    header.headerLabel.text =dict[@"tag_type_name"];
    return header;
}
//点击触发
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    StationTableViewController *station = [StationTableViewController new];
    NSArray *array = _dict[@"data"];
    NSDictionary *dict = array[indexPath.section];
    NSArray *array1 = dict[@"data"];
    NSDictionary *dict1 = array1[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"http://fm.api.ttpod.com/vipradiosong?userid=0000001&num=150&tagid=%@&app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music",dict1[@"tag_id"]];
     station.url = url;
    [self.navigationController pushViewController:station animated:YES];
}

@end
