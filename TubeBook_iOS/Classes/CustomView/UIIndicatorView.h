//
//  UIIndicatorView.h
//  TubeBook_iOS
//
//  Created by 柯建芳 on 2018/1/16.
//  Copyright © 2018年 柯建芳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIIndicatorView : UIScrollView

- (instancetype)initUIIndicatorView:(UIColor *)indicatorColor font:(UIFont *)font;
- (void)addIndicatorItemByString:(NSString *)item;
- (CGFloat)getUIHeight;

@end
