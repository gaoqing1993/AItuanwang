//
//  RankTableViewCell.h
//  TTYT
//
//  Created by 焦鹏 on 15/5/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rank.h"

@interface RankTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *rankPicture;//专辑图片
@property (nonatomic, strong) UILabel *ranktitle;//标题
@property (nonatomic, strong) UILabel *rankName_id;//id
@property (nonatomic, strong) UILabel *rankFirst;
@property (nonatomic, strong) UILabel *rankSecond;
@property (nonatomic, strong) UILabel *rankThird;
@property (nonatomic, strong) UILabel *rankDividing;

@property (nonatomic, strong) UIView *rankView;

@property (nonatomic, strong) Rank *rank;




@end
