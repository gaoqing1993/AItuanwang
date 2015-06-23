//
//  Rank.m
//  TTYT
//
//  Created by 焦鹏 on 15/5/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "Rank.h"

@implementation Rank

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        
        [self setValue:value forKey:@"name_id"];
    }
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"%@------%ld",_title,_name_id];
}


@end
