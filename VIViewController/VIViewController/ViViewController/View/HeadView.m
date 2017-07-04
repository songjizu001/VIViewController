//
//  HeadView.m
//  BackGroundMessage
//
//  Created by Jizu Song on 2017/6/21.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import "HeadView.h"
#import "WMMenuView.h"

@interface HeadView ()<WMMenuViewDelegate,WMMenuViewDataSource>

@property(nonatomic,strong)UILabel     * titleLabel;

@property(nonatomic,strong)UILabel     * descLabel;

@property(nonatomic,strong)WMMenuView  * menuView;

@property(nonatomic,strong)UIView      * menuBottomLineView;

@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.titleArry = @[@"精选",@"推荐"];
        
        self.menuTitleSize = 15;
        
        self.menuItemCorlorNor = UIColorFromHex(0x333333);
        
        self.menuItemCorlorSel = UIColorFromHex(0x888888);
                
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.descLabel];
        
        [self addSubview:self.menuView];

        [self.menuView addSubview:self.menuBottomLineView];

    }
    return self;
}

#pragma mark - WMMenuView DataSource
- (NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu{
    return self.titleArry.count;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index{
    return self.titleArry[index];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
 
    return (kScreenWidth/self.titleArry.count);
}

- (CGFloat)menuView:(WMMenuView *)menu titleSizeForState:(WMMenuItemState)state{
   
    return self.menuTitleSize;
}

- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state{
    
    if (state == WMMenuItemStateSelected) {return self.menuItemCorlorSel;}
    
    return self.menuItemCorlorNor;
}

#pragma mark - WMMenuView Delegate
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex {
   
    if (self.delegate && [self.delegate respondsToSelector:@selector(headMenuView:didSelesctedIndex:currentIndex:)]) {
        [self.delegate headMenuView:menu didSelesctedIndex:index currentIndex:currentIndex];
    }
}

- (void)reloadData{
    
    [self.menuView reload];
}


-(void)menuViewUserInteractionEnabled:(BOOL)userInteractionEnabled{
  
    self.menuView.userInteractionEnabled = userInteractionEnabled;

}

-(void)slideMenuAtProgress:(CGFloat)progress scroll:(UIScrollView *)scrollView;{
    
    [self.menuView slideMenuAtProgress:progress];

    if (scrollView.contentOffset.y == 0) { return; }
    CGPoint contentOffset = scrollView.contentOffset;
    contentOffset.y = 0.0;
    scrollView.contentOffset = contentOffset;
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(40, 60, FNScreenWidth - 80, 40);
    
    self.descLabel.frame  = CGRectMake(10, 120, FNScreenWidth - 20, 80);
    
    self.menuView.frame   = CGRectMake(0, self.height - self.menuView.height, FNScreenWidth, self.menuView.height);
    
    self.menuBottomLineView.frame   = CGRectMake(0, self.menuView.height -0.5, FNScreenWidth, 0.5);

}

- (UILabel *)titleLabel{
  
    if (!_titleLabel) {
       
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 60, FNScreenWidth - 80, 40)];
        
        _titleLabel.text = @"风光";
        
        _titleLabel.font = [UIFont systemFontOfSize:38];
        
        _titleLabel.textColor = [UIColor whiteColor];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}

- (UILabel *)descLabel{

    if (!_descLabel) {

        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, FNScreenWidth - 20, 80)];
        
        _descLabel.text = @"风光上架经典款垃圾卡拉圾卡拉卡即可了解快乐圾卡拉卡即可了解快乐卡即可了解快乐撒激烈的";
        
        _descLabel.font = [UIFont systemFontOfSize:15];
        
        _descLabel.textColor = [UIColor whiteColor];
        
        _descLabel.textAlignment = NSTextAlignmentCenter;
        
        _descLabel.numberOfLines = 2;
        
    }
    return _descLabel;
}

-(WMMenuView *)menuView{

    if (!_menuView) {
       
        _menuView = [[WMMenuView alloc] initWithFrame:CGRectMake(0, 0, FNScreenWidth, 40)];
        _menuView.backgroundColor = [UIColor whiteColor];
        _menuView.delegate = self;
        _menuView.dataSource = self;
        _menuView.style = WMMenuViewStyleLine;
        _menuView.layoutMode = WMMenuViewLayoutModeCenter;
        _menuView.progressHeight = 3;
        _menuView.contentMargin = 0;
        _menuView.progressViewBottomSpace = 1;
        NSMutableArray *tmp = [NSMutableArray arrayWithArray:@[@(10),@(10),@(10)]];
        _menuView.progressWidths = tmp;
        _menuView.progressViewIsNaughty = YES;
        _menuView.lineColor = [UIColor colorWithRed:0.071 green:0.808 blue:0.475 alpha:1.00];
    }
    return _menuView;
}

-(UIView *)menuBottomLineView{
    
    if (!_menuBottomLineView) {
    
        _menuBottomLineView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, FNScreenWidth, 0.5)];
        
        _menuBottomLineView.backgroundColor =[[UIColor grayColor] colorWithAlphaComponent:0.4];
    }
    return _menuBottomLineView;
}


@end
