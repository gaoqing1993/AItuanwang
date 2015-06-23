//
//  SongListTableViewController.h
//  MusicPlayer
//
//  Created by 张毅 on 15/6/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongTableViewCell.h"
#import "CommonDefine.h"
#import "RecDataHandle.h"
#import "PlayViewController.h"

@interface SongListTableViewController : UITableViewController

@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSMutableArray *songArray;
@property(nonatomic,strong)NSMutableArray *songAuditionList;



@end
