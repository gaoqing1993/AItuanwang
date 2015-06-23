//
//  MyMusicTableViewController.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/4.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MyMusicTableViewController.h"
#import "LikeTableViewController.h"
#import "skinViewController.h"
#import "DataBaseManager.h"
#import "LocalTableViewController.h"
@interface MyMusicTableViewController ()
{
    NSFileManager *manager;
}
@end

@implementation MyMusicTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyCell"];
    CGRect rect = [[UIScreen mainScreen]bounds];
    int x = rect.size.width/7 + 20;
    int y = 10;
    int Spacing = rect.size.width *0.12;
    
    NSArray *nameArray = @[@"清除缓存",@"我喜欢的",@"本地音乐",@"夜间模式",@"一键换肤",@"免责声明"];
    NSArray *imgArray = @[@"垃圾",@"我喜欢的",@"收藏",@"夜间",@"换肤",@"版本"];
    for (int i = 0; i < 6; i ++) {
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y + Spacing *i, rect.size.width/2, 30)];
        nameLabel.text = nameArray[i];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, y + Spacing *i, 30,30)];
        UIImage *img = [UIImage imageNamed:imgArray[i]];
        imgView.image = img;
        if (i == 3) {
            UISwitch *swi = [[UISwitch alloc]initWithFrame:CGRectMake(rect.size.width *0.78,y + Spacing *3 - 3, 40,25)];
            [swi setOn:NO animated:YES];
            [swi addTarget:self action:@selector(event:) forControlEvents:UIControlEventValueChanged];
            [self.view addSubview:swi];
        }
        [self.view addSubview:imgView];
        [self.view addSubview:nameLabel];
    }
}

- (void)event:(UISwitch *)swi{
    
    if ([swi isOn]) {
        self.view.window.alpha = 0.7;
    }else{
        self.view.window.alpha = 1;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    if (indexPath.row == 0||indexPath.row == 3) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     CGRect rect = [[UIScreen mainScreen]bounds];
    return rect.size.width *0.121;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     LocalTableViewController *localVC = [LocalTableViewController new];
     LikeTableViewController *likeTVC = [LikeTableViewController new];
    skinViewController *skinVC = [skinViewController new];
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"免责声明" message:@"本应用所有内容收集整理均来自互联网,访问者可将本网站内容用于学习欣赏,以及其他非商业用途,并同时遵循本网站合法权利。如有疑问，请发送邮箱至 1743940485@qq.com。\n\n版本V1.0" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
    switch (indexPath.row) {
        case 0:
            _alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [_alertView show];
                   break;
        case 1:
            [self.navigationController pushViewController:likeTVC animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:localVC animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:skinVC animated:YES];
            break;
        case 5:
            [alertView show];
            break;
        default:
            break;
    }
  }



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self clearCache];
    }
}

-(void)clearCache{
    manager = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
     NSArray *pathArray = [manager subpathsAtPath:cachePath];
    for (NSString *p in pathArray) {
        NSString *path = [cachePath stringByAppendingPathComponent:p];
        [manager removeItemAtPath:path error:nil];
    }
   }


@end
