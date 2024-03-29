//
//  MessageTabViewController.m
//  TubeBook_iOS
//
//  Created by 柯建芳 on 2018/1/15.
//  Copyright © 2018年 柯建芳. All rights reserved.
//

#import "MessageTabViewController.h"
#import "CKTextView.h"
#import "Masonry.h"
#import "CKMacros.h"
#import "TagCollectionView.h"
#import "UITagView.h"
#import "LCActionSheet.h"
#import "TubeArticleManager.h"
#import "TubeSDK.h"
#import "AlterMessageViewController.h"
#import "TubeAlterCenter.h"
#import "TubeCollectionView.h"
#import "UIImageWithLable.h"
#import "MessageCommentViewController.h"
#import "TubeRootViewController.h"
#import "MessageLikeViewController.h"
#import "SerialViewController.h"
#import "AuthorViewController.h"
#import "TubeWebViewViewController.h"

@interface MessageTabViewController () <TubeCollectionViewDelegate>

@property (nonatomic, strong) UILabel *navigationtitleLable;
@property (nonatomic, strong) UIScrollView *backScrollView;
@property (nonatomic, strong) TubeCollectionView *collectionView;
@property (nonatomic, strong) UIImageWithLable *commentItem;
@property (nonatomic, strong) UIImageWithLable *likeItem;
@property (nonatomic, strong) UIImageWithLable *attentSerialItem;
@property (nonatomic, strong) UIImageWithLable *attentUserItem;

@end

@implementation MessageTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,
                                                                         SCREEN_HEIGHT)];
    [self.view addSubview:self.backScrollView];
    self.backScrollView.scrollEnabled = YES;
    self.backScrollView.alwaysBounceVertical = YES;
    
    self.collectionView = [[TubeCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    [self.backScrollView addSubview:self.collectionView];
    self.collectionView.tubeCollectionDelegate = self;
    UIView *spaceLineDownCollectionView = [[UIView alloc] init];
    [self.backScrollView addSubview:spaceLineDownCollectionView];
    [spaceLineDownCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.collectionView.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    spaceLineDownCollectionView.backgroundColor = HEXCOLOR(0xcdcdcd);
    
    
    self.commentItem = [[UIImageWithLable alloc] initUIImageWithLableWithWidth:(SCREEN_WIDTH-5*kMegin)/4 height:((SCREEN_WIDTH-5*kMegin)/4+kIconMarginBottom) ];
    self.commentItem.title = @"评论";
    [self.commentItem setIconByImageName:@"icon_user_comment"];
    [self.collectionView addItemView:self.commentItem];
    
    self.likeItem = [[UIImageWithLable alloc] initUIImageWithLableWithWidth:(SCREEN_WIDTH-5*kMegin)/4 height:((SCREEN_WIDTH-5*kMegin)/4+kIconMarginBottom) ];
    self.likeItem.title = @"喜欢";
    [self.likeItem setIconByImageName:@"icon_like2"];
    [self.collectionView addItemView:self.likeItem];
    
    self.attentSerialItem = [[UIImageWithLable alloc] initUIImageWithLableWithWidth:(SCREEN_WIDTH-5*kMegin)/4 height:((SCREEN_WIDTH-5*kMegin)/4+kIconMarginBottom) ];
    self.attentSerialItem.title = @"连载";
    [self.attentSerialItem setIconByImageName:@"icon_attent_serial"];
    [self.collectionView addItemView:self.attentSerialItem];
    
    self.attentUserItem = [[UIImageWithLable alloc] initUIImageWithLableWithWidth:(SCREEN_WIDTH-5*kMegin)/4 height:((SCREEN_WIDTH-5*kMegin)/4+kIconMarginBottom) ];
    self.attentUserItem.title = @"关注";
    [self.attentUserItem setIconByImageName:@"icon_attent_user"];
    [self.collectionView addItemView:self.attentUserItem];
    
    UIImageWithLable *jianshu = [[UIImageWithLable alloc] initUIImageWithLableWithWidth:(SCREEN_WIDTH-5*kMegin)/4 height:((SCREEN_WIDTH-5*kMegin)/4+kIconMarginBottom) ];
    jianshu.title = @"简书";
    [jianshu setIconByImageName:@"icon_jianshu"];
    [self.collectionView addItemView:jianshu];
    
    UIImageWithLable *zhihu = [[UIImageWithLable alloc] initUIImageWithLableWithWidth:(SCREEN_WIDTH-5*kMegin)/4 height:((SCREEN_WIDTH-5*kMegin)/4+kIconMarginBottom) ];
    zhihu.title = @"知乎";
    [zhihu setIconByImageName:@"zhihu.jpeg"];
    [self.collectionView addItemView:zhihu];
    
    UIImageWithLable *instagram = [[UIImageWithLable alloc] initUIImageWithLableWithWidth:(SCREEN_WIDTH-5*kMegin)/4 height:((SCREEN_WIDTH-5*kMegin)/4+kIconMarginBottom) ];
    instagram.title = @"小红书";
    [instagram setIconByImageName:@"icon_xiaohongshu.jpeg"];
    [self.collectionView addItemView:instagram];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%s ",__func__);
    [self requestLikeNotReviewCount];
    [self requestCommentNotReviewCount];
    if (self.navigationController.navigationBar.isHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    if (!self.navigationtitleLable) {
        self.navigationtitleLable =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 45)];
        self.navigationtitleLable.text = @"Tube 消息";
        [self.navigationController.navigationBar addSubview:self.navigationtitleLable];
        [self.navigationtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.navigationController.navigationBar);
            make.centerY.equalTo(self.navigationController.navigationBar);
        }];
    }
    self.navigationtitleLable.hidden = NO;

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationtitleLable.hidden = YES;
    NSLog(@"%s ",__func__);
}

