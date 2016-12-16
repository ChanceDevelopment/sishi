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
        self.labelName.textColor = [UIColor scrollViewTexturedBackgroundColor];
        self.labelName.textAlignment = NSTextAlignmentCenter;
        self.labelName.backgroundColor = [UIColor whiteColor];
        self.labelName.layer.cornerRadius = 2;
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
- (void)setLabelModel:(LabelSelectViewModel *)labelModel {
    _labelModel = labelModel;
    
    self.labelName.text = labelModel.labelString;
    self.labelName.font = labelModel.font;
    if (labelModel.isSelected) {
        self.labelName.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        self.labelName.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:1].CGColor;
    }
}
@end
