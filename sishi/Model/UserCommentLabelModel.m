//
//  UserCommentLabelModel.m
//  sishi
//
//  Created by likeSo on 2016/12/28.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "UserCommentLabelModel.h"

@implementation UserCommentLabelModel


- (NSString *)labelDescription {
    return [NSString stringWithFormat:@"%@  %ld",self.labelName,(long)self.count];
}
@end
