//
//  StationTableViewController.h
//  MusicPlayer
//
//  Created by lanou3g on 15/6/10.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayViewController.h"
@interface StationTableViewController : UITableViewController

@property (nonatomic ,strong)NSString *url;
@property (nonatomic ,strong)NSMutableArray *songArray;
@end
