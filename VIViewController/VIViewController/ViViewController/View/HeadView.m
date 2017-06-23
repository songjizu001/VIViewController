//
//  HeadView.m
//  BackGroundMessage
//
//  Created by Jizu Song on 2017/6/21.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import "HeadView.h"

@interface HeadView ()

@property(nonatomic,strong)UILabel * titleLabel;

@property(nonatomic,strong)UILabel * descLabel;

@property(nonatomic,strong)UILabel * bottom;

@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
                
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.descLabel];
        
        [self addSubview:self.bottom];

    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(40, 60, FNScreenWidth - 80, 40);
    
    self.descLabel.frame  = CGRectMake(10, 120, FNScreenWidth - 20, 80);

    self.bottom.frame     = CGRectMake(0, 210, FNScreenWidth , 40);
}

- (UILabel *)titleLabel{
  
    if (!_titleLabel) {
       
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, FNScreenWidth - 80, 40)];
        
        _titleLabel.text = @"风光";
        
        _titleLabel.font = [UIFont systemFontOfSize:38];
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}

- (UILabel *)descLabel{

    if (!_descLabel) {

        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, FNScreenWidth - 20, 80)];
        
        _descLabel.text = @"风光上架经典款垃圾卡拉圾卡拉卡即可了解快乐圾卡拉卡即可了解快乐卡即可了解快乐撒激烈的";
        
        _descLabel.font = [UIFont systemFontOfSize:15];
        
        _descLabel.textColor = [UIColor whiteColor];
        
        _descLabel.textAlignment = NSTextAlignmentCenter;
        
        _descLabel.numberOfLines = 2;
        
    }
    return _descLabel;
}

- (UILabel *)bottom{
    
    if (!_bottom) {
        
        _bottom = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, FNScreenWidth , 40)];
        
        _bottom.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.1];
    }
    return _bottom;
}

@end
