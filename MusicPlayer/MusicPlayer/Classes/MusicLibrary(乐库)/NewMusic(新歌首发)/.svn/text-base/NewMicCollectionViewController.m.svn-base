//
//  NewMicCollectionViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewMicCollectionViewController.h"
#import "MusicLibraryCollectionViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "HCollectionReusableView.h"
#import "CommonDefine.h"
#import "RecDataHandle.h"
#import "UIImageView+WebCache.h"
#import "WheelTableViewController.h"
#import "MBProgressHUD.h"
@interface NewMicCollectionViewController ()
{
    NSMutableDictionary *_dict;
    NSMutableArray *_array;
    MBProgressHUD *HUD;
}
@end

@implementation NewMicCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MusicLibraryCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
      HUD = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    RecDataHandle *recdata = [RecDataHandle creatRecData];
    [recdata DataHandleWithUrl:NEWSONG_URL andBlock:^(NSData *data) {
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

//设置尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect1 = [UIScreen mainScreen].bounds;
    CGFloat W1 = (rect1.size.width - 30)/2;
    if (indexPath.section == 0) {
        CGRect rect = [UIScreen mainScreen].bounds;
        CGFloat W = (rect.size.width - 40)/3;
        return CGSizeMake(W , W*1.2);
    }
    return CGSizeMake(W1, W1*1.3);
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    NSArray *array = _dict[@"data"];
    return array.count;
}

//cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicLibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"1.jpg"];
    NSArray *array1 = _dict[@"data"];
    NSArray *array2 = _dict[@"singles"];
    if (indexPath.section == 0) {
        NSDictionary *dict =array2[indexPath.row];
        cell.label.text = dict[@"title"];
        cell.label2.text = nil;
        [cell.imageView sd_setImageWithURL:dict[@"pic"]];
    }
    if (indexPath.section == 1) {
        NSDictionary *dict1 = array1[indexPath.row];
        cell.label.text = dict1[@"title"];
        cell.label2.text = dict1[@"title"];
        [cell.imageView sd_setImageWithURL:dict1[@"pic"]];
    }
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(9, 9, 9, 9); //设置上下左右间距
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
    WheelTableViewController *wheel = [WheelTableViewController new];
    NSArray *array1 = _dict[@"data"];
    NSArray *array2 = _dict[@"singles"];
      if (indexPath.section == 0) {
        wheel.num_id = array2[indexPath.row][@"msg_id"];
    }else if (indexPath.section == 1){
        wheel.num_id = array1[indexPath.row][@"msg_id"];
    }
    [self.navigationController pushViewController:wheel animated:YES];
}
#pragma mark <UICollectionViewDelegate>



@end
