//
//  VIViewController.h
//  VIViewController
//
//  Created by Jizu Song on 2017/6/23.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VIViewController : UIViewController

/**
 *  各个控制器的 class, 例如:[UITableViewController class]
 *  Each controller's class, example:[UITableViewController class]
 */
@property (nonatomic, copy) NSArray<Class> *viewControllerClasses;


/**
 *   聚合控制器是否使用用户自定义的 tableHeaderView 默认NO
 */
@property (nonatomic, assign) BOOL useCustomHeadView;

/**
 * 该方法用于重置刷新父控制器
 */
- (void)reloadData;


@end
