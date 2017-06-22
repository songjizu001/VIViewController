//
//  ViewController.m
//  VIViewController
//
//  Created by Jizu Song on 2017/6/22.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)UILabel   *label;

@property(nonatomic,strong)UIButton  *preButton;

@property(nonatomic,strong)UIButton  *demoButton;

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"聚合";

    [self.view addSubview:self.label];
    
    [self.view addSubview:self.preButton];

    [self.view addSubview:self.demoButton];

}


- (void)preButtonAction:(UIButton *)sender{
    
    
}


- (void)demoButtonAction:(UIButton *)sender{
    
    
}


- (UILabel *)label{
    
    if (!_label) {
    
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, FNScreenWidth - 30, 270)];
     
        NSString * string =   @" · 此Demo 演示的类型 \n\n · 微博个人主页  \n\n · in 的发现页面   \n\n · 图虫的分类聚合页面  \n\n · 半塘的首页 ";

        _label.text = string;
        
        _label.font = [UIFont systemFontOfSize:15];
        
        _label.textColor = [UIColor grayColor];
        
        _label.textAlignment = NSTextAlignmentLeft;
        
        _label.numberOfLines = 0;
    
    }
    return _label;
}

- (UIButton *)preButton{
   
    if (!_preButton) {
       
        _preButton = [[UIButton alloc] initWithFrame:CGRectMake(FNScreenWidth - 150, 30, 130, 210)];
        
        [_preButton setTitle:@"查看效果图" forState:UIControlStateNormal];
        
        [_preButton setTitleColor:[[UIColor cyanColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
        
        [_preButton setBackgroundColor:[[UIColor orangeColor] colorWithAlphaComponent:0.5]];
        
        [_preButton addTarget:self action:@selector(preButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _preButton;
}

-(UIButton *)demoButton{
    
    if (!_demoButton) {
        
        _demoButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 300, FNScreenWidth - 30, 45)];
        
        [_demoButton setTitle:@"进入Demo" forState:UIControlStateNormal];
        
        [_demoButton setTitleColor:[[UIColor cyanColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
       
        [_demoButton setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.5]];

        [_demoButton addTarget:self action:@selector(demoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _demoButton;
}

@end
