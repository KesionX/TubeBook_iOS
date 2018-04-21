//
//  TubeArticleManager.m
//  TubeBook_iOS
//
//  Created by 柯建芳 on 2018/3/31.
//  Copyright © 2018年 柯建芳. All rights reserved.
//

#import "TubeArticleManager.h"
#import "ProtocolConst.h"
#import "TubeLinkManager.h"

@interface TubeArticleManager ()

@property (nonatomic, strong) NSMutableDictionary *requestCallBackBlockDir;

@end

@implementation TubeArticleManager
{
    NSInteger tag;
}


- (instancetype)initTubeArticleManagerWithSocket:(TubeServerDataSDK *)tubeServer;
{
    self = [super initBaseTubeServerManager:tubeServer];
    if (self) {
        self.requestCallBackBlockDir = [[NSMutableDictionary alloc] init];
    }
    return self;
}
// 监听协议的配置
- (NSString *)procotolName
{
    return ARTICLE_PROTOCOL;
}

/*
 * @brief 获取标签
 */
- (void)fetchedArticleTagListWithCount:(NSInteger)count callBack:(dataCallBackBlock)callBack;
{
    NSLog(@"%s protocol:%@ method:%@ count:%ld", __func__, ARTICLE_PROTOCOL, ARTICLE_PROTOCOL_TAG, count);
    if ([self.requestCallBackBlockDir objectForKey:ARTICLE_PROTOCOL_TAG]) {
        NSLog(@"%s haved request fetchedArticleTagListWithCount, wait after", __func__);
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:ARTICLE_PROTOCOL_TAG];
    }
    NSDictionary *contentDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @(count), @"tagCount",nil];
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_PROTOCOL_TAG,PROTOCOL_METHOD,
                             nil];
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

- (void)addArticleTag:(NSString *)tag callBack:(dataCallBackBlock)callBack
{
    NSLog(@"%s protocol:%@ method:%@ tag:%@", __func__, ARTICLE_PROTOCOL, ARTICLE_PROTOCOL_ADD_TAG, tag);
    if ([self.requestCallBackBlockDir objectForKey:ARTICLE_PROTOCOL_ADD_TAG]) {
        NSLog(@"%s haved request addArticleTag, wait after", __func__);
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:ARTICLE_PROTOCOL_ADD_TAG];
    }
    NSDictionary *contentDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                tag, @"tag",nil];
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_PROTOCOL_ADD_TAG,PROTOCOL_METHOD,
                             nil];
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 获取专题标题信息列表
 */
- (void)fetchedArticleTopicTitleListWithIndex:(NSInteger)index
                                          uid:(NSString *)uid
                                    fouseType:(FouseType)fouseType
                                 conditionDic:(NSDictionary *)conditionDic
                                     callBack:(dataCallBackBlock)callBack;
{
    NSLog(@"%s protocol:%@ method:%@ index:%lu uid:%@", __func__, ARTICLE_PROTOCOL, ARTICLE_TOPIC_TITLE_LIST, index, uid);
    if ([self.requestCallBackBlockDir objectForKey:ARTICLE_TOPIC_TITLE_LIST]) {
        NSLog(@"haved request fetchedArticleTopicTitleListWithIndex, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:ARTICLE_TOPIC_TITLE_LIST];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                @(fouseType), @"fouseType",
                                @(index), @"index",
                                uid,@"uid",nil];
    if (conditionDic) {
        [contentDic addEntriesFromDictionary:conditionDic];
    }
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_TOPIC_TITLE_LIST,PROTOCOL_METHOD,
                             nil];
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 上传文章
 * @parme detailDic 为可设内容
 */
- (void)uploadArticleWithTitle:(nonnull NSString *)title
                          atid:(nonnull NSString *)atid
                           uid:(nonnull NSString *)uid
                        detail:(NSDictionary *)detailDic
                      callBack:(dataCallBackBlock)callBack;
{
    NSLog(@"%s protocol:%@ method:%@ title:%@ uid:%@", __func__, ARTICLE_PROTOCOL, ARTICLE_UPLOAD, title, uid);
    if ([self.requestCallBackBlockDir objectForKey:ARTICLE_UPLOAD]) {
        NSLog(@"%s haved request uploadArticleWithTitle, wait after",__func__);
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:ARTICLE_UPLOAD];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       atid, @"atid",
                                       title, @"title",
                                       uid, @"userid", nil];
    if (detailDic) {
        [contentDic addEntriesFromDictionary:detailDic];
    }
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_UPLOAD,PROTOCOL_METHOD,
                             nil];
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 设置文章标签
 */
