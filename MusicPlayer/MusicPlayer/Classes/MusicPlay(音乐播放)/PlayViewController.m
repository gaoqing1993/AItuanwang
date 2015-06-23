//
//  PlayViewController.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "PlayViewController.h"
#import "PlayMusic.h"
#import "AFSoundManager.h"
#import "RecDataHandle.h"
#import "CommonDefine.h"
#import "UIImageView+WebCache.h"
#import "RecDataHandle.h"
@interface PlayViewController ()
{
    NSString *_new;
    CGRect rect;
    RecDataHandle *_dataHandle;
    CADisplayLink *_link;//定时器(每秒刷新60次)
    NSInteger _number;
}
@end

@implementation PlayViewController
-(void)viewDidDisappear:(BOOL)animated{
    [_slider removeObserver:self forKeyPath:@"value"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    rect = [UIScreen mainScreen].bounds;
    _dataHandle = [RecDataHandle creatRecData];
     [self drawView];
    Song *song = _songArray[_song_num];
    if (_songArray != nil) {
        _singer.text = [NSString stringWithFormat:@"-- %@ --", song.singer_name];
        _miuscName.text = song.song_name;
    }else{
          _miuscName.text = _songNameArray[_song_num];
    }
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(movie:)];
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
}
-(void)movie:(UISwipeGestureRecognizer *)swip{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(rect.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
//播放本地音乐:
-(void)playLocalMusicWithfileName:(NSString *)name{
     _slider.value = 0;
    [_playButton setImage:[UIImage imageNamed:@"播放.png"] forState:UIControlStateNormal];
    _play = YES; //初始状态
    [[AFSoundManager sharedManager].player pause];
     _songArray = nil;
    NSMutableString *songName = [NSMutableString stringWithFormat:@"%@",_songNameArray[_song_num]];
    _miuscName.text = [songName substringToIndex:songName.length - 4];
    [self imageViewWithName:songName andBlock:^(NSURL *url) {
        [_imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Back.jpg"]];
        [_imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Back.jpg"]];
    }];
      [[AFSoundManager sharedManager]startPlayingLocalFileWithName:name andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        if (!error) {
            if (_localMusicArray != nil) {
                 [self show:percentage and:elapsedTime and:timeRemaining];
            }
                } else {
        }
    }];
}

-(void)show:(int )percentage and:(CGFloat) elapsedTime and: (CGFloat) timeRemaining{
    _formatter = [[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"mm:ss"];
    _elapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:elapsedTime];
    _elapsedTime.text = [_formatter stringFromDate:_elapsedTimeDate];
    _timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:timeRemaining];
    _timeRemaining.text = [_formatter stringFromDate:_timeRemainingDate];
    _slider.value = percentage * 0.01;
}

//播放流媒体音乐:
-(void)playMusicWithUrl:(NSString *)url{
     _slider.value = 0;
    [_playButton setImage:[UIImage imageNamed:@"播放.png"] forState:UIControlStateNormal];
    _play = YES; //初始状态
    [[AFSoundManager sharedManager].audioPlayer stop];
    _localMusicArray = nil;
    Song *song = _songArray[_song_num];
    _singer.text = [NSString stringWithFormat:@"-- %@ --", song.singer_name];
    _miuscName.text = song.song_name;
    [self imageViewWithName:song.singer_name andBlock:^(NSURL *url) {
        [_imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Back.jpg"]];
        [_imageV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Back.jpg"]];
    }];
    [[AFSoundManager sharedManager]startStreamingRemoteAudioFromURL:url andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        if (!error) {
            if (_songArray != nil) {
                [self show:percentage and:elapsedTime and:timeRemaining];
            }
        } else {
        }
    }];
}

//下一首:
-(void)nextMusic{
    if (_songArray == nil) {
        if (_song_num == _localMusicArray.count - 1) {
            _song_num = 0;
        }else{
            _song_num ++;
        }
    [self playLocalMusicWithfileName:_localMusicArray[_song_num]];
    }
    else{
    if (_song_num == _songArray.count - 1) {
        _song_num = 0;
       }else{
    _song_num ++;
    }
    Song *song = _songArray[_song_num];
    [self playMusicWithUrl:song.url];
    }
}
//上一首:
-(void)PrevMusic{
    if (_song_num == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"已经是第一首了" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:3 animated:YES];
    }else{
        _song_num --;
    }
    if (_songArray == nil) {
        [self playLocalMusicWithfileName:_localMusicArray[_song_num]];
      }else{
    Song *song = _songArray[_song_num];
    [self playMusicWithUrl:song.url];
    }
}
//暂停和播放:
-(void)startMusic{
    self.play = !self.play;
    if (_play == YES) {
        [_playButton setImage:[UIImage imageNamed:@"播放.png"] forState:UIControlStateNormal];
        if (_songArray == nil) {
            [[AFSoundManager sharedManager].audioPlayer play];
        }else{
            [[AFSoundManager sharedManager].player play];
        }
        }else{
        [_playButton setImage:[UIImage imageNamed:@"暂停.png"] forState:UIControlStateNormal];
            [_link invalidate];
            _link = nil;
            if (_songArray == nil) {
                [[AFSoundManager sharedManager].audioPlayer stop];
            }else{
                [[AFSoundManager sharedManager].player pause];
            }
          }
}
//
-(void)stopMuisc{
    [[AFSoundManager sharedManager].audioPlayer stop];
    [[AFSoundManager sharedManager].player pause];
}
//绘制界面:
-(void)drawView{
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.alpha = 1;
    effectview.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    [_imgView addSubview:effectview];
    _playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _playButton.frame = CGRectMake(rect.size.width/2 - rect.size.width/16, rect.size.height-rect.size.width/6, rect.size.width/8, rect.size.width/8);
    [_playButton setImage:[UIImage imageNamed:@"播放.png"] forState:UIControlStateNormal];
    _play = YES; //初始状态
    [_playButton addTarget:self action:@selector(startMusic) forControlEvents:UIControlEventTouchUpInside];
    _nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _nextButton.frame = CGRectMake(rect.size.width/2+rect.size.width/5-rect.size.width*0.06, rect.size.height-rect.size.width*5/48-rect.size.width*0.05, rect.size.width*0.12, rect.size.width*0.1);
    [_nextButton setImage:[UIImage imageNamed:@"nextMusic"] forState:UIControlStateNormal];
    _PrevButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _PrevButton.frame = CGRectMake(rect.size.width/2-rect.size.width/5-rect.size.width*0.06, rect.size.height-rect.size.width*5/48-rect.size.width*0.05,rect.size.width*0.12, rect.size.width*0.1);
    [_PrevButton setImage:[UIImage imageNamed:@"nextMusic"] forState:UIControlStateNormal];
    _PrevButton.transform = CGAffineTransformMakeRotation(M_PI);
    [_PrevButton addTarget:self action:@selector(PrevMusic) forControlEvents:UIControlEventTouchUpInside];
    [_nextButton addTarget:self action:@selector(nextMusic) forControlEvents:UIControlEventTouchUpInside];
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(20, rect.size.height - 110, rect.size.width-40, 30)];
    _slider.minimumValue = 0;
    _slider.maximumValue = 1.0;
    //设置滚轮图片:
    [_slider setThumbImage:[UIImage imageNamed:@"soundSlider.png"] forState:UIControlStateNormal];
    [_slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    _elapsedTime = [[UILabel alloc]initWithFrame:CGRectMake(10, rect.size.height - 85, 50, 20)];
    _elapsedTime.textColor = [UIColor whiteColor];
    _timeRemaining = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width - 55, rect.size.height - 85, 50, 20)];
    _timeRemaining.textColor = [UIColor whiteColor];
    _miuscName = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/2-100, 30, 200, 30)];
    _miuscName.textAlignment = NSTextAlignmentCenter;
    _miuscName.textColor = [UIColor whiteColor];
    _singer = [[UILabel alloc]initWithFrame:CGRectMake(rect.size.width/2-100, 60, 200, 30)];
    _singer.font = [UIFont systemFontOfSize:13];
    _singer.textAlignment = NSTextAlignmentCenter;
    _singer.textColor = [UIColor whiteColor];
    
    //给slide的value值添加观察者方法:
    [_slider addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    
    //添加通知方法,播放结束时自动调用 autoPlayNextMusic 方法:
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(autoPlayMusic) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(rect.size.width/2-rect.size.width/3, rect.size.height/2-rect.size.width/3, rect.size.width*2/3, rect.size.width*2/3)];
    _imageV.layer.cornerRadius =rect.size.width/3;
    _imageV.layer.masksToBounds = YES;
    _imageV.backgroundColor = [UIColor blackColor];
    _imageV.layer.borderWidth = 10;
    _imageV.layer.borderColor = [UIColor blackColor].CGColor;
    _pattenButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _pattenButton.frame = CGRectMake(20, rect.size.height-rect.size.width*5/48 -rect.size.width/20, rect.size.width/10, rect.size.width/10);
    [_pattenButton setImage:[UIImage imageNamed:@"顺序播放@2x"] forState:
     UIControlStateNormal];
    [_pattenButton addTarget:self action:@selector(pattenButton:) forControlEvents:UIControlEventTouchDown];
    _number = 0;
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
    back.frame = CGRectMake(20, 35, 12, 25);
    [back setBackgroundImage:[UIImage imageNamed:@"箭头1"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(movie:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_imgView];
    [self.view addSubview:_elapsedTime];
    [self.view addSubview:_timeRemaining];
    [self.view addSubview:_slider];
    [self.view addSubview:_playButton];
    [self.view addSubview:_nextButton];
    [self.view addSubview:_PrevButton];
    [self.view addSubview:_miuscName];
    [self.view addSubview:_singer];
    [self.view addSubview:_imageV];
    [self.view addSubview:_pattenButton];
    [self.view addSubview:back];
}

-(void)autoPlayMusic{
    [_link invalidate];
    _link = nil;
    switch (_number) {
        case 0:
            [self nextMusic];
            break;
        case 1:
            [self randomMusic];
            break;
        case -1:
            [self fixedMusic];
            break;
        default:
            break;
    }
}

//单曲循环
-(void)fixedMusic{
    Song *song = _songArray[_song_num];
    [self playMusicWithUrl:song.url];
}
//随机播放
-(void)randomMusic{
    NSInteger num =_songArray.count;
    _song_num = arc4random()%num;
    Song *song = _songArray[_song_num];
    [self playMusicWithUrl:song.url];
}
//播放模式
-(void)pattenButton:(UIButton *)button{
    _number++;
    switch (_number) {
        case 0:
            [_pattenButton setImage:[UIImage imageNamed:@"顺序播放@2x"] forState:
             UIControlStateNormal];
            break;
        case 1:
            [_pattenButton setImage:[UIImage imageNamed:@"随机播放@2x"] forState:
             UIControlStateNormal];
            break;
        case 2:
            [_pattenButton setImage:[UIImage imageNamed:@"单曲循环@2x"] forState:
             UIControlStateNormal];
            _number = -1;
            break;
        default:
            break;
    }
}
//滑动slide控制播放进度:
-(void)valueChanged:(UISlider *)slide{
     [[AFSoundManager sharedManager]moveToSection:slide.value];
}
//给slide的value值添加观察者方法:
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object == _slider&&[keyPath isEqualToString:@"value"]) {
        NSString *new = [NSString stringWithFormat:@"%@",[change objectForKey:@"new"]];
        if ( ![new isEqualToString: _new]) {
            if (_link == nil) {
                _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(transform)];
                [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            }
            _new = new;
        }
        
    }
}
-(void)transform{
    _imageV.transform = CGAffineTransformRotate(_imageV.transform, M_PI/500);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)imageViewWithName:(NSString *)name andBlock:(void(^)(NSURL *url))block{
    NSString *str = [NSString stringWithFormat:@"http://so.ard.iyyin.com/s/artist?q=%@&page=1&size=15&app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music",name];
    NSString *urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    RecDataHandle *redata = [RecDataHandle creatRecData];
    [redata DataHandleWithUrl:urlStr andBlock:^(NSData *data){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array =dict[@"data"];
        if(array.count > 0){
            NSURL *url = [NSURL URLWithString:array[0][@"pic_url"]];
            block(url);
        }else{
            _imgView.image = [UIImage imageNamed:@"Back.jpg"];
        }
    } failure:^(NSError *error){
        _imgView.image = [UIImage imageNamed:@"Back.jpg"];
    }];
}

static PlayViewController *playCV = nil;

+(id)newPlay{
    if (playCV == nil) {
        playCV = [PlayViewController new];
    }
    return playCV;
}
@end
