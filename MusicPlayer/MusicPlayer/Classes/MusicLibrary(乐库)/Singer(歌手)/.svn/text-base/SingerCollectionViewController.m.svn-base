//
//  SingerCollectionViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SingerCollectionViewController.h"
#import "MusicLibraryCollectionViewCell.h"
#import "RecDataHandle.h"
#import "CommonDefine.h"
#import "UIImageView+WebCache.h"
#import "SingerTableViewController.h"
#import "MBProgressHUD.h"
@interface SingerCollectionViewController ()

{
    NSMutableDictionary *_dict;
    MBProgressHUD *HUD;
}

@end

@implementation SingerCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    HUD = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    [self.collectionView registerClass:[MusicLibraryCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //数据获取
    RecDataHandle *singrecData = [RecDataHandle creatRecData];
    [singrecData DataHandleWithUrl:SONGER_URL andBlock:^(NSData *data) {
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

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = _dict[@"data"];
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicLibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSArray *array = _dict[@"data"];
    NSDictionary *dict = array[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"pic_url"]]];
    cell.label.text = dict[@"title"];
    return cell;
}
//设置尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat W = (rect.size.width - 40)/3;
    return CGSizeMake(W, W*1.2);
}
//设置间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(9, 9, 9, 9);
}
//点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
    NSArray *array = _dict[@"data"];
    NSDictionary *dict = array[indexPath.row];
    SingerTableViewController *sing = [SingerTableViewController new];
    sing.urlid = dict[@"id"];
    [self.navigationController pushViewController:sing animated:YES];
}

#pragma mark <UICollectionViewDelegate>


@end
