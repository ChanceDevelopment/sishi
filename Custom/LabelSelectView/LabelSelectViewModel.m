//
//  LabelSelectViewModel.m
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "LabelSelectViewModel.h"

@implementation LabelSelectViewModel

- (instancetype)initWithLabelString:(NSString *)label font:(UIFont *)font{
    if (self = [super init]) {
        self.labelString = label;
        self.font = font;
        CGSize contentSize = [label boundingRectWithSize:
                              CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName:font}
                                                 context:nil].size;
        self.itemSize = CGSizeMake(contentSize.width + 10, contentSize.height + 5);
    }
    return self;
}

@end
