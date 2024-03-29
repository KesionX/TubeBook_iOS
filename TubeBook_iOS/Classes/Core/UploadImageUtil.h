//
//  UploadImageUtil.h
//  TubeBook_iOS
//
//  Created by 柯建芳 on 2018/3/11.
//  Copyright © 2018年 柯建芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// eg：message
//{
//    fileName = "1523202180.jpg";
//    message = "{'state':1,'msg':'success'}\n";
//}
typedef void(^uploadSuccess)(NSDictionary *message);
typedef void(^uploadFail)(NSError *error);

@interface UploadImageUtil : NSObject

+ (void)uploadImage:(UIImage *)mImage success:(uploadSuccess)successCallback fail:(uploadFail)failCallback;

@end
