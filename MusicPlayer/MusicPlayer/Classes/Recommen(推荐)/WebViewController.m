//
//  WebViewController.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    CGRect rect;
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _name;
    rect = [UIScreen mainScreen].bounds;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:rect];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_str_url]];
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
