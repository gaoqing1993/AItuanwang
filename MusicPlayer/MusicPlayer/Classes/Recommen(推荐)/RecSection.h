//
//  RecSection.h
//  MusicPlayer
//
//  Created by 张毅 on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecSection : NSObject

@property(nonatomic,assign)int _id;
@property(nonatomic,strong)NSDictionary *action;
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)NSString *desc;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *order;
@property(nonatomic,assign)int style;


@end
