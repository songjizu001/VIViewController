//
//  VIViewController.m
//  VIViewController
//
//  Created by Jizu Song on 2017/6/23.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import "VIViewController.h"
#import "GestureTableView.h"
#import "HeadView.h"
#import "Content_Cell.h"
#import "LoadingView.h"

static NSString *CellIdentifier = @"UITableViewCell";


@interface VIViewController ()<UITableViewDelegate,UITableViewDataSource,Content_CellDelegate,HeadViewDelegate>{
    CGFloat _viewHeight, _viewWidth, _viewX, _viewY, _targetX, _superviewHeight;
    BOOL    _hasInited, _shouldNotScroll;
    NSInteger _initializedIndex, _controllerConut;
}


@property (nonatomic,strong)  GestureTableView  * tableView;  // 列表
@property (nonatomic,strong)  UIImageView       * backImageV; // 背板的图片Add TableView 上
@property (nonatomic,strong)  HeadView          * headView;   // 顶部视图
@property (nonatomic,assign)  BOOL                canScroll;  //外部TableView 是否可以滚动
@property (nonatomic,strong)  UIToolbar         * navBar;     //导航套
@property (nonatomic,strong)  Content_Cell      * cell;
@property (nonatomic, strong) NSMutableArray    * childsVCs;//子视图数组

@property (nonatomic, strong) LoadingView       * loadingView;

@end

@implementation VIViewController

- (void)dealloc{
   
    NSLog(@"%@--->销毁了",self.class);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
   
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden  = YES;
    
    self.edgesForExtendedLayout  = UIRectEdgeNone;

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self.tableView addSubview:self.backImageV];
    
    self.tableView.tableHeaderView = self.headView;
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.navBar];
    
    self.canScroll = YES;
    
    self.pageAnimatable = YES;
    
    _viewWidth = self.view.frame.size.width;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:kContenVCListStatusChangedNotification object:nil];
    
    [self.view addSubview:self.loadingView];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    self.tableView.shouldRecognize = NO;
}

- (void)viewWillAppear:(BOOL)animated{
  
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.tableView.shouldRecognize = YES;
}

#pragma mark notify改变主视图的状态
- (void)changeScrollStatus{
    
    self.canScroll = YES;
    
    self.cell.cellCanScroll = NO;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Content_Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    self.cell = cell;
    cell.childsVCs = self.childsVCs;
    cell.delegate = self;
    return cell;
}

- (void)content_CellCollectionViewWillBeginDragging:(UIScrollView *)scrollView{

    _startDragging = YES;

    [self.headView menuViewUserInteractionEnabled:NO];
}

- (void)content_CellCollectionViewDidScroll:(UIScrollView *)scrollView{
    
    _tableView.scrollEnabled = NO;//CollectionView 开始滚动 主tableview禁止滑动
    
    if (_startDragging) {
        
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        
        if (contentOffsetX < 0) {contentOffsetX = 0;}
        
        if (contentOffsetX > scrollView.contentSize.width - _viewWidth) {
        
            contentOffsetX = scrollView.contentSize.width - _viewWidth;
        }
        
        CGFloat rate = contentOffsetX / _viewWidth;
        
        [self.headView slideMenuAtProgress:rate scroll:scrollView];
    }
}

- (void)content_CellCollectionViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _startDragging = YES;
    
    [self.headView menuViewUserInteractionEnabled:NO];
    
    _tableView.scrollEnabled = YES;//CollectionView 停止滚动 主tableview打开滑动
}

