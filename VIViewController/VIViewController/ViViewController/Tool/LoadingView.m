//
//  LoadingView.m
//  VIViewController
//
//  Created by Jizu Song on 2017/7/4.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (nonatomic, strong) LOTAnimationView *laAnimation;

@property(nonatomic,strong)UILabel   *label;

@property(nonatomic,strong)UIButton  *backButton;

@end


@implementation LoadingView

-(void)dealloc{

    NSLog(@"%@--->销毁了",self.class);
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.alpha = 0.0f;

        self.hidden = YES;
        
        self.backgroundColor =[UIColor whiteColor];
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.laAnimation.frame = CGRectMake(0, 0, self.width, self.height);
    
    self.label.frame = CGRectMake(15, 0, FNScreenWidth - 30, 50);
    
    self.label.centerY = self.centerY -100;

    self.backButton.frame = CGRectMake(15, 20, 50, 50);

}

- (void)_loadAnimationNamed:(NSString *)named {
   
    self.hidden = NO;
    [UIView animateWithDuration:0.02 animations:^{
        self.alpha = 1.0f;
    }];

    [self.laAnimation removeFromSuperview];
    [self.label removeFromSuperview];
    [self.backButton removeFromSuperview];

    self.laAnimation = nil;
    
    self.laAnimation = [LOTAnimationView animationNamed:named];
    self.laAnimation.animationSpeed = 1.5;
    self.laAnimation.contentMode = UIViewContentModeScaleAspectFit;
    self.laAnimation.loopAnimation = YES;
    [self addSubview:self.laAnimation];
    [self addSubview:self.label];
    [self addSubview:self.backButton];

    [self setNeedsLayout];
    
    [self.laAnimation play];
}

- (void)stop{

    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0f;
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    [self.laAnimation pause];
    [self.laAnimation removeFromSuperview];
    [self.label removeFromSuperview];
    [self.backButton removeFromSuperview];
    self.laAnimation = nil;
}

- (void)backButtonAction:(UIButton *)sender{

    if (self.block) {
        self.block();
    }
}

- (UILabel *)label{
    
    if (!_label) {
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FNScreenWidth - 30, 50)];
        
        NSString * string =   @"正在努力请求数据...";
        
        _label.text = string;
        
        _label.font = [UIFont systemFontOfSize:18];
        
        _label.textColor = [UIColor grayColor];
        
        _label.textAlignment = NSTextAlignmentCenter;
        
    }
    return _label;
}


-(UIButton *)backButton{

    if (!_backButton) {
       
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 50, 50)];
        
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(-3, -16, 0, 0);
        
    }
    return _backButton;
}

@end