- (void)setArticleTagWithAtid:(nonnull NSString *)atid tags:(NSArray *)tags callBack:(dataCallBackBlock)callBack
{
    NSLog(@"%s protocol:%@ method:%@ atid:%@ tags:%@", __func__, ARTICLE_PROTOCOL, ARTICLE_SET_TAGS, atid, tags);
    if ([self.requestCallBackBlockDir objectForKey:ARTICLE_SET_TAGS]) {
        NSLog(@"%s haved request setArticleTagWithAtid, wait after",__func__);
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:ARTICLE_SET_TAGS];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       atid, @"atid",
                                       tags, @"tags", nil];
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_SET_TAGS,PROTOCOL_METHOD,
                             nil];
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 设置文章类型
 */
- (void)setArticleTabWithAtid:(nonnull NSString *)atid
                  articleType:(ArticleType)articleType
                         tabid:(NSInteger)tabid
                     callBack:(dataCallBackBlock)callBack
{
    NSLog(@"%s protocol:%@ method:%@ atid:%@ tabid:%lu", __func__, ARTICLE_PROTOCOL, ARTICLE_SET_TAB, atid, tabid);
    if ([self.requestCallBackBlockDir objectForKey:ARTICLE_SET_TAB]) {
        NSLog(@"%s haved request setArticleTabWithAtid, wait after",__func__);
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:ARTICLE_SET_TAB];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       atid, @"atid",
                                       @(articleType), @"tabtype",
                                       @(tabid), @"tabid", nil];
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_SET_TAB,PROTOCOL_METHOD,
                             nil];
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 获取连载标题信息列表
 */
