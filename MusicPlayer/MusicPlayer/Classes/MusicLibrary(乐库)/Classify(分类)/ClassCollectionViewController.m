//
//  ClassCollectionViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ClassCollectionViewController.h"
#import "MusicLibraryCollectionViewCell.h"
#import "HCollectionReusableView.h"
#import "RecDataHandle.h"
#import "UIImageView+WebCache.h"
#import "CommonDefine.h"
#import "MBProgressHUD.h"
#import "SongListTableViewController.h"
@interface ClassCollectionViewController ()
{
    NSMutableDictionary *_mutDict;
    NSMutableArray *_nameArray;
     MBProgressHUD *HUD;
}
@end

@implementation ClassCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MusicLibraryCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[HCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //请求数据
    HUD = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    RecDataHandle *recDataC = [RecDataHandle creatRecData];
    [recDataC DataHandleWithUrl:Category_URL andBlock:^(NSData *data) {
         [HUD hide:YES];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dict[@"data"];
        _mutDict = [NSMutableDictionary dictionaryWithCapacity:20];
        _nameArray = [NSMutableArray arrayWithCapacity:10];
        
        for (NSDictionary *dict in array) {
            NSString *name = dict[@"parentname"];
            NSMutableArray *array1 = [_mutDict objectForKey:name];
            if (array1 == nil) {
                [_nameArray addObject:name];
                array1 = [NSMutableArray arrayWithCapacity:5];
                [_mutDict setObject:array1 forKey:name];
            }
            [array1 addObject:dict];
        }
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

    return _nameArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = [_mutDict objectForKey:_nameArray[section]];
    return array.count;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 9, 10, 9);
}
//设置尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rect = [UIScreen mainScreen].bounds;
    return CGSizeMake((rect.size.width-40)/3, (rect.size.width-40)/3*1.2);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicLibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSArray *array = _mutDict[_nameArray[indexPath.section]];
    NSDictionary *dict = array[indexPath.row];
    [cell.imageView sd_setImageWithURL:dict[@"pic_url_240_200"]];
    cell.label.text = dict[@"songlist_name"];
    
    return cell;
}
//行头
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HCollectionReusableView *hcell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    hcell.headerLabel.text = _nameArray[indexPath.section];
    return hcell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(200, 20);
}
//
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld,%ld",indexPath.section,indexPath.row);
    SongListTableViewController *whee = [SongListTableViewController new];
    NSArray *array = _mutDict[_nameArray[indexPath.section]];
    NSDictionary *dict = array[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"http://api.dongting.com/channel/channel/%@/songs?size=50&page=1&app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music",dict[@"songlist_id"]];
    whee.url = str;
      [self.navigationController pushViewController:whee animated:YES];
}


@end
