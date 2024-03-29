//
//  LoginManager.m
//  TubeBook_iOS
//
//  Created by 柯建芳 on 2018/2/25.
//  Copyright © 2018年 柯建芳. All rights reserved.
//

#import "LoginManager.h"
#import "BaseSocketPackage.h"
#import "ProtocolConst.h"
#import "TubeLinkManager.h"

@interface LoginManager () <TubeDateDelegate>

@property (nonatomic, strong) TubeServerDataSDK *tubeServer;
@property (nonatomic, weak) id<TubeLoginDelegate> delegate;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *pass;
@property (nonatomic, assign) BOOL isSuccess;

@end

@implementation LoginManager

- (void)dealloc
{
    [self.tubeServer removeListenerDelegatProcotolName:@"Login"];
    self.delegate = nil;
}
    
- (instancetype)initLoginManager:(TubeServerDataSDK *)tubeServer
{
    self = [super init];
    if (self) {
        self.tubeServer = tubeServer;
        [self.tubeServer addListenerDelegate:self procotolName:@"Login"];
    }
    return self;
}

- (void)login:(NSString *)account pass:(NSString *)pass
{
    self.isSuccess = NO;
    self.account = account;
    self.pass = account;
    NSDictionary *contentDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                account, @"account",
                                pass, @"pass", nil];
    NSDictionary *headDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         @"Login", PROTOCOL_NAME,
                          nil];
    NSLog(@"%s account : %@",__func__, account);
    BaseSocketPackage *pg = [[BaseSocketPackage alloc] initWithHeadDic:headDic contentDic:contentDic];
    [self.tubeServer writeData:pg.data];
}
    
- (void)addListener:(id<TubeLoginDelegate>) delegate{
    self.delegate = delegate;
}
    
- (void)connectioned
{
    if (self.isSuccess) {
        [self login:self.account pass:self.pass];
    }
}
    
- (void)connectionError:(NSError *)err
{
    
}
    
- (void)receiveData:(BaseSocketPackage *)pg
{
    NSDictionary *dic =  pg.content.contentData;
    NSString *state = [dic objectForKey:@"State-Login"];
    NSLog(@"%s %@",__func__, dic);
    if ([state isEqualToString:@"success"]) {
        self.isSuccess = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginSuccess:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
              [self.delegate loginSuccess:nil];
            });
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(loginFail:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate loginFail:nil];
            });
        }
    }
}
    
- (void)disConnection
{
    
}

@end
