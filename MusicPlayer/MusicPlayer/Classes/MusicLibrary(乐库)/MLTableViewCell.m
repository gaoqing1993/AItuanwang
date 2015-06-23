//
//  MLTableViewCell.m
//  TTYT
//
//  Created by lanou3g on 15/5/31.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MLTableViewCell.h"

@implementation MLTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self drawView];
    }
    return self;
}

-(void)drawView{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    int tota = 2;
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    
    CGFloat appW = (rect.size.width - 3*marginX)/2;
    CGFloat appH = appW*3/4;

    for (int i = 0 ; i < 6; i++) {
        int row = i/tota;
        int col = i%tota;
        
        CGFloat appX = marginX +col*(appW +marginX);
        CGFloat appY = marginY +row *(appH +marginY +appH*0.2);
        
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(appX, appY, appW, appH);
        _button.tag = i+1;
        NSString *str = [NSString stringWithFormat:@"muisc-%d.jpg",i+1];
        [_button setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        _button.layer.cornerRadius = 5;
        _button.layer.masksToBounds = YES;
        [_button addTarget:self action:@selector(xiangqing:) forControlEvents:UIControlEventTouchDown];
        
        UIImageView *imagV = [[UIImageView alloc] initWithFrame:CGRectMake(15, appH-65, 35, 35)];
        if (i == 2) {
            imagV.frame =CGRectMake(8, appH-70, 45, 45);
        }
        if (i == 3) {
            imagV.frame =CGRectMake(15, appH-70, 45, 45);
        }
        imagV.image = [UIImage imageNamed:[NSString stringWithFormat:@"mku-%d.png",i+1]];
        [_button addSubview:imagV];
        
        
        _MLlabel = [[UILabel alloc] initWithFrame:CGRectMake(appX, appY+appH, appW, appH*0.2)];
        NSArray *array = @[@"新歌首发",@"歌手",@"电台",@"大家在听",@"分类",@"FM音"];
        _MLlabel.text = array[i];
        _MLlabel.font = [UIFont systemFontOfSize:appH*0.12];
        [self.contentView addSubview:_MLlabel];
        [self.contentView addSubview:_button];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, appH-40, 80, 40)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text = array[i];
        [_button addSubview:label];
        
    }
}
-(void)xiangqing:(UIButton *)button{
    NSString *tag = [NSString stringWithFormat:@"%ld",button.tag];
    //_cellBlockStr(tag);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"title" object:[NSString stringWithFormat:@"%ld",button.tag]];
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
