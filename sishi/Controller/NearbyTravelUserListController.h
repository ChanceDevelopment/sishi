//
//  NearbyTravelUserListController.h
//  sishi
//
//  Created by likeSo on 2016/12/29.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FocusTableViewCell.h"

/**
 "附近待出行"列表界面
 */
@interface NearbyTravelUserListController : UIViewController

/**
 *  数据源数组,上层页面获取数据之后传入
 */
//@property(nonatomic,copy)NSArray <UserFollowListModel *>* nearbyUserList;

/**
 *  兴趣标签
 */
@property(nonatomic,copy)NSString *hobbys;


@end
