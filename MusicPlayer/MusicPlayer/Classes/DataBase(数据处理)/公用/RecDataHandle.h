//
//  RecDataHandle.h
//  MusicPlayer
//
//  Created by 张毅 on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BLOCK)(NSData *data);

@interface RecDataHandle : NSObject


+(RecDataHandle *)creatRecData;

-(void)DataHandleWithUrl:(NSString *)url andBlock:(BLOCK)block  failure:(void (^)( NSError *error))failure;

@end
