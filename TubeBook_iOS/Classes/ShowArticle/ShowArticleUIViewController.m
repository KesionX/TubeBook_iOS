//
//  ShowArticleUIViewController.m
//  TubeBook_iOS
//
//  Created by 柯建芳 on 2018/4/13.
//  Copyright © 2018年 柯建芳. All rights reserved.
//

#import "ShowArticleUIViewController.h"
#import "TubeWebViewViewController.h"
#import "CommentUIViewController.h"
#import "TubeNavigationUITool.h"
#import "ArticleWebViewController.h"


@interface ShowArticleUIViewController ()

@property (nonatomic, strong) UIIndicatorView *indicator;
@property (nonatomic, strong) ArticleWebViewController *articleWebViewController;
@property (nonatomic, strong) CommentUIViewController *articleCommentViewController;
@property (nonatomic, strong) NSString *atid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *body;

@end

@implementation ShowArticleUIViewController

- (void)dealloc
{
    [self.indicator removeFromSuperview];
}

- (instancetype)initShowArticleUIViewControllerWithAtid:(NSString *)atid uid:(NSString *)uid
{
    self = [super init];
    if ( self ) {
        self.atid = atid;
        self.uid = uid;
    }
    return self;
}

- (instancetype)initShowArticleUIViewControllerWithAtid:(NSString *)atid uid:(NSString *)uid body:(NSString *)body
{
    self = [super init];
    if ( self ) {
        self.atid = atid;
        self.uid = uid;
        self.body = body;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [TubeNavigationUITool itemWithIconImage:[UIImage imageNamed:@"icon_back"] title:@"返回" titleColor:kTUBEBOOK_THEME_NORMAL_COLOR target:self action:@selector(back)];
    [self createIndicator];
    [self configIndicator:self.indicator];
    [self configPageView:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) arrayControllers:[NSMutableArray arrayWithObjects:self.articleWebViewController,self.articleCommentViewController, nil]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configNavigation];
    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64);
}

- (void)configNavigation
{
    if (self.navigationController.navigationBar.isHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
  //  self.tabBarController.navigationItem.titleView = self.indicator; // 重新加载，防止显示出错
}

- (void)createIndicator
{
    if (!self.indicator) {
        self.indicator = [[UIIndicatorView alloc] initUIIndicatorView:kTUBEBOOK_THEME_NORMAL_COLOR
                                                                style:UIIndicatorViewLineStyle
                                                               arrays:[NSMutableArray arrayWithObjects:@"文章", @"评论", nil]
                                                                 font:Font(18)
                                                      textNormalColor:kTEXTCOLOR
                                                       textLightColor:kTUBEBOOK_THEME_NORMAL_COLOR
                                                   isEnableAutoScroll:NO];
        [self.navigationController.navigationBar addSubview:self.indicator];
        [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.navigationController.navigationBar);
            make.centerY.equalTo(self.navigationController.navigationBar);
            make.width.mas_equalTo([self.indicator getUIWidth]);
            make.height.mas_equalTo([self.indicator getUIHeight]);
        }];
        [self.indicator setShowIndicatorItem:0];
        [self.navigationController.navigationItem.titleView removeFromSuperview];
        
        self.navigationController.navigationItem.titleView = self.indicator;
    }
}

#pragma mark - action

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - get

- (ArticleWebViewController *)articleWebViewController
{
    if (!_articleWebViewController) {
        if ( self.body ) {
            _articleWebViewController = [[ArticleWebViewController alloc] initArticleWebViewControllerWithHtml:self.body];
        } else {
            _articleWebViewController = [[ArticleWebViewController alloc] init];
        }
    }
    return _articleWebViewController;
}

- (CommentUIViewController *)articleCommentViewController
{
    if (!_articleCommentViewController) {
        _articleCommentViewController = [[CommentUIViewController alloc] init];
    }
    return _articleCommentViewController;
}

@end
