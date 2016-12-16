//
//  LabelSelectViewCell.m
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "LabelSelectViewCell.h"

@interface LabelSelectViewCell ()

/**
 *  标签名称Label
 */
@property(nonatomic,strong)UILabel *labelName;


@end

@implementation LabelSelectViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.labelName = [[UILabel alloc]initWithFrame:CGRectZero];
        self.labelName.font = [UIFont systemFontOfSize:13];
        self.labelName.textAlignment = NSTextAlignmentCenter;
        self.labelName.backgroundColor = [UIColor whiteColor];
        self.labelName.layer.cornerRadius = 3;
        self.labelName.clipsToBounds = YES;
        self.labelName.layer.borderWidth = 1;
        self.labelName.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithWhite:0.7 alpha:1]);
        [self.contentView addSubview:self.labelName];
        [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(2, 2, 2, 2));
        }];
    }
    return self;
}

- (void)setLabelString:(NSString *)labelString {
    _labelString = labelString;
    self.labelName.text = labelString;
}

@end
