//
//  MyMusicTableViewController.h
//  MusicPlayer
//
//  Created by 张毅 on 15/6/4.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MyMusicTableViewController : UITableViewController<UIAlertViewDelegate>
@property (nonatomic, strong) NSString *strSong;
@property (nonatomic, strong) NSString *strSinger;
@property(nonatomic,strong)UIAlertView *alertView;
@end
