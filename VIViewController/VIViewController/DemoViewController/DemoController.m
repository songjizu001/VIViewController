//
//  DemoController.m
//  VIViewController
//
//  Created by Jizu Song on 2017/6/23.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import "DemoController.h"
#import "CustomViewController.h"

@interface DemoController ()

@end

@implementation DemoController

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
  
    __weak typeof(self)weakSelf = self;
    
    
    //模拟数据请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        __strong typeof(weakSelf)strongSelf = weakSelf;
       
        strongSelf.viewControllerClasses = @[[CustomViewController class],
                                             [CustomViewController class],
                                             [CustomViewController class]];
        
        strongSelf.titles = @[@"精选",@"最新",@"简介"];
        strongSelf.menuItemCorlorNor = UIColorFromHex(0x333333);
        strongSelf.menuItemCorlorSel = UIColorFromHex(0x888888);
        strongSelf.menuTitleSize = 15;
        [strongSelf reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
