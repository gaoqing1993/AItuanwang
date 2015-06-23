//
//  RecRow.m
//  MusicPlayer
//
//  Created by 张毅 on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "RecRow.h"

@implementation RecRow
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"num_id"];
    }
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _name];
}
@end
