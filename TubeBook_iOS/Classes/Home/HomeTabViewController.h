//
//  HomeTabViewController.h
//  TubeBook_iOS
//
//  Created by 柯建芳 on 2018/1/15.
//  Copyright © 2018年 柯建芳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTabViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *arrayControllers;
@property (nonatomic, strong) UIPageViewController *pageViewController;

- (CGFloat)getUIHeight;

@end
