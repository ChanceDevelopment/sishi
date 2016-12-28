//
//  AskingTableViewCell.h
//  sishi
//
//  Created by likeSo on 2016/12/28.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripListModel.h"

typedef void(^AskingCellButtonClickCallback)(TripListModel *model);

/**
 邀约 单元格
 */
@interface AskingTableViewCell : UITableViewCell
/**
 *  设置单元格信息Model
 */
@property(nonatomic,strong)TripListModel *tripModel;

/**
 *  "约Ta" 按钮点击时回调
 */
@property(nonatomic,copy)AskingCellButtonClickCallback onContact;

@end
