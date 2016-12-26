//
//  ImageAdderViewCell.m
//  sishi
//
//  Created by likeSo on 2016/12/16.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "ImageAdderViewCell.h"
#import "Masonry.h"
#import "ApiUtils.h"

@interface ImageAdderViewCell ()
/**
 *
 */
@property(nonatomic,strong)UIImageView *imageView;

/**
 *  删除图片 按钮
 */
@property(nonatomic,strong)UIButton *deleteBtn;

@end

@implementation ImageAdderViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.imageView.layer.cornerRadius = 5;
        self.imageView.clipsToBounds = YES;
        self.imageView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [self.deleteBtn addTarget:self action:@selector(onRemoveImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteBtn];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)setImageLink:(NSString *)imageLink {
    _imageLink = imageLink;
    self.deleteBtn.hidden = YES;
    if (![imageLink hasPrefix:@"http"] || ![imageLink hasPrefix:@"HTTP"]) {
        imageLink = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],imageLink];
    }
    NSURL *imageUrl = [NSURL URLWithString:imageLink];
    [self.imageView sd_setImageWithURL:imageUrl];
}

- (void)onRemoveImage:(UIButton *)btn {
    if (self.onRemoveImage) {
        self.onRemoveImage();
    }
}

@end