- (void)collectionItemView:(UIView *)itemView index:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            TubeRootViewController *vc = [[TubeRootViewController alloc] initWithRootViewController:[[MessageCommentViewController alloc] init]];
            [self.tabBarController presentViewController:vc animated:YES completion:nil];
            break;
        }
        case 1:
        {
            TubeRootViewController *vc = [[TubeRootViewController alloc] initWithRootViewController:[[MessageLikeViewController alloc] init]];
            [self.tabBarController presentViewController:vc animated:YES completion:nil];
            break;
        }
        case 2:
        {
            UIViewController *c = [[SerialViewController alloc] initSerialViewControllerWithFouseType:FouseTypeCreate
                                                                                                  uid:[[UserInfoUtil sharedInstance].userInfo objectForKey:kAccountKey]];
            c.title = @"我的连载";
            [self.navigationController pushViewController:c animated:YES];
            break;
        }
        case 3:
        {
            UIViewController *c = [[AuthorViewController alloc] initAuthorViewControllerWithAutorType:AuthorTypeAttented];
            c.title = @"我的粉丝";
            [self.navigationController pushViewController:c animated:YES] ;
            break;
        }
        case 4:
        {
            UIViewController *c = [[TubeWebViewViewController alloc] initTubeWebViewViewControllerWithUrl:@"https://www.jianshu.com/"];
            c.title = @"简书";
            [self.navigationController pushViewController:c animated:YES];
            break;
        }
        case 5:
        {
            UIViewController *c = [[TubeWebViewViewController alloc] initTubeWebViewViewControllerWithUrl:@"https://www.zhihu.com/topics"];
            c.title = @"知乎";
            [self.navigationController pushViewController:c animated:YES];
            break;
        }
        case 6:
        {
            UIViewController *c = [[TubeWebViewViewController alloc] initTubeWebViewViewControllerWithUrl:@"http://www.xiaohongshu.com/"];
            c.title = @"小红书";
            [self.navigationController pushViewController:c animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - request
- (void)requestLikeNotReviewCount
{
    [[TubeSDK sharedInstance].tubeArticleSDK fetchedLikeNotReviewCount:[[UserInfoUtil sharedInstance].userInfo objectForKey:kAccountKey]  callBack:^(DataCallBackStatus status, BaseSocketPackage *page) {
        if (status == DataCallBackStatusSuccess) {
            NSDictionary *content = page.content.contentData;
            NSInteger count = [[content objectForKey:@"count"] integerValue];
            self.likeItem.countNotReview = count;
            [self updatebadgeValue];
        }
    }];
}

- (void)requestCommentNotReviewCount
{
    [[TubeSDK sharedInstance].tubeArticleSDK fetchedCommentNotReviewCountWithUid:[[UserInfoUtil sharedInstance].userInfo objectForKey:kAccountKey] callBack:^(DataCallBackStatus status, BaseSocketPackage *page) {
        if (status == DataCallBackStatusSuccess) {
            NSDictionary *content = page.content.contentData;
            NSInteger count = [[content objectForKey:@"count"] integerValue];
            self.commentItem.countNotReview = count;
            [self updatebadgeValue];
        }
    }];
}

#pragma mark - private
- (void)updatebadgeValue
{
    if (self.likeItem.countNotReview + self.commentItem.countNotReview == 0){
        self.tabBarItem.badgeValue = nil;
    } else {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%lu", self.likeItem.countNotReview + self.commentItem.countNotReview];
    }
}

@end
