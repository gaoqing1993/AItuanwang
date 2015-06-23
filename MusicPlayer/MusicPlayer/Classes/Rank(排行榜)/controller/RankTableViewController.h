//
//  RankTableViewController.h
//  TTYT
//
//  Created by 焦鹏 on 15/5/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankTableViewCell.h"
#import "RecDataHandle.h"
#import "CommonDefine.h"
#import "Rank.h"
#import "Song.h"
#import "SongListTableViewController.h"

@interface RankTableViewController : UITableViewController

@property (nonatomic, strong) Rank *rank;
@property (nonatomic, strong) NSMutableArray *rankArray;
@property (nonatomic, strong) NSString *name;//获取专辑名

@end
