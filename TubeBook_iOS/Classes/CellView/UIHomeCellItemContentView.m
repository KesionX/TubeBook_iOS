//
//  UIHomeCellItemContentView.m
//  TubeBook_iOS
//
//  Created by 柯建芳 on 2018/1/21.
//  Copyright © 2018年 柯建芳. All rights reserved.
//

#import "UIHomeCellItemContentView.h"
#import "CKMacros.h"
#import "Masonry.h"

@implementation UIHomeCellItemContentView

- (instancetype)initUIHomeCellItemContentView:(BOOL)isHaveImage
{
    self = [super init];
    if (self) {
        self.isHaveImage = isHaveImage;
        [self addViewAndConstraint];
    }
    return self;
}

- (instancetype)initUIHomeCellItemContentView:(NSString *)contentUrl title:(NSString *)title contentDescription:(NSString *)contentDescription isHaveImage:(BOOL)isHaveImage;
{
    self = [super init];
    if (self) {
        self.contentUrl = contentUrl;
        self.title = title;
        self.contentDescription = contentDescription;
        self.isHaveImage = isHaveImage;
        [self addViewAndConstraint];
    }
    return self;
}

- (void)addViewAndConstraint
{
    if (self.isHaveImage) {
        [self addSubview:self.contentImageView];
    }
    [self addSubview:self.titleLable];
    [self addSubview:self.descriptionLable];
    if (self.isHaveImage) {
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(kCELL_MARGIN);
            make.right.mas_equalTo(self).offset(-kCELL_MARGIN);
            make.top.equalTo(self).offset(4);
            make.height.mas_equalTo(88);
        }];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentImageView.mas_bottom).offset(8);
            make.left.mas_equalTo(self).offset(kCELL_MARGIN+8);
            make.right.mas_equalTo(self).offset(-kCELL_MARGIN);
            make.height.mas_equalTo(16);
        }];
        [self.descriptionLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLable.mas_bottom).offset(4);
            make.left.mas_equalTo(self).offset(kCELL_MARGIN);
            make.right.mas_equalTo(self).offset(-kCELL_MARGIN);
            make.height.mas_equalTo(32);
        }];
    } else {
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(8);
            make.left.mas_equalTo(self).offset(kCELL_MARGIN+8);
            make.height.mas_equalTo(16);
        }];
        [self.descriptionLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLable.mas_bottom).offset(4);
            make.left.mas_equalTo(self).offset(kCELL_MARGIN);
            make.right.mas_equalTo(self).offset(-kCELL_MARGIN);
            make.height.mas_equalTo(32);
        }];
    
    }
}

- (CGFloat)getUIHeight
{
    if (self.isHaveImage) {
        return 156;
    }
    return 60;
}

+ (CGFloat)getUIHeight:(BOOL)isHaveImage
{
    if (isHaveImage) {
        return 156;
    }
    return 60;
}

#pragma mark - get
- (UIImageView *)contentImageView
{
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        _contentImageView.layer.borderColor = kTAB_TEXT_COLOR.CGColor;
        _contentImageView.layer.borderWidth = 0.5f;
        _contentImageView.backgroundColor = HEXCOLOR(0xf8f8f8);
    }
    return _contentImageView;
}

- (UILabel *)titleLable
{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = kTEXTCOLOR;
        _titleLable.font = Font(17);
        _titleLable.text = @"titleLable";
    }
    return _titleLable;
}

- (UILabel *)descriptionLable
{
    if (!_descriptionLable) {
        _descriptionLable = [[UILabel alloc] init];
        _descriptionLable.textColor = kTAB_TEXT_COLOR;
        _descriptionLable.font = Font(12);
        _descriptionLable.text = @"desc riptionLableBKBBKBKJBKJBKBKJBKJBKJBKAGGAJGAKAHKHAKHKJAKHAKJAKJHKJAHHKJAHKJAHKHAKHAKJHAKJHAKHAKHAK";
        _descriptionLable.numberOfLines = 0;

        _descriptionLable.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _descriptionLable;
}



@end
