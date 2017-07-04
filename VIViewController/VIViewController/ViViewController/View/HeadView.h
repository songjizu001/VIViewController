//
//  HeadView.h
//  BackGroundMessage
//
//  Created by Jizu Song on 2017/6/21.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WMMenuView;

@protocol HeadViewDelegate <NSObject>

@optional
/**
 *   头视图中的菜单的点击
 */
- (void)headMenuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex;

@end

@interface HeadView : UIView

@property (nonatomic, weak) id<HeadViewDelegate>delegate;

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
 *  各个控制器的 所对应的标题
 */
@property (nonatomic, copy) NSArray<NSString *> *titleArry;

/**
 *   刷新头视图
 */
- (void)reloadData;
/**
 *   头视图中的菜单的用户交互  在滑动的时候  不能使用  停止滑动 打开菜单的用户交互
 */
-(void)menuViewUserInteractionEnabled:(BOOL)userInteractionEnabled;

-(void)slideMenuAtProgress:(CGFloat)progress scroll:(UIScrollView *)scrollView;;

@end
