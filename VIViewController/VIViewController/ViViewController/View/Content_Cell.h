//
//  Content_Cell.h
//  BackGroundMessage
//
//  Created by Jizu Song on 2017/6/21.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Content_CellDelegate <NSObject>

@optional
/**
 *  内部的Collection正在滚动
 */
- (void)content_CellCollectionViewDidScroll;
/**
 *  内部的Collection滚动结束
 */
- (void)content_CellCollectionViewDidEndDecelerating;

@end

@interface Content_Cell : UITableViewCell

@property (nonatomic, weak) id<Content_CellDelegate>delegate;

/**
 *  Content_Cell 的父视图
 */
@property (nonatomic, weak) UIViewController *parentVC;

/**
 *  各个控制器的 class, 例如:[UITableViewController class]
 */
@property (nonatomic, copy) NSArray<Class> *viewControllerClasses;

/**
 *  Cell 是否可以滚动
 */
@property (nonatomic, assign) BOOL cellCanScroll;

/**
 *  设置当前控制器
 */
@property (nonatomic, assign) NSInteger contentViewCurrentIndex;


@end
