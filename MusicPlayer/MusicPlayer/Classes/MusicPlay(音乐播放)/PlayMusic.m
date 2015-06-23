//
//  PlayMusic.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/2.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "PlayMusic.h"

@implementation PlayMusic

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _url];
}

@end
