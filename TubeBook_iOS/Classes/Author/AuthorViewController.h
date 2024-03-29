//
//  AuthorViewController.h
//  TubeBook_iOS
//
//  Created by 柯建芳 on 2018/1/20.
//  Copyright © 2018年 柯建芳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TubeRefreshTableViewController.h"

typedef NS_ENUM(NSInteger, AuthorType)
{
    AuthorTypeAttent,
    AuthorTypeAttented
};

@interface AuthorViewController : TubeRefreshTableViewController

@property (nonatomic, assign) AuthorType autorType;

- (instancetype)initAuthorViewControllerWithAutorType:(AuthorType)autorType;



@end
