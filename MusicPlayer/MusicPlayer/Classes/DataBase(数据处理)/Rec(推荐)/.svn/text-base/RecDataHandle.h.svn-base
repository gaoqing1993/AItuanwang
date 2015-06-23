//
//  RecDataHandle.h
//  MusicPlayer
//
//  Created by 张毅 on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecSection.h"
@protocol RecDataDelegate<NSObject>
-(void)reloadData;

@end
@interface RecDataHandle : NSObject
@property(nonatomic,strong)NSMutableArray *RecArray;
@property(nonatomic,weak)id<RecDataDelegate> delegate;
+(RecDataHandle *)creatRecData;
-(void)RecDataHandle;
@end
