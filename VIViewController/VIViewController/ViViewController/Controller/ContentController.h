//
//  ContentController.h
//  BackGroundMessage
//
//  Created by Jizu Song on 2017/6/21.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ContentController : UIViewController
@property (nonatomic, assign) BOOL tableCanScroll;
@property (nonatomic, strong) UITableView *tableView;

- (instancetype)initWithTitle:(NSString *)title;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end
