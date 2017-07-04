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
 *  各个控制器的 所对应的标题
 */
@property (nonatomic,copy) NSArray<NSString *> *titles;

/**
 *  各个控制器的 class, 例如:[UITableViewController class]
 */
@property (nonatomic,copy) NSArray<Class> *viewControllerClasses;
/**
 *  当前容器控制器显示的控制器
 */
@property (nonatomic, strong, readonly) UIViewController *currentViewController;

/**
 *  聚合控制器是否使用用户自定义的 tableHeaderView 默认NO
 */
@property (nonatomic,assign) BOOL      useCustomHeadView;

/**
 *  点击相邻的 MenuItem 是否触发翻页动画 (当当前选中与点击Item相差大于1是不触发)
 */
@property (nonatomic, assign) BOOL pageAnimatable;

/**
 *  用代码设置 contentView 的 contentOffset 之前，请设置 startDragging = YES
 */
@property (nonatomic, assign) BOOL startDragging;
/**
 *  menu 字体未高亮颜色
 */
@property(nonatomic,strong)UIColor     * menuItemCorlorNor;
/**
 *  menu 字体高亮颜色
 */
@property(nonatomic,strong)UIColor     * menuItemCorlorSel;
/**
 *  menu 字体大小
 */
@property(nonatomic,assign)CGFloat       menuTitleSize;
/**
 * 该方法用于重置刷新父控制器  同时刷新headView中的MemuIterm 
 */
- (void)reloadData;

@end
