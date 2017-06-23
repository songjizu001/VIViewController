//
//  ContentController.m
//  BackGroundMessage
//
//  Created by Jizu Song on 2017/6/21.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import "ContentController.h"

NSString *kContenVCListStatusChangedNotification = @"kNetworkStatusChangedNotification";


@interface ContentController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) BOOL fingerIsTouch;//手指正在点击
@end

@implementation ContentController

- (instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
     
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
   
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    if (!self.tableCanScroll) {
     
        scrollView.contentOffset = CGPointZero;
    }
    
    if (scrollView.contentOffset.y <= 0) {
      
        self.tableCanScroll = NO;
        
        scrollView.contentOffset = CGPointZero;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kContenVCListStatusChangedNotification object:nil];//到顶通知父视图改变状态
    }
    
    self.tableView.showsVerticalScrollIndicator = _tableCanScroll?YES:NO;
}

#pragma mark UIScrollView 判断屏幕触碰状态
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSLog(@"接触屏幕");
    self.fingerIsTouch = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    NSLog(@"离开屏幕");
    self.fingerIsTouch = NO;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) -64 -40 -10) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor =[UIColor orangeColor];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