- (void)fetchedArticleSerialTitleListWithIndex:(NSInteger)index
                                           uid:(NSString *)uid
                                     fouseType:(FouseType)fouseType
                                  conditionDic:(NSDictionary *)conditionDic
                                      callBack:(dataCallBackBlock)callBack
{
    NSLog(@"%s protocol:%@ method:%@ index:%lu uid:%@", __func__, ARTICLE_PROTOCOL, ARTICLE_SERIAL_TITLE_LIST, index, uid);
    if ([self.requestCallBackBlockDir objectForKey:ARTICLE_SERIAL_TITLE_LIST]) {
        NSLog(@"haved request fetchedArticleSerialTitleListWithIndex, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:ARTICLE_SERIAL_TITLE_LIST];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(fouseType), @"fouseType",
                                       @(index), @"index",
                                       uid,@"uid",nil];
    if (conditionDic) {
        [contentDic addEntriesFromDictionary:conditionDic];
    }
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_SERIAL_TITLE_LIST,PROTOCOL_METHOD,
                             nil];
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 获取关注的作者列表
 */
- (void)fetchedUserInfoListWithIndex:(NSInteger)index fouseType:(FouseType)fouseType
{
    
}

/*
 * @brief 获取最新文章(普通/专题/连载)列表,
 * @parme tabid专题/连载某标题tabid的最新
 *  uid 为空代表全部
 */
- (void)fetchedNewArticleListWithIndex:(NSInteger)index
                                   uid:(NSString *)uid
                           articleType:(ArticleType)articleType
                                 tabid:(NSInteger)tabid
                          conditionDic:(NSDictionary *)conditionDic
                              callBack:(dataCallBackBlock)callBack
{
    NSLog(@"%s protocol:%@ method:%@ index:%lu uid:%@", __func__, ARTICLE_PROTOCOL, ARTICLE_NEW_LIST, index, uid);
    if ([self.requestCallBackBlockDir objectForKey:ARTICLE_NEW_LIST]) {
        NSLog(@"haved request fetchedArticleTopicTitleListWithIndex, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:ARTICLE_NEW_LIST];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(tabid), @"tabid",
                                       @(articleType), @"articleType",
                                       @(index), @"index",
                                       uid,@"uid",nil];
    if (conditionDic) {
        [contentDic addEntriesFromDictionary:conditionDic];
    }
    NSLog(@"%s content:%@",__func__,contentDic);
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_NEW_LIST,PROTOCOL_METHOD,
                             nil];
    NSLog(@"%s head:%@",__func__,headDic);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

- (void)fetchedArticleTopicDetailWithTabid:(NSInteger)tabid callBack:(dataCallBackBlock)callBack
{
    tag++;
    NSLog(@"%s protocol:%@ method:%@ tabid:%lu", __func__, ARTICLE_PROTOCOL, ARTICLE_TOPIC_DETAIL_INFO, tabid);
    if ( [self.requestCallBackBlockDir objectForKey:[ARTICLE_TOPIC_DETAIL_INFO stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]] ) {
        NSLog(@"haved request fetchedArticleTopicDetailWithTabid, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:[ARTICLE_TOPIC_DETAIL_INFO stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(tag), @"tag",
                                       @(tabid), @"tabid", nil];

    NSLog(@"%s content:%@",__func__,contentDic);
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_TOPIC_DETAIL_INFO,PROTOCOL_METHOD,
                             nil];
    NSLog(@"%s head:%@",__func__,headDic);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 获取某连载详细信息
 */
- (void)fetchedArticleSerialDetailWithTabid:(NSInteger)tabid callBack:(dataCallBackBlock)callBack
{
    tag++;
    NSLog(@"%s protocol:%@ method:%@ tabid:%lu", __func__, ARTICLE_PROTOCOL, ARTICLE_SERIAL_DETAIL_INFO, tabid);
    if ( [self.requestCallBackBlockDir objectForKey:[ARTICLE_SERIAL_DETAIL_INFO stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]] ) {
        NSLog(@"haved request fetchedArticleSerialDetailWithTabid, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:[ARTICLE_SERIAL_DETAIL_INFO stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(tag), @"tag",
                                       @(tabid), @"tabid", nil];
    
    NSLog(@"%s content:%@",__func__,contentDic);
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_SERIAL_DETAIL_INFO,PROTOCOL_METHOD,
                             nil];
    NSLog(@"%s head:%@",__func__,headDic);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 获取文章详细信息
 */
- (void)fetchedArticleContentWithAtid:(NSString *)atid uid:(NSString *)uid  callBack:(dataCallBackBlock)callBack
{
    tag++;
    NSLog(@"%s protocol:%@ method:%@ ", __func__, ARTICLE_PROTOCOL, ARTICLE_ID_DETAIL_INFO);
    if ( [self.requestCallBackBlockDir objectForKey:[ARTICLE_ID_DETAIL_INFO stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]] ) {
        NSLog(@"haved request fetchedArticleContentWithAtid, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:[ARTICLE_ID_DETAIL_INFO stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(tag), @"tag",
                                       uid, @"uid",
                                       atid, @"atid", nil];
    
    NSLog(@"%s content:%@",__func__,contentDic);
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_ID_DETAIL_INFO,PROTOCOL_METHOD,
                             nil];
    NSLog(@"%s head:%@",__func__,headDic);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
    
}

/*
 * @brief 设置文章为喜欢的
 */
- (void)setArticleToLikeWithLikeStatus:(BOOL)likeStatus atid:(NSString *)atid uid:(NSString *)uid callBack:(dataCallBackBlock)callBack
{
    tag++;
    NSLog(@"%s protocol:%@ method:%@ ", __func__, ARTICLE_PROTOCOL, ARTICLE_SET_LIKE);
    if ( [self.requestCallBackBlockDir objectForKey:[ARTICLE_SET_LIKE stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]] ) {
        NSLog(@"haved request setArticleToLikeWithAtid, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:[ARTICLE_SET_LIKE stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(likeStatus), @"likeStatus",
                                       @(tag), @"tag",
                                       uid, @"uid",
                                       atid, @"atid", nil];
    
    NSLog(@"%s content:%@",__func__,contentDic);
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_SET_LIKE,PROTOCOL_METHOD,
                             nil];
    NSLog(@"%s head:%@",__func__,headDic);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 文章喜欢未读数
 */
- (void)fetchedLikeNotReviewCount:(NSString *)uid callBack:(dataCallBackBlock)callBack
{
    tag++;
    NSLog(@"%s protocol:%@ method:%@ ", __func__, ARTICLE_PROTOCOL, ARTICLE_LIKE_NOT_REVIEW_COUNT);
    if ( [self.requestCallBackBlockDir objectForKey:[ARTICLE_LIKE_NOT_REVIEW_COUNT stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]] ) {
        NSLog(@"haved request setArticleToLikeWithAtid, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:[ARTICLE_LIKE_NOT_REVIEW_COUNT stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(tag), @"tag",
                                       uid, @"uid", nil];
    
    NSLog(@"%s content:%@",__func__,contentDic);
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_LIKE_NOT_REVIEW_COUNT,PROTOCOL_METHOD,
                             nil];
    NSLog(@"%s head:%@",__func__,headDic);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 创建专题/连载
 */
- (void)createTopicOrSerialTabWithUid:(NSString *)uid
                                 type:(ArticleType)type
                                title:(NSString *)title
                          description:(NSString *)description
                                  pic:(NSString *)pic
                              allBack:(dataCallBackBlock)callBack
{
    tag++;
    NSLog(@"%s protocol:%@ method:%@ ", __func__, ARTICLE_PROTOCOL, ARTICLE_CREATE_TOPIC_OR_SERIAL_TAB);
    if ( [self.requestCallBackBlockDir objectForKey:[ARTICLE_CREATE_TOPIC_OR_SERIAL_TAB stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]] ) {
        NSLog(@"haved request createTopicOrSerialTabWithUid, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:[ARTICLE_CREATE_TOPIC_OR_SERIAL_TAB stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(tag), @"tag",
                                       uid, @"uid",
                                       @(type), @"type",
                                       title, @"title",
                                       description, @"description",
                                       pic, @"pic",
                                       nil];
    
    NSLog(@"%s content:%@",__func__,contentDic);
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_CREATE_TOPIC_OR_SERIAL_TAB,PROTOCOL_METHOD,
                             nil];
    NSLog(@"%s head:%@",__func__,headDic);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 按热度获取推荐文章(普通/专题/连载)列表
 */
- (void)fetchedRecommendByHotArticleListtWithIndex:(NSInteger)index uid:(NSString *)uid articleType:(ArticleType)articleType fouseType:(FouseType)fouseType callBack:(dataCallBackBlock)callBack
{
    tag++;
    NSLog(@"%s protocol:%@ method:%@ ", __func__, ARTICLE_PROTOCOL, ARTICLE_RECOMMEND_BY_HOT_LIST);
    if ( [self.requestCallBackBlockDir objectForKey:[ARTICLE_RECOMMEND_BY_HOT_LIST stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]] ) {
        NSLog(@"haved request fetchedRecommendByHotArticleListtWithIndex, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:[ARTICLE_RECOMMEND_BY_HOT_LIST stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(tag), @"tag",
                                       uid, @"uid",
                                       @(articleType), @"articleType",
                                       @(index), @"index",
                                       @(fouseType), @"fouseType",
                                       nil];
    
    NSLog(@"%s content:%@",__func__,contentDic);
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_RECOMMEND_BY_HOT_LIST,PROTOCOL_METHOD,
                             nil];
    NSLog(@"%s head:%@",__func__,headDic);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 按基于用户推荐算法获取推荐文章(普通/专题/连载)列表
 */
- (void)fetchedRecommendByUserCFArticleListtWithIndex:(NSInteger)index uid:(NSString *)uid articleType:(ArticleType)articleType callBack:(dataCallBackBlock)callBack
{
    tag++;
    NSLog(@"%s protocol:%@ method:%@ ", __func__, ARTICLE_PROTOCOL, ARTICLE_RECOMMEND_BY_USERCF_LIST);
    if ( [self.requestCallBackBlockDir objectForKey:[ARTICLE_RECOMMEND_BY_USERCF_LIST stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]] ) {
        NSLog(@"haved request fetchedRecommendByUserCFArticleListtWithIndex, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:[ARTICLE_RECOMMEND_BY_USERCF_LIST stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(tag), @"tag",
                                       uid, @"uid",
                                       @(articleType), @"articleType",
                                       @(index), @"index",
                                       nil];
    
    NSLog(@"%s content:%@",__func__,contentDic);
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_RECOMMEND_BY_USERCF_LIST,PROTOCOL_METHOD,
                             nil];
    NSLog(@"%s head:%@",__func__,headDic);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 获取文章是否喜欢
 */
- (void)fetchedArticleLikeStatusWithAtid:(NSString *)atid uid:(NSString *)uid callBack:(dataCallBackBlock)callBack
{
    tag++;
    NSLog(@"%s protocol:%@ method:%@ ", __func__, ARTICLE_PROTOCOL, ARTICLE_LIKE_STATUS);
    if ( [self.requestCallBackBlockDir objectForKey:[ARTICLE_LIKE_STATUS stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]] ) {
        NSLog(@"haved request fetchedArticleLikeStatusWithAtid, wait after");
        return ;
    } else {
        [self.requestCallBackBlockDir setValue:callBack forKey:[ARTICLE_LIKE_STATUS stringByAppendingString:[NSString stringWithFormat:@"%lu",tag]]];
    }
    NSMutableDictionary *contentDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       @(tag), @"tag",
                                       uid, @"uid",
                                       atid, @"atid",
                                       nil];
    
    NSLog(@"%s content:%@",__func__,contentDic);
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                             ARTICLE_PROTOCOL, PROTOCOL_NAME,
                             ARTICLE_LIKE_STATUS,PROTOCOL_METHOD,
                             nil];
    NSLog(@"%s head:%@",__func__,headDic);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}

/*
 * @brief 获取推荐文章(普通/专题/连载)列表
 */
- (void)fetchedRecommendArticleListtWithIndex:(NSInteger)index articleType:(ArticleType)articleType fouseType:(FouseType)fouseType
{
    
}

/*
 * @brief 获取推荐文章(普通/专题/连载)列表, tabid
 */
- (void)fetchedRecommendArticleListtWithIndex:(NSInteger)index articleType:(ArticleType)articleType tabid:(NSInteger)tabid fouseType:(FouseType)fouseType
{
    
}

- (void)connectioned
{
    
}

- (void)connectionError:(NSError *)err
{
    NSLog(@"%s 链接失败，移除请求操作", __func__);
    [self.requestCallBackBlockDir removeAllObjects];
    
}

- (void)receiveData:(BaseSocketPackage *)pg
{
    NSLog(@"%s receiveData head:%@ content:%@", __func__, pg.head.headData,pg.content.contentData);
    NSDictionary *headDic = pg.head.headData;
    NSDictionary *contentDic = pg.content.contentData;
    if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_PROTOCOL_TAG] ) {
        [self callBackToMain:pg method:ARTICLE_PROTOCOL_TAG];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_PROTOCOL_ADD_TAG] ) {
        [self callBackToMain:pg method:ARTICLE_PROTOCOL_ADD_TAG];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_TOPIC_TITLE_LIST] ) {
        [self callBackToMain:pg method:ARTICLE_TOPIC_TITLE_LIST];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_UPLOAD] ){
        [self callBackToMain:pg method:ARTICLE_UPLOAD];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_SET_TAGS] ) {
        [self callBackToMain:pg method:ARTICLE_SET_TAGS];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_SET_TAB] ) {
        [self callBackToMain:pg method:ARTICLE_SET_TAB];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_SERIAL_TITLE_LIST] ) {
        [self callBackToMain:pg method:ARTICLE_SERIAL_TITLE_LIST];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_NEW_LIST] ) {
        [self callBackToMain:pg method:ARTICLE_NEW_LIST];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_TOPIC_DETAIL_INFO] ) {
        [self callBackToMain:pg method:[ARTICLE_TOPIC_DETAIL_INFO stringByAppendingString:[NSString stringWithFormat:@"%lu",[[contentDic objectForKey:@"tag"] integerValue]]]];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_SERIAL_DETAIL_INFO] ) {
        [self callBackToMain:pg method:[ARTICLE_SERIAL_DETAIL_INFO stringByAppendingString:[NSString stringWithFormat:@"%lu",[[contentDic objectForKey:@"tag"] integerValue]]]];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_ID_DETAIL_INFO] ) {
        [self callBackToMain:pg method:[ARTICLE_ID_DETAIL_INFO stringByAppendingString:[NSString stringWithFormat:@"%lu",[[contentDic objectForKey:@"tag"] integerValue]]]];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_SET_LIKE] ) {
        [self callBackToMain:pg method:[ARTICLE_SET_LIKE stringByAppendingString:[NSString stringWithFormat:@"%lu",[[contentDic objectForKey:@"tag"] integerValue]]]];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_LIKE_NOT_REVIEW_COUNT] ) {
        [self callBackToMain:pg method:[ARTICLE_LIKE_NOT_REVIEW_COUNT stringByAppendingString:[NSString stringWithFormat:@"%lu",[[contentDic objectForKey:@"tag"] integerValue]]]];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_CREATE_TOPIC_OR_SERIAL_TAB] ) {
        [self callBackToMain:pg method:[ARTICLE_CREATE_TOPIC_OR_SERIAL_TAB stringByAppendingString:[NSString stringWithFormat:@"%lu",[[contentDic objectForKey:@"tag"] integerValue]]]];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_RECOMMEND_BY_HOT_LIST] ) {
        [self callBackToMain:pg method:[ARTICLE_RECOMMEND_BY_HOT_LIST stringByAppendingString:[NSString stringWithFormat:@"%lu",[[contentDic objectForKey:@"tag"] integerValue]]]];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_RECOMMEND_BY_USERCF_LIST] ) {
        [self callBackToMain:pg method:[ARTICLE_RECOMMEND_BY_USERCF_LIST stringByAppendingString:[NSString stringWithFormat:@"%lu",[[contentDic objectForKey:@"tag"] integerValue]]]];
    } else if ( [[headDic objectForKey:PROTOCOL_METHOD] isEqualToString:ARTICLE_LIKE_STATUS] ) {
        [self callBackToMain:pg method:[ARTICLE_LIKE_STATUS stringByAppendingString:[NSString stringWithFormat:@"%lu",[[contentDic objectForKey:@"tag"] integerValue]]]];
    }
}

- (void)callBackToMain:(BaseSocketPackage *)pg method:(NSString *)method
{
    dispatch_async(dispatch_get_main_queue(), ^{
        dataCallBackBlock callback =[self.requestCallBackBlockDir objectForKey:method];
        NSDictionary *contentDic = pg.content.contentData;
        DataCallBackStatus status = DataCallBackStatusFail;
        if ([[contentDic objectForKey:@"status"] isEqualToString:@"success"]) {
            status = DataCallBackStatusSuccess;
        }
        if (callback) {
            callback(status,pg);
        }
        [self.requestCallBackBlockDir removeObjectForKey:method];
    });
}

- (void)disConnection
{
    NSLog(@"%s 失去链接，移除请求操作", __func__);
    [self.requestCallBackBlockDir removeAllObjects];
}

@end
