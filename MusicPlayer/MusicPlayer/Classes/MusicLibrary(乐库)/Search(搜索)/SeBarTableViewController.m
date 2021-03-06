//
//  SeBarTableViewController.m
//  MusicPlayer
//
//  Created by lanou3g on 15/6/3.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SeBarTableViewController.h"
#import "SearchTableViewController.h"
#import "RecDataHandle.h"
#import "SongTableViewCell.h"
#import "MBProgressHUD.h"
static NSString *seaCellID = @"search";
@interface SeBarTableViewController ()
{ 
    NSMutableArray *_array;
    NSString *_mutstr;
     MBProgressHUD *HUD;
}
@end

@implementation SeBarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:seaCellID];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CGRect rect = [UIScreen mainScreen].bounds;
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, 30)];
        searchBar.layer.backgroundColor = [UIColor yellowColor].CGColor;
        searchBar.barStyle = UISearchBarStyleDefault;
        searchBar.keyboardType = UIKeyboardTypeEmailAddress;
        searchBar.showsCancelButton = NO;
        searchBar.placeholder = @"歌曲/歌手/专辑/歌词/歌单";
        searchBar.delegate = self;
        return searchBar;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    }
    return 0;
}
//方法
//触摸是触发
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
//取消键方法
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}
//点击搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    SearchTableViewController *searchTVC = [SearchTableViewController new];
    searchTVC.searchText = searchBar.text;
    [self.navigationController pushViewController:searchTVC animated:YES];
}
//实时
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSString *str1 = [NSString stringWithFormat:@"http://so.ard.iyyin.com/sug/sugAll?q=%@&app=ttpod&v=v7.9.1.2015050518&uid=&mid=iPhone5S&f=f320&s=s310&imsi=&hid=&splus=8.3&active=1&net=2&openudid=b5e548f14129efccc54a17cc1e4c775eb58f89d3&idfa=7A35A1BE-4E11-4410-95E4-F76AA59A189D&utdid=VWc0qWqDW5YDAK0f0N2eV0iP&alf=201200&bundle_id=com.ttpod.music",searchText];
    NSString *str3 = [str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    RecDataHandle *recdataha = [RecDataHandle creatRecData];
    _array = [NSMutableArray arrayWithCapacity:10];
    [recdataha DataHandleWithUrl:str3 andBlock:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dict1 = dict[@"data"];
        _array = dict1[@"keyword"];
        NSIndexPath *inde = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.tableView reloadSections: [NSIndexSet indexSetWithIndex: inde.section] withRowAnimation: UITableViewRowAnimationFade];
    } failure:^(NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络连接错误，请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:2 animated:YES];
    }];
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return _array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:seaCellID forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"    %ld. %@",indexPath.row + 1,_array[indexPath.row][@"val"]];
    //隐藏点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld,%ld",(long)indexPath.section,(long)indexPath.row);
    SearchTableViewController *searchTVC = [SearchTableViewController new];
    searchTVC.searchText = _array[indexPath.row][@"val"];
    [self.navigationController pushViewController:searchTVC animated:YES];
}

@end