- (void)headMenuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex{

    _startDragging = NO;

    CGPoint targetP = CGPointMake(_viewWidth*index, 0);
    
    [self.cell cellContentCollectOffset:targetP animated:self.pageAnimatable];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return FNScreenHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //设置头部底图放大
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y < 0) {
        
        self.backImageV.frame=CGRectMake(offsetY/2, offsetY,self.view.frame.size.width - offsetY,250 - offsetY);
    }
    
    /*
     设置两个tableView的滚动权限
     
     向上滑动：
     这里的不让滚动是用的是软性的 既为  当你滚动的值 大于 bottomCellOffset 值的时候
     那么我就让你当前的主 scrollView.contentOffset 一直就是 bottomCellOffset 这样就一直滚动就不动了
     
     向下滑动：
     
     这时候通过监听内部控制器中的滚动情况：
     
     1.内部的若还未滚动到顶部那么外部的主TableView还保持当前offset 不变
     即 设置 scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
     
     2.内部的若滚动到顶部 那么通知监听 self.canScroll = yes 那么这个是时候就不会强制设置scrollView.contentOffset
     既解除了顶部的固定了
     
     */
    
    CGFloat bottomCellOffset = [_tableView rectForSection:0].origin.y - 64 - 40;
    if (scrollView.contentOffset.y >= bottomCellOffset) {
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (self.canScroll) {
            self.canScroll = NO;
            self.cell.cellCanScroll = YES;
        }
    }else{
        //子视图没到顶部
        if (!self.canScroll) {
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
    }
    
    self.tableView.showsVerticalScrollIndicator = _canScroll?YES:NO;
    
    //设置导航条的颜色
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = offset_Y/(250 - 64 - 40);
    self.navBar.alpha = alpha;
    
    [UIApplication sharedApplication].statusBarStyle = (self.navBar.alpha > 0.6 )?UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
}


- (void)reloadData{

    [self.childsVCs removeAllObjects];

    for (int i = 0 ; i < self.viewControllerClasses.count ;i ++ ) {
        UIViewController *viewController = [self initializeViewControllerAtIndex:i];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        [self.childsVCs addObject:viewController];
    }
    
    [self.tableView reloadData];

    [self.headView reloadData];
}

- (UIViewController *)initializeViewControllerAtIndex:(NSInteger)index {
//    if ([self.dataSource respondsToSelector:@selector(pageController:viewControllerAtIndex:)]) {
//        return [self.dataSource pageController:self viewControllerAtIndex:index];
//    }
    return [[self.viewControllerClasses[index] alloc] init];
}


- (void)startLoading{

    [self.loadingView _loadAnimationNamed:@"video_cam"];
}

- (void)stopLoading{
    [self.loadingView stop];
}


#pragma mark LazyLoad
- (GestureTableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[GestureTableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = YES;
        [_tableView registerClass:[Content_Cell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}

- (UIImageView *)backImageV{
    
    if (!_backImageV) {
        _backImageV =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bjt"]];
        _backImageV.frame = CGRectMake(0, 0, FNScreenWidth, 250);
        _backImageV.contentMode = UIViewContentModeScaleAspectFill;
        _backImageV.clipsToBounds = YES;
    }
    return _backImageV;
}

- (HeadView *)headView{
    
    if (!_headView) {
        _headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, FNScreenWidth, 250)];
        _headView.delegate = self;
    }
    return _headView;
}

- (UIToolbar *)navBar{
    
    if (!_navBar) {
        _navBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, FNScreenWidth, 64)];
        _navBar.barStyle = UIBarStyleDefault;
        _navBar.alpha = 0.0f;
    }
    return _navBar;
}

- (NSMutableArray *)childsVCs{
    
    if (!_childsVCs) {
        _childsVCs = [NSMutableArray array];
    }
    return _childsVCs;
}

-(LoadingView *)loadingView{
    
    if (!_loadingView) {
        _loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        __weak typeof(self)weakSelf = self;
        _loadingView.block = ^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _loadingView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitles:(NSArray<NSString *> *)titles{
    
    _titles = titles;
    
    _headView.titleArry = titles;
}

- (void)setMenuItemCorlorNor:(UIColor *)menuItemCorlorNor{
    
    _menuItemCorlorNor = menuItemCorlorNor;
    
    _headView.menuItemCorlorNor = _menuItemCorlorNor;
}

- (void)setMenuItemCorlorSel:(UIColor *)menuItemCorlorSel{
    
    _menuItemCorlorSel = menuItemCorlorSel;
    
    _headView.menuItemCorlorSel = _menuItemCorlorSel;
}

- (void)setMenuTitleSize:(CGFloat)menuTitleSize{
   
    _menuTitleSize = menuTitleSize;
    
    _headView.menuTitleSize = _menuTitleSize;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
