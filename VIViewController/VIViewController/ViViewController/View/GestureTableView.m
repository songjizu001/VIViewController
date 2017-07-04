//
//  GestureTableView.m
//  BackGroundMessage
//
//  Created by Jizu Song on 2017/6/19.
//  Copyright © 2017年 Jizu Song. All rights reserved.
//

#import "GestureTableView.h"

@implementation GestureTableView

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        self.shouldRecognize = YES;
    }
    return self;
}

// 同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    return self.shouldRecognize;
}

@end
