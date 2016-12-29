//
//  UserCommentLabelModel.h
//  sishi
//
//  Created by likeSo on 2016/12/28.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserCommentLabelModel : NSObject
/**
 *  标签名称
 */
@property(nonatomic,strong)NSString *labelName;

/**
 *  该标签的评价数量
 */
@property(nonatomic,assign)NSInteger count;

/**
 *  字符串描述
 */
@property(nonatomic,strong)NSString *labelDescription;


@end
