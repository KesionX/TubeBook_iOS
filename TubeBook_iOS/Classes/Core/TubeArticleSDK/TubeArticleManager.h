//
//  TubeArticleManager.h
//  TubeBook_iOS
//
//  Created by 柯建芳 on 2018/3/31.
//  Copyright © 2018年 柯建芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TubeArticleConst.h"
#import "TubeServerDataSDK.h"
#import "BaseTubeServerManager.h"

@interface TubeArticleManager : BaseTubeServerManager

- (instancetype)initTubeArticleManagerWithSocket:(TubeServerDataSDK *)tubeServer;

/*
 * @brief 获取标签
 */
- (void)fetchedArticleTagListWithCount:(NSInteger)count callBack:(dataCallBackBlock)callBack;

/*
 * @brief 添加标签
 */
- (void)addArticleTag:(NSString *)tag callBack:(dataCallBackBlock)callBack;

/*
 * @brief 获取专题标题信息列表
 * @parme uid 为空代表所有, 不为空代表取关注
 */
- (void)fetchedArticleTopicTitleListWithIndex:(NSInteger)index uid:(NSString *)uid conditionDic:(NSDictionary *)conditionDic callBack:(dataCallBackBlock)callBack;

/*
 * @brief 获取连载标题信息列表
 */
- (void)fetchedArticleSerialTitleListWithIndex:(NSInteger)index fouseType:(FouseType)fouseType;

/*
 * @brief 获取关注的作者列表
 */
- (void)fetchedUserInfoListWithIndex:(NSInteger)index fouseType:(FouseType)fouseType;

/*
 * @brief 获取最新文章(普通/专题/连载)列表
 */
- (void)fetchedNewArticleListWithIndex:(NSInteger)index articleType:(ArticleType)articleType fouseType:(FouseType)fouseType;

/*
 * @brief 获取最新文章(普通/专题/连载)列表,tabid
 */
 - (void)fetchedNewArticleListtWithIndex:(NSInteger)index articleType:(ArticleType)articleType tabid:(NSInteger)tabid fouseType:(FouseType)fouseType;

/*
 * @brief 获取推荐文章(普通/专题/连载)列表
 */
- (void)fetchedRecommendArticleListtWithIndex:(NSInteger)index articleType:(ArticleType)articleType fouseType:(FouseType)fouseType;

/*
 * @brief 获取推荐文章(普通/专题/连载)列表, tabid
 */
- (void)fetchedRecommendArticleListtWithIndex:(NSInteger)index articleType:(ArticleType)articleType tabid:(NSInteger)tabid fouseType:(FouseType)fouseType;

/*
 * @brief 获取文章详细信息
 */
- (void)fetchedArticleContentWithAtid:(NSUInteger)atid;

@end