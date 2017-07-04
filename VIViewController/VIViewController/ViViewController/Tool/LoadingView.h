//
//  LoadingView.h
//  VIViewController
//
//  Created by Jizu Song on 2017/7/4.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBlock)();


@interface LoadingView : UIView

@property (nonatomic,copy)BackBlock      block;

- (void)_loadAnimationNamed:(NSString *)named;

- (void)stop;

@end
