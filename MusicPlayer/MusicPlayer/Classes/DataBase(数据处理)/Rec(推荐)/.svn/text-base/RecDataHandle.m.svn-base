//
//  RecDataHandle.m
//  MusicPlayer
//
//  Created by 张毅 on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RecDataHandle.h"
#import "CommonDefine.h"
static RecDataHandle *recData = nil;
@implementation RecDataHandle
+(RecDataHandle *)creatRecData{
    if (recData == nil) {
        recData = [[RecDataHandle alloc]init];
    }
    return recData;
}
-(void)RecDataHandle{
    
    NSString *Rec_url = [NSString stringWithFormat:@"%@?%@&version=0",RECOM_URL,COM_URL];
    //1.创建URL
    NSURL *url = [NSURL URLWithString:Rec_url];
    //2.创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    //3.获取数据(异步联接)
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *Dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *Dic = Dict[@"data"];
        NSArray *Array = Dic[@"songlists"];
        _RecArray = [NSMutableArray arrayWithCapacity:30];
        for (NSDictionary *dic in Array) {
            RecSection *recSec = [RecSection new];
            [recSec setValue:dic[@"_id"] forKey:@"_id"];
            [recSec setValue:dic[@"action"] forKey:@"action"];
            [recSec setValue:dic[@"data"] forKey:@"data"];
            [recSec setValue:dic[@"desc"] forKey:@"desc"];
            [recSec setValue:dic[@"name"] forKey:@"name"];
            [recSec setValue:dic[@"order"] forKey:@"order"];
            [recSec setValue:dic[@"style"] forKey:@"style"];
            [_RecArray addObject:recSec];
        }
        [_RecArray removeObjectAtIndex:6];
        [self.delegate reloadData];
    }];
}

    
    
    
    




@end
