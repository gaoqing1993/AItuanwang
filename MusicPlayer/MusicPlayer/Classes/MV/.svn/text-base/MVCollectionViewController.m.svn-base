//
//  MVCollectionViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MVCollectionViewController.h"
#import "ClassCollectionViewCell.h"
#import "HCollectionReusableView.h"
#import "RecDataHandle.h"
#import "MBProgressHUD.h"
@interface MVCollectionViewController ()
{
    MBProgressHUD *HUD;
    NSArray *_array;
    UIColor *_blueColor;
}
@end

@implementation MVCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _blueColor = [UIColor colorWithRed:70/255.0 green:110/255.0 blue:250/255.0 alpha:0.5];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[ClassCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[HCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //数据处理
    NSString *url = @"http://api.dongting.com/song/video/type?app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music";
    HUD = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    RecDataHandle *datahan = [RecDataHandle creatRecData];
    [datahan DataHandleWithUrl:url andBlock:^(NSData *data){
        [HUD hide:YES];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        _array = [NSArray arrayWithArray:dict[@"data"]];
        [self.collectionView reloadData];
    } failure:^(NSError *error){
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
    return _array.count+1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
    NSDictionary *dict = _array[section-1];
    NSArray *array = dict[@"subType"];
    return array.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.nameLabel.text = @"全部";
    }else{
    NSDictionary *dict1 = _array[indexPath.section-1];
    NSArray *array = dict1[@"subType"];
    NSDictionary *dict2 = array[indexPath.row];
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    cell.layer.borderWidth = 0.4;
    cell.layer.borderColor = [UIColor yellowColor].CGColor;
    cell.nameLabel.text = dict2[@"name"];
    }
    cell.backgroundColor = _blueColor;
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
     CGRect rect = [UIScreen mainScreen].bounds;
    CGFloat W = (rect.size.width- 5*6 )/5;
    if (indexPath.section == 0) {
        return CGSizeMake(rect.size.width - 10, W*3/4);
    }
    return CGSizeMake(W, W*3/4);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HCollectionReusableView *reusView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    if (indexPath.section >0) {
        NSDictionary *dict = _array[indexPath.section-1];
        reusView.headerLabel.text = dict[@"name"];
        //reusView.backgroundColor = [UIColor redColor];
    }
    return reusView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(240, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section >0) {
        NSDictionary *dict1 = _array[indexPath.section-1];
        NSArray *array = dict1[@"subType"];
        NSDictionary *dict2 = array[indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"nameID" object:nil userInfo:dict2];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"nameID" object:nil userInfo:@{@"id":@"0",@"name":@"全部"}];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
