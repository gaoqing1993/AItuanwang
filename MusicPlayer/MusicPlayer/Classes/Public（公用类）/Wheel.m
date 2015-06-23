//
//  Wheel.m
//  MusicPlayer
//
//  Created by 张毅 on 15/6/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Wheel.h"

@implementation Wheel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _songlistname];
}
@end
