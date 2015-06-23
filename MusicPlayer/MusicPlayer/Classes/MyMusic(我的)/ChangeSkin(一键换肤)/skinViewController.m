//
//  skinViewController.m
//  MusicPlayer
//
//  Created by 焦鹏 on 15/6/9.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "skinViewController.h"
#import "AppDelegate.h"

@interface skinViewController ()

{
    NSArray *_arrayColor;
}

@end


@implementation skinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    int Spacing = rect.size.width *1/4;
    
    NSArray *arrayName = @[@"默认",@"赤",@"橙",@"黄",@"绿",@"青",@"蓝",@"紫"];
    _arrayColor = @[[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1],[UIColor colorWithRed:235/255.0 green:120/255.0 blue:120/255.0 alpha:1],[UIColor colorWithRed:250/255.0 green:200/255.0 blue:90/255.0 alpha:1],[UIColor colorWithRed:250/255.0 green:240/255.0 blue:110/255.0 alpha:1],[UIColor colorWithRed:190/255.0 green:225/255.0 blue:125/255.0 alpha:1],[UIColor colorWithRed:140/255.0 green:230/255.0 blue:230/255.0 alpha:1],[UIColor colorWithRed:180/255.0 green:210/255.0 blue:245/255.0 alpha:1],[UIColor colorWithRed:200/255.0 green:170/255.0 blue:210/255.0 alpha:1]];
    
    for (int i = 0; i < 8; i ++) {
        
        int x = i % 3;
        int y = i / 3;
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(15 + rect.size.width *1/3 * x, Spacing + rect.size.width *1/3 *y, Spacing, Spacing);
        //从数组中添加颜色
        [_button setBackgroundColor:_arrayColor[i]];
        //从数组中添加标题（附带点击效果）
        [_button setTitle:arrayName[i] forState:UIControlStateHighlighted];
        _button.showsTouchWhenHighlighted = YES;
        //改变字体颜色
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.tag = 100 + i;
        _button.layer.cornerRadius = 10;
        _button.layer.masksToBounds = YES;
        [_button addTarget:self action:@selector(event:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
    }
}

- (void)event:(UIButton *)button{
    
    [[UINavigationBar appearance]setBarTintColor:_arrayColor[button.tag - 100]];
    self.tabBarController.tabBar.barTintColor = _arrayColor[button.tag - 100];
    self.navigationController.navigationBar.barTintColor = _arrayColor[button.tag - 100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
