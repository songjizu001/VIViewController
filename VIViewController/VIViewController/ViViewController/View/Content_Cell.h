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
 *  内部的Collection即将要滚动
 */
- (void)content_CellCollectionViewWillBeginDragging:(UIScrollView *)scrollView;
/**
 *  内部的Collection正在滚动
 */
- (void)content_CellCollectionViewDidScroll:(UIScrollView *)scrollView;
/**
 *  内部的Collection滚动结束
 */
- (void)content_CellCollectionViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@interface Content_Cell : UITableViewCell

@property (nonatomic, weak) id<Content_CellDelegate>delegate;

/**
 *  Content_Cell 的父视图
 */
@property (nonatomic, weak) UIViewController *parentVC;

/**
 *  各个控制器的 子视图数组
 */
@property (nonatomic, strong) NSArray *childsVCs;

/**
 *  Cell 是否可以滚动
 */
@property (nonatomic, assign) BOOL cellCanScroll;

/**
 *  设置当前控制器
 */
@property (nonatomic, assign) NSInteger contentViewCurrentIndex;

/**
 *  设置cell中的页面滚动范围
 */
- (void)cellContentCollectOffset:(CGPoint)contentOffset animated:(BOOL)animated;

@end
