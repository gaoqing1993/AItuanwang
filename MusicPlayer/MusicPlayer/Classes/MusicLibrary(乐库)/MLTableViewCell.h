//
//  MLTableViewCell.h
//  TTYT
//
//  Created by lanou3g on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cellBlockStr)(NSString *tag);

@interface MLTableViewCell : UITableViewCell

@property(nonatomic ,strong)UIButton *button;
@property(nonatomic ,strong)UILabel *MLlabel;
@property(nonatomic,copy)cellBlockStr cellBlockStr;

@end
