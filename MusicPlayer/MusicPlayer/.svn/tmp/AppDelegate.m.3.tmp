//
//  AppDelegate.m
//  MusicPlayer
//
//  Created by 张毅 on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AppDelegate.h"
#import "RecTableViewController.h"
#import "RankTableViewController.h"
#import "MLTableViewController.h"
#import "MyMusicTableViewController.h"
#import "MVViewController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    RecTableViewController *RecVC = [[RecTableViewController  alloc]init];
    RecVC.title = @"推荐";
    RecVC.tabBarItem.image = [UIImage imageNamed:@"aa"];
    
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:RecVC];
    
    
    RankTableViewController *RankVC = [[RankTableViewController  alloc]init];
    RankVC.title = @"排行榜";
    RankVC.tabBarItem.image = [UIImage imageNamed:@"cc"];
    
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:RankVC];
    
    
    MLTableViewController *musVC = [[MLTableViewController  alloc]init];
    musVC.title = @"乐库";
    musVC.tabBarItem.image = [UIImage imageNamed:@"bb"];
    
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:musVC];
    
    
    MyMusicTableViewController *myVC = [[MyMusicTableViewController  alloc]init];
    myVC.title = @"我的";
    myVC.tabBarItem.image = [UIImage imageNamed:@"我的"];
    
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:myVC];
    

    MVViewController *mvVC = [MVViewController new];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:mvVC];
    nav5.tabBarItem.image = [UIImage imageNamed:@"mv.ico"];
    nav5.tabBarItem.title = @"MV";
    nav5.navigationBar.translucent = NO;
    
    
    NSArray *array = @[nav1,nav3,nav2,nav5,nav4];

    UITabBarController *tabBar = [[UITabBarController alloc]init];
    
    tabBar.delegate = self;
    tabBar.viewControllers = array;
    tabBar.selectedIndex = 0;
    tabBar.tabBar.tintColor = [UIColor colorWithRed:45/255.0 green:165/255.0 blue:235/255.0 alpha:1];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [tabBar.view addGestureRecognizer:swipe];
    swipe.delaysTouchesBegan = YES;
  
    self.window.rootViewController = tabBar;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)swipeAction{
    CGRect rect = [UIScreen mainScreen].bounds;
    if ([PlayViewController newPlay] == nil) {
        return;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [PlayViewController newPlay].view.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        }];
    }
}



-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
