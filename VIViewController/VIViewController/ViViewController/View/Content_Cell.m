//
//  Content_Cell.m
//  BackGroundMessage
//
//  Created by Jizu Song on 2017/6/21.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import "Content_Cell.h"
#import "ContentController.h"

static NSString *collectionCellIdentifier = @"collectionCellIdentifier";

@interface Content_Cell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL  isClickMemuButton;//collectionView的滚动是否是因为点击了按钮滚动的

@end

@implementation Content_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.isClickMemuButton = NO;
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.collectionView];

    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.collectionView.frame = self.contentView.bounds;
}

-(void)setChildsVCs:(NSArray *)childsVCs{
   
    _childsVCs = childsVCs;
    
    [self.collectionView reloadData];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.childsVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIViewController *childVC = self.childsVCs[indexPath.item];
    
    UIView * view = childVC.view;
    
    [cell.contentView addSubview:view];
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.isClickMemuButton = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(content_CellCollectionViewWillBeginDragging:)]) {
        [self.delegate content_CellCollectionViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.isClickMemuButton) {return;}
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(content_CellCollectionViewDidScroll:)]) {
      
        [self.delegate content_CellCollectionViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(content_CellCollectionViewDidEndDecelerating:)]) {
        
        [self.delegate content_CellCollectionViewDidEndDecelerating:scrollView];
    }
}

- (void)setCellCanScroll:(BOOL)cellCanScroll{
   
    _cellCanScroll = cellCanScroll;
    
    for (ContentController *VC in _childsVCs) {
    
        VC.tableCanScroll = cellCanScroll;
        
        if (!cellCanScroll) {
            //如果cell不能滑动，代表到了顶部，修改所有子vc的状态回到顶部
            [VC.tableView setContentOffset:CGPointZero];
        }
    }
}

- (void)cellContentCollectOffset:(CGPoint)contentOffset animated:(BOOL)animated{

    [self.collectionView setContentOffset:contentOffset animated:animated];
}

- (UICollectionView *)collectionView{
   
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(FNScreenWidth, FNScreenHeight-1);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
       
        _collectionView = [[UICollectionView alloc]initWithFrame:self.contentView.bounds collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor =[UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCellIdentifier];
    }
    return _collectionView;
}

- (void)setContentViewCurrentIndex:(NSInteger)contentViewCurrentIndex{
    
    if (_contentViewCurrentIndex < 0||_contentViewCurrentIndex > self.childsVCs.count-1) {
        return;
    }
    _isClickMemuButton = YES;
    _contentViewCurrentIndex = contentViewCurrentIndex;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:contentViewCurrentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

@end
