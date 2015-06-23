//
//  MVViewController.h
//  MusicPlayer
//
//  Created by lanou3g on 15/6/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVViewController : UIViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic ,strong)UIScrollView *scrollView;
@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)UITableView *tabelView;
@property (nonatomic ,strong)UIButton *classButton;

@end
