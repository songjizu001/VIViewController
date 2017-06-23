//
//  DemoController.m
//  VIViewController
//
//  Created by Jizu Song on 2017/6/23.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import "DemoController.h"
#import "ContentController.h"

@interface DemoController ()

@end

@implementation DemoController

- (void)viewDidLoad {
   
    [super viewDidLoad];

    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.viewControllerClasses = @[[ContentController class],[ContentController class],[ContentController class],[ContentController class]];
        [strongSelf reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
