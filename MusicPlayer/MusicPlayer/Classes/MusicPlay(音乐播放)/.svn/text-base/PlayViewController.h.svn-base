//
//  PlayViewController.h
//  MusicPlayer
//
//  Created by 张毅 on 15/6/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"
@interface PlayViewController : UIViewController
@property (nonatomic, strong)UIButton *playButton;
@property(nonatomic,strong)UIImageView *imgView;
@property (nonatomic, strong)UIButton *nextButton;
@property (nonatomic, strong)UIButton *PrevButton;
@property (nonatomic, strong)UILabel *elapsedTime;
@property (nonatomic, strong)UILabel *timeRemaining;
@property (nonatomic, strong)UISlider *slider;
@property (nonatomic, assign)NSInteger songID;
@property (nonatomic, assign)BOOL play;
@property (nonatomic, strong)NSMutableArray *songArray;
@property(nonatomic,strong)NSMutableArray *localMusicArray;
@property (nonatomic, strong)NSMutableDictionary *songDict;
@property (nonatomic, assign)NSInteger song_num;
@property (nonatomic, strong)NSDateFormatter *formatter;
@property (nonatomic, strong)NSDate *elapsedTimeDate;
@property (nonatomic, strong)NSDate *timeRemainingDate;
@property (nonatomic, assign)int percentage;
@property (nonatomic, strong)UIButton *pattenButton;
@property(nonatomic,strong)NSArray *songNameArray;

@property (nonatomic ,strong)UILabel *miuscName;
@property (nonatomic ,strong)UILabel *singer;
@property (nonatomic ,strong)UIView *muiscView;
@property (nonatomic ,strong)UIImageView *imageV;

-(void)playMusicWithUrl:(NSString *)url;

-(void)playLocalMusicWithfileName:(NSString *)name;

-(void)stopMuisc;

+(id)newPlay;

@end
