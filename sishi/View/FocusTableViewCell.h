//
//  FocusTableViewCell.h
//  sishi
//
//  Created by likeSo on 2016/12/16.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserFollowListModel.h"

typedef void(^FocusTableViewCellCallBack)(UserFollowListModel *model);

@interface FocusTableViewCell : UITableViewCell
/**
 *  列表页面Mode
 */
@property(nonatomic,strong)UserFollowListModel *model;

/**
 *  点击
 */
@property(nonatomic,copy)FocusTableViewCellCallBack onContact;

@end
