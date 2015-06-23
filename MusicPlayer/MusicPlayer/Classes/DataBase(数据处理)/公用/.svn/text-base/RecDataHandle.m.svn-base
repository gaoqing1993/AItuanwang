//
//  RecDataHandle.m
//  MusicPlayer
//
//  Created by 张毅 on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RecDataHandle.h"

static RecDataHandle *recData = nil;

@implementation RecDataHandle


+(RecDataHandle *)creatRecData{
    
    if (recData == nil) {
        
        recData = [[RecDataHandle alloc]init];
    }
    return recData;
}


-(void)DataHandleWithUrl:(NSString *)url andBlock:(BLOCK)block  failure:(void (^)( NSError *error))failure{
    //1.创建URL
    NSURL *URL = [NSURL URLWithString:url];
    //2.创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:URL];
    //3.获取数据(异步联接)
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            failure(connectionError);
        }else{
        block(data);
        }
    }];
}

    






@end
